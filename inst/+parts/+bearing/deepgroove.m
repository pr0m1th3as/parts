## Copyright (C) 2026 Andreas Bertsatos <abertsatos@biol.uoa.gr>
##
## This file is part of the parts package for GNU Octave.
##
## This program is free software; you can redistribute it and/or modify it under
## the terms of the GNU General Public License as published by the Free Software
## Foundation; either version 3 of the License, or (at your option) any later
## version.
##
## This program is distributed in the hope that it will be useful, but WITHOUT
## ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
## FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
## details.
##
## You should have received a copy of the GNU General Public License along with
## this program; if not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn  {parts} {@var{B} =} parts.bearing.deepgroove (@qcode{'data'})
## @deftypefnx {parts} {@var{B} =} parts.bearing.deepgroove (@qcode{'data'}, @var{DESIGNATION})
## @deftypefnx {parts} {@var{S} =} parts.bearing.deepgroove (@qcode{'solid'}, @var{DESIGNATION})
##
## Single row deep groove ball bearings from the catalogue.
##
## @code{@var{B} = parts.bearing.deepgroove (@qcode{'data'})} returns every
## bearing in the catalogue as a table, one row per bearing, sorted by bore,
## then outside diameter, then width.
## @code{@var{B} = parts.bearing.deepgroove (@qcode{'data'},
## @var{DESIGNATION})} returns the one bearing named, such as @qcode{'6205'}
## or @qcode{'61930 MA'}.  Nothing is built.
##
## @code{@var{S} = parts.bearing.deepgroove (@qcode{'solid'},
## @var{DESIGNATION})} builds the bearing as a @code{solid.Shape}, its axis
## on the @math{z} axis, one face on the @math{xy} plane and the other at
## @math{z} = @var{B}: the inner and the outer ring, each with its
## raceway, and the balls between them, each a solid of its own; the cage
## is left out.  The catalogue gives no internal geometry, so the shape
## takes the proportions of the type: balls
## of diameter @code{Dw = min (0.3*(D - d), 0.8*B)} on the pitch circle
## @code{(d + D)/2}, as many as fill 60 per cent of it; each ring stops
## @code{0.3*Dw} short of the pitch circle, with a groove of radius
## @code{0.52*Dw}, so that the balls run free; the outer corners of the
## rings are rounded to @var{r}.  It shows the bearing; it does not stand
## for the maker's internal design.
##
## The table has these variables, each with its unit and its description,
## which @code{summary (@var{B})} lists; lengths are in millimetres, loads
## in newtons:
##
## @multitable @columnfractions 0.18 0.82
## @item @code{designation} @tab the designation, as SKF prints it
## @item @code{d} @tab bore diameter
## @item @code{D} @tab outside diameter
## @item @code{B} @tab width
## @item @code{r} @tab smallest chamfer of the rings, @math{r_{1,2}} min
## @item @code{da} @tab smallest diameter of a shaft shoulder,
## @math{d_a} min
## @item @code{Da} @tab largest diameter of a housing shoulder,
## @math{D_a} max
## @item @code{ra} @tab largest fillet radius at a shoulder, @math{r_a} max
## @item @code{C} @tab basic dynamic load rating
## @item @code{C0} @tab basic static load rating
## @item @code{nlim} @tab limiting speed, revolutions per minute
## @item @code{mass} @tab mass, in kilograms
## @item @code{source} @tab the catalogue page the values were read from
## @end multitable
##
## @subheading The catalogue
##
## The open bearings of the series 618, 619, 60 and 62, bores 4 to 380 mm,
## transcribed from the product tables of the SKF catalogue @cite{Rolling
## bearings} (PUB BU/P1 17000 EN), section 1.1, pages 260 to 302.  Where
## SKF lists a bearing only with a brass cage, such as @qcode{'61930 MA'},
## that is the one given.  The boundary dimensions follow ISO 15 and hold for
## any maker; the load ratings and the speed are SKF's, and another maker's
## differ.
##
## @seealso{parts.screw.cap, parts.dowel, parts.key}
## @end deftypefn

function OUT = deepgroove (MODE, DESIGNATION)

  if (nargin < 1 || ! ischar (MODE)
      || ! any (strcmp (MODE, {'data', 'solid'})))
    error ("parts.bearing.deepgroove: MODE must be 'data' or 'solid'.");
  endif
  if (strcmp (MODE, 'solid') && nargin < 2)
    error ("parts.bearing.deepgroove: a solid needs a DESIGNATION.");
  endif

  B = catalogue ();
  if (nargin < 2)
    OUT = B;
    return;
  endif
  if (! ischar (DESIGNATION) || ! isrow (DESIGNATION))
    error ("parts.bearing.deepgroove: DESIGNATION must be a character vector.");
  endif
  B = B(strcmp (B.designation, DESIGNATION), :);
  if (height (B) == 0)
    error ("parts.bearing.deepgroove: no bearing '%s' in the catalogue.", ...
           DESIGNATION);
  endif
  if (strcmp (MODE, 'data'))
    OUT = B;
    return;
  endif

  ## The rings, grooved, and the balls, in the proportions of the type
  dm = (B.d + B.D) / 2;
  Dw = min (0.3 * (B.D - B.d), 0.8 * B.B);
  ri = B.d / 2;
  ro = B.D / 2;
  a = dm / 2 - 0.3 * Dw;
  b = dm / 2 + 0.3 * Dw;
  f = min (B.r, (a - ri) / 3);
  U = geom.UCS ([0, -1, 0], [0, 0, 0]);
  inner = fillet (geom.Region ([ri, 0; a, 0; a, B.B; ri, B.B]), f);
  outer = fillet (geom.Region ([b, 0; ro, 0; ro, B.B; b, B.B]), f);
  inner.UCS = U;
  outer.UCS = U;
  mid = geom.UCS ([0, 0, 1], [0, 0, B.B / 2]);
  S = subtract (union (solid.revolve (inner), solid.revolve (outer)), ...
                solid.torus (dm / 2, 0.52 * Dw, mid));
  n = floor (0.6 * pi * dm / Dw);
  t = 2 * pi * (0:n-1) / n;
  balls = arrayfun (@(k) solid.sphere (Dw / 2, ...
                                       geom.UCS ([0, 0, 1], ...
                                                 [dm / 2 * cos(t(k)), ...
                                                  dm / 2 * sin(t(k)), ...
                                                  B.B / 2])), ...
                    1:n, 'UniformOutput', false);
  OUT = union (S, balls{:});

endfunction

## The catalogue as a table, built on the first call and kept for the session
function B = catalogue ()

  persistent C;
  if (! isempty (C))
    B = C;
    return;
  endif

  ## Designation, d, D, B, r, da, Da, ra, C, C0, nlim, mass, page
  T = {
    '618/4', [4, 9, 2.5, 0.1, 4.6, 8.4, 0.1, 423, 116, 85000, 0.0007, 260];
    '619/4', [4, 11, 4, 0.15, 4.8, 10.2, 0.1, 624, 180, 80000, 0.0017, 260];
    '618/5', [5, 11, 3, 0.15, 5.8, 10.2, 0.1, 468, 143, 75000, 0.0012, 260];
    '619/5', [5, 13, 4, 0.2, 6.4, 11.6, 0.2, 884, 335, 70000, 0.0025, 260];
    '618/6', [6, 13, 3.5, 0.15, 6.8, 12.2, 0.1, 715, 224, 67000, 0.002, 260];
    '619/6', [6, 15, 5, 0.2, 7.4, 13.6, 0.2, 884, 270, 63000, 0.0039, 260];
    '618/7', [7, 14, 3.5, 0.15, 7.8, 13.2, 0.1, 780, 260, 63000, 0.0022, 262];
    '619/7', [7, 17, 5, 0.3, 9, 15, 0.3, 1060, 375, 56000, 0.0049, 262];
    '618/8', [8, 16, 4, 0.2, 9.4, 14.6, 0.2, 819, 300, 56000, 0.003, 262];
    '619/8', [8, 19, 6, 0.3, 10, 17, 0.3, 1460, 465, 53000, 0.0071, 262];
    '618/9', [9, 17, 4, 0.2, 10.4, 15.6, 0.2, 871, 340, 53000, 0.0034, 262];
    '619/9', [9, 20, 6, 0.3, 11, 18, 0.3, 2340, 980, 50000, 0.0076, 262];
    '61800', [10, 19, 5, 0.3, 12, 17, 0.3, 1720, 830, 48000, 0.0053, 264];
    '61900', [10, 22, 6, 0.3, 12, 20, 0.3, 2700, 1270, 45000, 0.01, 264];
    '6000', [10, 26, 8, 0.3, 12, 24, 0.3, 4750, 1960, 40000, 0.019, 264];
    '6200', [10, 30, 9, 0.6, 14.2, 25.8, 0.6, 5400, 2360, 36000, 0.031, 264];
    '61801', [12, 21, 5, 0.3, 14, 19, 0.3, 1740, 915, 43000, 0.0063, 266];
    '61901', [12, 24, 6, 0.3, 14, 22, 0.3, 2910, 1460, 40000, 0.011, 266];
    '6001', [12, 28, 8, 0.3, 14, 26, 0.3, 5400, 2360, 38000, 0.021, 266];
    '6201', [12, 32, 10, 0.6, 16.2, 27.8, 0.6, 7280, 3100, 32000, 0.037, 266];
    '61802', [15, 24, 5, 0.3, 17, 22, 0.3, 1900, 1100, 38000, 0.0065, 266];
    '61902', [15, 28, 7, 0.3, 17, 26, 0.3, 4360, 2240, 34000, 0.016, 266];
    '6002', [15, 32, 9, 0.3, 17, 30, 0.3, 5850, 2850, 32000, 0.03, 266];
    '6202', [15, 35, 11, 0.6, 19.2, 30.8, 0.6, 8060, 3750, 28000, 0.045, 268];
    '61803', [17, 26, 5, 0.3, 19, 24, 0.3, 2030, 1270, 34000, 0.0075, 268];
    '61903', [17, 30, 7, 0.3, 19, 28, 0.3, 4620, 2550, 32000, 0.016, 268];
    '6003', [17, 35, 10, 0.3, 19, 33, 0.3, 6370, 3250, 28000, 0.038, 268];
    '6203', [17, 40, 12, 0.6, 21.2, 35.8, 0.6, 9950, 4750, 24000, 0.065, 268];
    '61804', [20, 32, 7, 0.3, 22, 30, 0.3, 4030, 2320, 28000, 0.018, 270];
    '61904', [20, 37, 9, 0.3, 22, 35, 0.3, 6370, 3650, 26000, 0.037, 270];
    '6004', [20, 42, 12, 0.6, 23.2, 38.8, 0.6, 9950, 5000, 24000, 0.067, 270];
    '6204', [20, 47, 14, 1, 25.6, 41.4, 1, 13500, 6550, 20000, 0.11, 270];
    '62/22', [22, 50, 14, 1, 27.6, 44.4, 1, 14000, 7650, 19000, 0.12, 270];
    '61805', [25, 37, 7, 0.6, 27, 35, 0.3, 4360, 2600, 24000, 0.022, 272];
    '61905', [25, 42, 9, 0.6, 27, 40, 0.3, 7020, 4300, 22000, 0.045, 272];
    '6005', [25, 47, 12, 0.6, 28.2, 43.8, 0.6, 11900, 6550, 20000, 0.078, 272];
    '6205', [25, 52, 15, 1, 30.6, 46.4, 1, 14800, 7800, 18000, 0.13, 272];
    '62/28', [28, 58, 16, 1, 33.6, 52, 1, 16800, 9500, 16000, 0.17, 272];
    '61806', [30, 42, 7, 0.3, 32, 40, 0.3, 4490, 2900, 20000, 0.025, 272];
    '61906', [30, 47, 9, 0.3, 32, 45, 0.3, 7280, 4550, 19000, 0.049, 272];
    '6006', [30, 55, 13, 1, 34.6, 50, 1, 13800, 8300, 17000, 0.12, 274];
    '6206', [30, 62, 16, 1, 35.6, 56, 1, 20300, 11200, 15000, 0.2, 274];
    '61807', [35, 47, 7, 0.3, 37, 45, 0.3, 4360, 3350, 18000, 0.029, 274];
    '61907', [35, 55, 10, 0.6, 38.2, 51, 0.6, 10800, 7800, 16000, 0.08, 274];
    '6007', [35, 62, 14, 1, 39.6, 57, 1, 16800, 10200, 15000, 0.15, 274];
    '6207', [35, 72, 17, 1.1, 42, 65, 1, 27000, 15300, 13000, 0.29, 274];
    '61808', [40, 52, 7, 0.3, 42, 50, 0.3, 4490, 3750, 16000, 0.032, 276];
    '61908', [40, 62, 12, 0.6, 43.2, 58, 0.6, 13800, 10000, 14000, 0.12, 276];
    '6008', [40, 68, 15, 1, 44.6, 63, 1, 17800, 11000, 14000, 0.19, 276];
    '6208', [40, 80, 18, 1.1, 47, 73, 1, 32500, 19000, 11000, 0.37, 276];
    '61809', [45, 58, 7, 0.3, 47, 56, 0.3, 6630, 6100, 14000, 0.04, 278];
    '61909', [45, 68, 12, 0.6, 48.2, 64, 0.6, 14000, 10800, 13000, 0.14, 278];
    '6009', [45, 75, 16, 1, 51, 69, 1, 22100, 14600, 12000, 0.24, 278];
    '6209', [45, 85, 19, 1.1, 52, 78, 1, 35100, 21600, 11000, 0.42, 278];
    '61810', [50, 65, 7, 0.3, 52, 63, 0.3, 6760, 6800, 13000, 0.052, 278];
    '61910', [50, 72, 12, 0.6, 54, 68, 0.6, 14600, 11800, 12000, 0.14, 278];
    '6010', [50, 80, 16, 1, 55, 75, 1, 22900, 16000, 11000, 0.26, 278];
    '6210', [50, 90, 20, 1.1, 57, 83, 1, 37100, 23200, 10000, 0.46, 278];
    '61811', [55, 72, 9, 0.3, 57, 70, 0.3, 9040, 8800, 12000, 0.083, 280];
    '61911', [55, 80, 13, 1, 60, 75, 1, 16500, 14000, 11000, 0.19, 280];
    '6011', [55, 90, 18, 1.1, 61, 84, 1, 29600, 21200, 10000, 0.38, 280];
    '6211', [55, 100, 21, 1.5, 64, 91, 1.5, 46200, 29000, 9000, 0.61, 280];
    '61812', [60, 78, 10, 0.3, 62, 76, 0.3, 11900, 11400, 11000, 0.11, 282];
    '61912', [60, 85, 13, 1, 65, 80, 1, 16500, 12000, 10000, 0.2, 282];
    '6012', [60, 95, 18, 1.1, 66, 89, 1, 30700, 23200, 9500, 0.41, 282];
    '6212', [60, 110, 22, 1.5, 69, 101, 1.5, 55300, 36000, 8000, 0.78, 282];
    '61813', [65, 85, 10, 0.6, 69, 81, 0.6, 12400, 12700, 10000, 0.13, 282];
    '61913', [65, 90, 13, 1, 70, 85, 1, 17400, 16000, 9500, 0.22, 282];
    '6013', [65, 100, 18, 1.1, 71, 94, 1, 31900, 25000, 9000, 0.44, 282];
    '6213', [65, 120, 23, 1.5, 74, 111, 1.5, 58500, 40500, 7500, 1, 284];
    '61814', [70, 90, 10, 0.6, 74, 86, 0.6, 12400, 13200, 9000, 0.14, 284];
    '61914', [70, 100, 16, 1, 75, 95, 1, 23800, 18300, 8500, 0.34, 284];
    '6014', [70, 110, 20, 1.1, 76, 104, 1, 39700, 31000, 8000, 0.61, 284];
    '6214', [70, 125, 24, 1.5, 79, 116, 1.5, 63700, 45000, 7000, 1.1, 284];
    '61815', [75, 95, 10, 1.3, 79, 91, 0.6, 12500, 10800, 8500, 0.15, 286];
    '61915', [75, 105, 16, 1.9, 80, 100, 1, 24200, 19300, 8000, 0.36, 286];
    '6015', [75, 115, 20, 1.1, 81, 109, 1, 41600, 33500, 7500, 0.65, 286];
    '6215', [75, 130, 25, 1.5, 84, 121, 1.5, 68900, 49000, 6700, 1.2, 286];
    '61816', [80, 100, 10, 1.3, 84, 96, 0.6, 12700, 11200, 8000, 0.15, 286];
    '61916', [80, 110, 16, 1, 85, 105, 1, 25100, 20400, 7500, 0.38, 286];
    '6016', [80, 125, 22, 1.1, 86, 119, 1, 49400, 40000, 7000, 0.86, 286];
    '6216', [80, 140, 26, 2, 91, 129, 2, 72800, 55000, 6000, 1.45, 286];
    '61817', [85, 110, 13, 1.9, 90, 105, 1, 19500, 16600, 7500, 0.26, 288];
    '61917', [85, 120, 18, 1.1, 91, 114, 1, 31900, 30000, 7000, 0.55, 288];
    '6017', [85, 130, 22, 1.1, 92, 123, 1, 52000, 43000, 6700, 0.9, 288];
    '6217', [85, 150, 28, 2, 96, 139, 2, 87100, 64000, 5600, 1.8, 288];
    '61818', [90, 115, 13, 1, 95, 110, 1, 19500, 17000, 7000, 0.28, 288];
    '61918', [90, 125, 18, 1.1, 96, 119, 1, 33200, 31500, 6700, 0.59, 288];
    '6018', [90, 140, 24, 1.5, 97, 133, 1.5, 60500, 50000, 6300, 1.15, 288];
    '6218', [90, 160, 30, 2, 101, 149, 2, 101000, 73500, 5300, 2.2, 288];
    '61819', [95, 120, 13, 1, 100, 115, 1, 19900, 17600, 6700, 0.29, 290];
    '61919', [95, 130, 18, 1.1, 101, 124, 1, 33800, 33500, 6300, 0.61, 290];
    '6019', [95, 145, 24, 1.5, 102, 138, 1.5, 63700, 54000, 6000, 1.2, 290];
    '6219', [95, 170, 32, 2.1, 107, 158, 2, 114000, 81500, 5000, 2.65, 290];
    '61820', [100, 125, 13, 1, 105, 120, 1, 17800, 18300, 6300, 0.3, 290];
    '61920', [100, 140, 20, 1.1, 106, 134, 1, 42300, 41500, 6000, 0.83, 290];
    '6020', [100, 150, 24, 1.5, 107, 143, 1.5, 63700, 54000, 5600, 1.25, 290];
    '6220', [100, 180, 34, 2.1, 112, 168, 2, 127000, 93000, 4800, 3.2, 290];
    '61821', [105, 130, 13, 1, 110, 125, 1, 20800, 19600, 6300, 0.31, 292];
    '61921', [105, 145, 20, 1.1, 111, 139, 1, 44200, 44000, 5600, 0.87, 292];
    '6021', [105, 160, 26, 2, 116, 149, 2, 76100, 65500, 5300, 1.6, 292];
    '6221', [105, 190, 36, 2.1, 117, 178, 2, 140000, 104000, 4500, 3.8, 292];
    '61822', [110, 140, 16, 1, 115, 135, 1, 28100, 26000, 5600, 0.47, 292];
    '61922', [110, 150, 20, 1.1, 116, 144, 1, 43600, 45000, 5600, 0.9, 292];
    '6022', [110, 170, 28, 2, 119, 161, 2, 85200, 73500, 5000, 1.95, 292];
    '6222', [110, 200, 38, 2.1, 122, 188, 2, 151000, 118000, 4300, 4.45, 292];
    '61824', [120, 150, 16, 1, 125, 145, 1, 29100, 28000, 5300, 0.51, 294];
    '61924', [120, 165, 22, 1.1, 126, 159, 1, 55300, 57000, 5000, 1.2, 294];
    '6024', [120, 180, 28, 2, 129, 171, 2, 88400, 80000, 4800, 2.1, 294];
    '6224', [120, 215, 40, 2.1, 132, 203, 2, 146000, 118000, 4000, 5.25, 294];
    '61826', [130, 165, 18, 1.1, 136, 159, 1, 37700, 43000, 4800, 0.75, 294];
    '61926', [130, 180, 24, 1.5, 137, 173, 1.5, 65000, 67000, 4500, 1.6, 294];
    '6026', [130, 200, 33, 2, 139, 191, 2, 112000, 100000, 4300, 3.3, 294];
    '6226', [130, 230, 40, 3, 144, 216, 2.5, 156000, 132000, 3600, 5.85, 294];
    '61828', [140, 175, 18, 2.5, 146, 169, 1, 39000, 46500, 4500, 0.82, 296];
    '61928', [140, 190, 24, 1.5, 147, 183, 1.5, 66300, 72000, 4300, 1.7, 296];
    '6028', [140, 210, 33, 2, 149, 201, 2, 111000, 108000, 4000, 3.45, 296];
    '6228', [140, 250, 42, 3, 154, 236, 2.5, 165000, 150000, 3400, 7.75, 296];
    '61830', [150, 190, 20, 2.5, 156, 184, 1, 48800, 61000, 4300, 1.2, 296];
    '61930 MA', [150, 210, 28, 2, 159, 201, 2, 88400, 93000, 5300, 3.05, 296];
    '6030', [150, 225, 35, 2.1, 160, 215, 2, 125000, 125000, 3800, 4.3, 296];
    '6230', [150, 270, 45, 3, 164, 256, 2.5, 174000, 166000, 3200, 10, 296];
    '61832', [160, 200, 20, 1.1, 166, 194, 1, 49400, 64000, 4000, 1.25, 296];
    '61932', [160, 220, 28, 2, 169, 211, 2, 92300, 98000, 3800, 2.7, 296];
    '6032', [160, 240, 38, 2.1, 169, 231, 2, 143000, 143000, 3600, 5.2, 296];
    '6232', [160, 290, 48, 3, 174, 276, 2.5, 186000, 186000, 3000, 13, 296];
    '61834', [170, 215, 22, 1.1, 176, 209, 1, 61800, 78000, 3600, 1.65, 298];
    '61934 MA', [170, 230, 28, 2, 179, 221, 2, 93600, 106000, 4800, 3.35, 298];
    '6034', [170, 260, 42, 2.1, 180, 250, 2, 168000, 173000, 3200, 7, 298];
    '6234', [170, 310, 52, 4, 187, 293, 3, 212000, 224000, 2800, 16, 298];
    '61836', [180, 225, 22, 1.1, 186, 219, 1, 62400, 81500, 3400, 1.75, 298];
    '61936', [180, 250, 33, 2, 189, 241, 2, 119000, 134000, 3200, 5, 298];
    '6036', [180, 280, 46, 2.1, 190, 270, 2, 190000, 200000, 3000, 9.1, 298];
    '6236', [180, 320, 52, 4, 197, 303, 3, 229000, 240000, 2600, 16, 298];
    '61838', [190, 240, 24, 1.5, 197, 233, 1.5, 76100, 98000, 3200, 2.25, 298];
    '61938', [190, 260, 33, 2, 199, 251, 2, 117000, 134000, 3200, 4.5, 298];
    '6038', [190, 290, 46, 2.1, 200, 280, 2, 195000, 216000, 3000, 9.55, 298];
    '6238', [190, 340, 55, 4, 207, 323, 3, 255000, 280000, 2400, 19.5, 298];
    '61840', [200, 250, 24, 1.5, 207, 243, 1.5, 76100, 102000, 3200, 2.35, 298];
    '61940', [200, 280, 38, 2.1, 210, 270, 2, 148000, 166000, 3000, 6.3, 298];
    '6040', [200, 310, 51, 2.1, 210, 300, 2, 216000, 245000, 2800, 12.5, 300];
    '6240', [200, 360, 58, 4, 217, 343, 3, 270000, 310000, 2200, 23.5, 300];
    '61844', [220, 270, 24, 1.5, 227, 263, 1.5, 78000, 110000, 2800, 2.55, 300];
    '61944', [220, 300, 38, 2.1, 230, 290, 2, 151000, 180000, 2600, 6.8, 300];
    '6044', [220, 340, 56, 3, 233, 327, 2.5, 247000, 290000, 2400, 16, 300];
    '6244', [220, 400, 65, 4, 237, 383, 3, 296000, 365000, 2000, 33.5, 300];
    '61848', [240, 300, 28, 2, 249, 291, 2, 108000, 150000, 2600, 3.9, 300];
    '61948', [240, 320, 38, 2.1, 250, 310, 2, 159000, 200000, 2400, 7.3, 300];
    '6048', [240, 360, 56, 3, 253, 347, 2.5, 255000, 315000, 2200, 17, 300];
    '6248 M', [240, 440, 72, 4, 257, 423, 3, 358000, 465000, 2600, 51, 300];
    '61852', [260, 320, 28, 2, 269, 311, 2, 111000, 163000, 2400, 4.15, 300];
    '61952', [260, 360, 46, 2.1, 270, 350, 2, 212000, 270000, 2200, 12, 300];
    '6052', [260, 400, 65, 4, 277, 383, 3, 291000, 375000, 2000, 25, 300];
    '6252 M', [260, 480, 80, 5, 280, 460, 4, 390000, 530000, 2400, 65.5, 300];
    '61856', [280, 350, 33, 2, 289, 341, 2, 138000, 200000, 2200, 6.25, 302];
    '61956', [280, 380, 46, 2.1, 291, 369, 2, 216000, 285000, 2000, 12, 302];
    '6056', [280, 420, 65, 4, 296, 404, 3, 302000, 405000, 1900, 26, 302];
    '6256 M', [280, 500, 80, 5, 300, 480, 4, 423000, 600000, 2200, 72, 302];
    '61860', [300, 380, 38, 2.1, 309, 371, 2, 172000, 245000, 2000, 8.9, 302];
    '61960', [300, 420, 56, 3, 313, 407, 2.5, 270000, 375000, 1900, 19, 302];
    '6060 M', [300, 460, 74, 4, 315, 445, 3, 358000, 500000, 2400, 44, 302];
    '6260 M', [300, 540, 85, 5, 320, 520, 4, 462000, 670000, 2000, 88.5, 302];
    '61864', [320, 400, 38, 2.1, 332, 388, 2, 172000, 255000, 1900, 9.5, 302];
    '61964 MA', [320, 440, 56, 3, 333, 427, 2.5, 276000, 400000, 2400, 25.5, 302];
    '6064 M', [320, 480, 74, 4, 335, 465, 3, 371000, 540000, 2200, 46, 302];
    '61868', [340, 420, 38, 2.1, 352, 408, 2, 178000, 275000, 1800, 10, 302];
    '61968 MA', [340, 460, 56, 3, 353, 447, 2.5, 281000, 425000, 2200, 26.5, 302];
    '6068 M', [340, 520, 82, 5, 360, 500, 4, 423000, 640000, 2200, 62, 302];
    '61872 MA', [360, 440, 38, 2.1, 372, 428, 2, 182000, 285000, 2200, 12, 302];
    '61972 MA', [360, 480, 56, 3, 373, 467, 2.5, 291000, 450000, 2200, 28, 302];
    '6072 M', [360, 540, 82, 5, 378, 522, 4, 442000, 695000, 1900, 64.5, 302];
    '61876 MA', [380, 480, 46, 2.1, 392, 468, 2, 242000, 390000, 2000, 20, 302];
    '61976 MA', [380, 520, 65, 4, 395, 505, 3, 338000, 540000, 1900, 40, 302];
    '6076 M', [380, 560, 82, 5, 400, 542, 4, 436000, 695000, 1800, 70.5, 302];
  };
  V = cell2mat (T(:,2));
  page = arrayfun (@(p) sprintf ("SKF 17000, p. %d", p), V(:,12), ...
                   'UniformOutput', false);
  C = table (T(:,1), V(:,1), V(:,2), V(:,3), V(:,4), V(:,5), V(:,6), V(:,7), ...
             V(:,8), V(:,9), V(:,10), V(:,11), page);
  C.Properties.VariableNames = {'designation', 'd', 'D', 'B', 'r', 'da', ...
                                'Da', 'ra', 'C', 'C0', 'nlim', 'mass', ...
                                'source'};
  C.Properties.VariableUnits = {'', 'mm', 'mm', 'mm', 'mm', 'mm', 'mm', ...
                                'mm', 'N', 'N', 'r/min', 'kg', ''};
  C.Properties.VariableDescriptions = {...
    'designation, as SKF prints it', ...
    'bore diameter', ...
    'outside diameter', ...
    'width', ...
    'smallest chamfer of the rings, r1,2 min', ...
    'smallest diameter of a shaft shoulder, da min', ...
    'largest diameter of a housing shoulder, Da max', ...
    'largest fillet radius at a shoulder, ra max', ...
    'basic dynamic load rating', ...
    'basic static load rating', ...
    'limiting speed', ...
    'mass', ...
    'catalogue page the values were read from'};
  C.Properties.Description = 'Single row deep groove ball bearings';
  B = C;

endfunction

%!test  # the whole catalogue, sorted by bore
%! B = parts.bearing.deepgroove ('data');
%! assert_equal (height (B), 174);
%! assert_equal (issorted (B.d), true);
%!test  # one bearing, its values as the catalogue prints them
%! B = parts.bearing.deepgroove ('data', '6205');
%! assert_equal ([B.d, B.D, B.B, B.r], [25, 52, 15, 1]);
%! assert_equal ([B.da, B.Da, B.ra], [30.6, 46.4, 1]);
%! assert_equal ([B.C, B.C0, B.nlim, B.mass], [14800, 7800, 18000, 0.13]);
%! assert_equal (B.source, {'SKF 17000, p. 272'});
%!test  # each variable carries its unit and description
%! B = parts.bearing.deepgroove ('data', '6205');
%! assert_equal (B.Properties.VariableUnits([2, 9, 11, 12]), ...
%!               {'mm', 'N', 'r/min', 'kg'});
%! assert_equal (B.Properties.VariableDescriptions{10}, ...
%!               'basic static load rating');
%!test  # the table describes the family
%! B = parts.bearing.deepgroove ('data', '6205');
%! assert_equal (B.Properties.Description, ...
%!               'Single row deep groove ball bearings');
%!test  # a page continued from the one before keeps its bore
%! B = parts.bearing.deepgroove ('data', '6006');
%! assert_equal ([B.d, B.D, B.B, B.C, B.C0], [30, 55, 13, 13800, 8300]);
%! assert_equal (B.source, {'SKF 17000, p. 274'});
%!test  # a bearing SKF lists only with a brass cage
%! B = parts.bearing.deepgroove ('data', '61930 MA');
%! assert_equal ([B.d, B.D, B.B, B.C], [150, 210, 28, 88400]);
%!test  # the four series are all there
%! B = parts.bearing.deepgroove ('data');
%! names = {'61805', '61905', '6005', '6205'};
%! assert_equal (all (ismember (names, B.designation)), true);
%!test  # every shoulder lies between bore and outside diameter
%! B = parts.bearing.deepgroove ('data');
%! assert_equal (all (B.d < B.da & B.da < B.Da & B.Da < B.D), true);
%!testif ; exist ('__occt__') == 3  # the shape is the two rings, B wide
%! S = parts.bearing.deepgroove ('solid', '6205');
%! assert_equal (bbox (S), [-26, -26, 0, 26, 26, 15], 1e-6);
%! assert_equal (isvalid (S), true);
%!testif ; exist ('__occt__') == 3  # two rings and eight balls for a 6205
%! S = parts.bearing.deepgroove ('solid', '6205');
%! assert_equal (numsolids (S), 10);
%!testif ; exist ('__occt__') == 3  # the smallest bearing builds too
%! S = parts.bearing.deepgroove ('solid', '618/4');
%! assert_equal (isvalid (S), true);

%!error<parts.bearing.deepgroove: MODE must be 'data' or 'solid'.> ...
%! parts.bearing.deepgroove ()
%!error<parts.bearing.deepgroove: MODE must be 'data' or 'solid'.> ...
%! parts.bearing.deepgroove ('6205')
%!error<parts.bearing.deepgroove: a solid needs a DESIGNATION.> ...
%! parts.bearing.deepgroove ('solid')
%!error<parts.bearing.deepgroove: DESIGNATION must be a character vector.> ...
%! parts.bearing.deepgroove ('data', 6205)
%!error<parts.bearing.deepgroove: no bearing '6205-2Z' in the catalogue.> ...
%! parts.bearing.deepgroove ('data', '6205-2Z')
