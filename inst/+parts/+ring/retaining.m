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
## @deftypefn  {parts} {@var{C} =} parts.ring.retaining (@qcode{'data'})
## @deftypefnx {parts} {@var{C} =} parts.ring.retaining (@qcode{'data'}, @var{D1})
## @deftypefnx {parts} {@var{S} =} parts.ring.retaining (@qcode{'solid'}, @var{D1})
## @deftypefnx {parts} {@dots{} =} parts.ring.retaining (@dots{}, @var{Name}, @var{Value})
##
## Retaining rings, with the grooves they sit in: for shafts, DIN 471, and
## for bores, DIN 472, each of the normal and the heavy type.
##
## @code{@var{C} = parts.ring.retaining (@qcode{'data'})} returns every
## retaining ring in the catalogue as a table, one row for each maker's
## article in each size, sorted by diameter.
## @code{@var{C} = parts.ring.retaining (@qcode{'data'}, @var{D1})} returns
## those for a shaft or bore of diameter @var{D1}: every article sold as
## that ring, each with its material and finish, and the groove to cut for
## it.  Nothing is built.
##
## @code{@var{S} = parts.ring.retaining (@qcode{'solid'}, @var{D1})} builds
## the ring as a @code{solid.Shape} whether or not anyone sells it, in any
## size its standard defines, free, as it is before fitting: lying on the
## @math{xy} plane, @var{s} thick, its axis on the @math{z} axis and its
## gap on the positive @math{x} axis.  @code{@var{S}.Name} holds the
## designation.
##
## Name/Value pairs:
##
## @table @asis
## @item @qcode{'Bore'}
## @code{true} for a ring for a bore, DIN 472, @code{false} for one for a
## shaft, DIN 471, the default for @qcode{'solid'}.  For @qcode{'data'} it
## keeps that kind only; without it both come.
##
## @item @qcode{'Heavy'}
## @code{true} for the heavy type, @code{false} for the normal one, the
## default for @qcode{'solid'}.  For @qcode{'data'} it keeps that type
## only; without it both come.
##
## @item @qcode{'Maker'}
## For @qcode{'data'}: only that maker's articles, such as
## @qcode{'REYHER'}, in any case.
##
## @item @qcode{'Detailed'}
## For @qcode{'solid'}: @code{true} builds the ring's form: the section
## narrowing from @var{b} opposite the gap to @var{b}/2 at the free ends,
## the two lugs @var{a} high across the ring with a hole of diameter
## @var{d5} in each, outwards for a shaft and inwards for a bore, and the
## gap between them as wide as a hole.  No source dimensions the taper, the
## lugs or the gap, which the standards leave to the maker, so these are a
## modelling choice.  By default (@code{false}) the ring is a flat ring
## @var{b} wide on @var{d3}, without a gap.
## @end table
##
## The table has these variables, each with its unit and its description,
## which @code{summary (@var{C})} lists; lengths are in millimetres:
##
## @multitable @columnfractions 0.16 0.84
## @item @code{designation} @tab designation of the standard, as in
## @qcode{'Retaining ring DIN 471 - 50 x 2'}
## @item @code{standard} @tab @qcode{'DIN 471'} or @qcode{'DIN 472'}
## @item @code{type} @tab @qcode{'normal'} or @qcode{'heavy'}
## @item @code{d1} @tab diameter of the shaft or the bore
## @item @code{s} @tab thickness of the ring, nominal
## @item @code{d3} @tab diameter of the free ring, nominal: inside for a
## shaft, outside for a bore
## @item @code{a} @tab radial height of the lugs, largest
## @item @code{b} @tab radial width of the ring opposite the gap, about
## @item @code{d5} @tab diameter of the holes in the lugs, smallest
## @item @code{d4} @tab diameter the fitted ring sweeps, the room it
## needs: outside for a shaft, inside for a bore; NaN where the sources give
## none
## @item @code{d2} @tab diameter of the groove, nominal
## @item @code{m} @tab width of the groove, smallest (H13)
## @item @code{t} @tab depth of the groove
## @item @code{n} @tab distance from the groove to the end of the shaft or
## bore, smallest
## @item @code{material} @tab @qcode{'spring steel'} or a stainless steel
## by its number, as @qcode{'1.4122'}
## @item @code{finish} @tab finish as the maker names it, as
## @qcode{'plain'} or @qcode{'zinc flake'}
## @item @code{maker} @tab maker
## @item @code{article} @tab maker's article number
## @item @code{source} @tab catalogue and page the article was read from
## @end multitable
##
## @subheading The catalogue
##
## Articles from REYHER, @cite{The Catalogue}, edition 2020.04, English,
## pages 89 to 91 (spring steel) and 469 to 470 (stainless steel): every
## article of the two standards in sizes they define.  Left out: the
## intermediate sizes REYHER sells outside the standards' tables.
##
## Dimensions of the rings and grooves from the tables of DIN 471:2011-04 and
## DIN 472:2011-10 as fasten.it reproduces them by permission of DIN, which
## set the sizes, read against the catalogues of Seeger-Orbis (2007) and Rotor
## Clip (2011) and REYHER's @cite{Technical Information} (2019, TI-91 to
## 97): every value but @var{d4} in at least two of them.  @var{d4} is
## REYHER's, a second source agreeing at about thirty sizes.  DIN 471 and
## DIN 472 are current in their editions of 2026-05; DIN 472's revises its
## tables in ways not read.
##
## @seealso{parts.key, parts.bearing.deepgroove}
## @end deftypefn

function OUT = retaining (MODE, varargin)

  if (nargin < 1 || ! ischar (MODE)
      || ! any (strcmp (MODE, {'data', 'solid'})))
    error ("parts.ring.retaining: MODE must be 'data' or 'solid'.");
  endif

  ## A diameter D1 leads the Name/Value pairs
  args = varargin;
  D1 = [];
  if (! isempty (args) && ! ischar (args{1}))
    D1 = args{1};
    args(1) = [];
    if (! isnumeric (D1) || ! isreal (D1) || ! isscalar (D1)
        || ! isfinite (D1) || D1 <= 0)
      error ("parts.ring.retaining: D1 must be a positive diameter.");
    endif
  endif
  if (strcmp (MODE, 'solid') && isempty (D1))
    error ("parts.ring.retaining: a solid needs a diameter D1.");
  endif

  bore = false;
  bybore = false;
  heavy = false;
  byheavy = false;
  maker = '';
  detailed = false;
  if (mod (numel (args), 2) != 0)
    error ("parts.ring.retaining: Name/Value arguments must come in pairs.");
  endif
  for ii = 1:2:numel (args)
    name = args{ii};
    val = args{ii+1};
    if (! ischar (name) || ! isrow (name))
      error ("parts.ring.retaining: option names must be character vectors.");
    endif
    switch (lower (name))
      case 'bore'
        if (! islogical (val) || ! isscalar (val))
          error ("parts.ring.retaining: 'Bore' must be true or false.");
        endif
        bore = val;
        bybore = true;
      case 'heavy'
        if (! islogical (val) || ! isscalar (val))
          error ("parts.ring.retaining: 'Heavy' must be true or false.");
        endif
        heavy = val;
        byheavy = true;
      case 'maker'
        if (strcmp (MODE, 'solid'))
          error ("parts.ring.retaining: 'Maker' applies to 'data' only.");
        endif
        if (! ischar (val) || ! isrow (val))
          error ("parts.ring.retaining: 'Maker' must be a character vector.");
        endif
        maker = val;
      case 'detailed'
        if (strcmp (MODE, 'data'))
          error ("parts.ring.retaining: 'Detailed' applies to 'solid' only.");
        endif
        if (! islogical (val) || ! isscalar (val))
          error ("parts.ring.retaining: 'Detailed' must be true or false.");
        endif
        detailed = val;
      otherwise
        error ("parts.ring.retaining: unknown option '%s'.", name);
    endswitch
  endfor

  if (strcmp (MODE, 'data'))
    OUT = catalogue (D1, bore, bybore, heavy, byheavy, maker);
  else
    OUT = shape (D1, bore, heavy, detailed);
  endif

endfunction

## The rings of each kind, a row for each size: d1, s, d3, a max, b, d5 min,
## d4 (NaN where none is given), d2, m min, t, n min
function T = sizes (kind)

  switch (kind)
      case '471'
        ## DIN 471, normal type
        T = [3, 0.4, 2.7, 1.9, 0.8, 1, 7, 2.8, 0.5, 0.1, 0.3;
             4, 0.4, 3.7, 2.2, 0.9, 1, 8.6, 3.8, 0.5, 0.1, 0.3;
             5, 0.6, 4.7, 2.5, 1.1, 1, 10.3, 4.8, 0.7, 0.1, 0.3;
             6, 0.7, 5.6, 2.7, 1.3, 1.2, 11.7, 5.7, 0.8, 0.15, 0.5;
             7, 0.8, 6.5, 3.1, 1.4, 1.2, 13.5, 6.7, 0.9, 0.15, 0.5;
             8, 0.8, 7.4, 3.2, 1.5, 1.2, 14.7, 7.6, 0.9, 0.2, 0.6;
             9, 1, 8.4, 3.3, 1.7, 1.2, 16, 8.6, 1.1, 0.2, 0.6;
             10, 1, 9.3, 3.3, 1.8, 1.5, 17, 9.6, 1.1, 0.2, 0.6;
             11, 1, 10.2, 3.3, 1.8, 1.5, 18, 10.5, 1.1, 0.25, 0.8;
             12, 1, 11, 3.3, 1.8, 1.7, 19, 11.5, 1.1, 0.25, 0.8;
             13, 1, 11.9, 3.4, 2, 1.7, 20.2, 12.4, 1.1, 0.3, 0.9;
             14, 1, 12.9, 3.5, 2.1, 1.7, 21.4, 13.4, 1.1, 0.3, 0.9;
             15, 1, 13.8, 3.6, 2.2, 1.7, 22.6, 14.3, 1.1, 0.35, 1.1;
             16, 1, 14.7, 3.7, 2.2, 1.7, 23.8, 15.2, 1.1, 0.4, 1.2;
             17, 1, 15.7, 3.8, 2.3, 1.7, 25, 16.2, 1.1, 0.4, 1.2;
             18, 1.2, 16.5, 3.9, 2.4, 2, 26.2, 17, 1.3, 0.5, 1.5;
             19, 1.2, 17.5, 3.9, 2.5, 2, 27.2, 18, 1.3, 0.5, 1.5;
             20, 1.2, 18.5, 4, 2.6, 2, 28.4, 19, 1.3, 0.5, 1.5;
             21, 1.2, 19.5, 4.1, 2.7, 2, 29.6, 20, 1.3, 0.5, 1.5;
             22, 1.2, 20.5, 4.2, 2.8, 2, 30.8, 21, 1.3, 0.5, 1.5;
             24, 1.2, 22.2, 4.4, 3, 2, 33.2, 22.9, 1.3, 0.55, 1.7;
             25, 1.2, 23.2, 4.4, 3, 2, 34.2, 23.9, 1.3, 0.55, 1.7;
             26, 1.2, 24.2, 4.5, 3.1, 2, 35.5, 24.9, 1.3, 0.55, 1.7;
             28, 1.5, 25.9, 4.7, 3.2, 2, 37.9, 26.6, 1.6, 0.7, 2.1;
             29, 1.5, 26.9, 4.8, 3.4, 2, 39.1, 27.6, 1.6, 0.7, 2.1;
             30, 1.5, 27.9, 5, 3.5, 2, 40.5, 28.6, 1.6, 0.7, 2.1;
             32, 1.5, 29.6, 5.2, 3.6, 2.5, 43, 30.3, 1.6, 0.85, 2.6;
             34, 1.5, 31.5, 5.4, 3.8, 2.5, 45.4, 32.3, 1.6, 0.85, 2.6;
             35, 1.5, 32.2, 5.6, 3.9, 2.5, 46.8, 33, 1.6, 1, 3;
             36, 1.75, 33.2, 5.6, 4, 2.5, 47.8, 34, 1.85, 1, 3;
             38, 1.75, 35.2, 5.8, 4.2, 2.5, 50.2, 36, 1.85, 1, 3;
             40, 1.75, 36.5, 6, 4.4, 2.5, 52.6, 37.5, 1.85, 1.25, 3.8;
             42, 1.75, 38.5, 6.5, 4.5, 2.5, 55.7, 39.5, 1.85, 1.25, 3.8;
             45, 1.75, 41.5, 6.7, 4.7, 2.5, 59.1, 42.5, 1.85, 1.25, 3.8;
             48, 1.75, 44.5, 6.9, 5, 2.5, 62.5, 45.5, 1.85, 1.25, 3.8;
             50, 2, 45.8, 6.9, 5.1, 2.5, 64.5, 47, 2.15, 1.5, 4.5;
             52, 2, 47.8, 7, 5.2, 2.5, 66.7, 49, 2.15, 1.5, 4.5;
             55, 2, 50.8, 7.2, 5.4, 2.5, 70.2, 52, 2.15, 1.5, 4.5;
             56, 2, 51.8, 7.3, 5.5, 2.5, 71.6, 53, 2.15, 1.5, 4.5;
             58, 2, 53.8, 7.3, 5.6, 2.5, 73.6, 55, 2.15, 1.5, 4.5;
             60, 2, 55.8, 7.4, 5.8, 2.5, 75.6, 57, 2.15, 1.5, 4.5;
             62, 2, 57.8, 7.5, 6, 2.5, 77.8, 59, 2.15, 1.5, 4.5;
             63, 2, 58.8, 7.6, 6.2, 2.5, 79, 60, 2.15, 1.5, 4.5;
             65, 2.5, 60.8, 7.8, 6.3, 3, 81.4, 62, 2.65, 1.5, 4.5;
             68, 2.5, 63.5, 8, 6.5, 3, 84.8, 65, 2.65, 1.5, 4.5;
             70, 2.5, 65.5, 8.1, 6.6, 3, 87, 67, 2.65, 1.5, 4.5;
             72, 2.5, 67.5, 8.2, 6.8, 3, 89.2, 69, 2.65, 1.5, 4.5;
             75, 2.5, 70.5, 8.4, 7, 3, 92.7, 72, 2.65, 1.5, 4.5;
             78, 2.5, 73.5, 8.6, 7.3, 3, 96.1, 75, 2.65, 1.5, 4.5;
             80, 2.5, 74.5, 8.6, 7.4, 3, 98.1, 76.5, 2.65, 1.75, 5.3;
             82, 2.5, 76.5, 8.7, 7.6, 3, 100.3, 78.5, 2.65, 1.75, 5.3;
             85, 3, 79.5, 8.7, 7.8, 3.5, 103.3, 81.5, 3.15, 1.75, 5.3;
             88, 3, 82.5, 8.8, 8, 3.5, 106.5, 84.5, 3.15, 1.75, 5.3;
             90, 3, 84.5, 8.8, 8.2, 3.5, 108.5, 86.5, 3.15, 1.75, 5.3;
             92, 3, 86.5, 9, 8.4, 3.5, NaN, 88.5, 3.15, 1.75, 5.3;
             95, 3, 89.5, 9.4, 8.6, 3.5, 114.8, 91.5, 3.15, 1.75, 5.3;
             100, 3, 94.5, 9.6, 9, 3.5, 120.2, 96.5, 3.15, 1.75, 5.3;
             105, 4, 98, 9.9, 9.3, 3.5, 125.8, 101, 4.15, 2, 6;
             110, 4, 103, 10.1, 9.6, 3.5, 131.2, 106, 4.15, 2, 6;
             115, 4, 108, 10.6, 9.8, 3.5, 137.3, 111, 4.15, 2, 6;
             120, 4, 113, 11, 10.2, 3.5, 143.1, 116, 4.15, 2, 6;
             125, 4, 118, 11.4, 10.4, 4, 149, 121, 4.15, 2, 6;
             130, 4, 123, 11.6, 10.7, 4, 154.4, 126, 4.15, 2, 6;
             135, 4, 128, 11.8, 11, 4, 159.8, 131, 4.15, 2, 6;
             140, 4, 133, 12, 11.2, 4, 165.2, 136, 4.15, 2, 6;
             145, 4, 138, 12.2, 11.5, 4, 170.6, 141, 4.15, 2, 6;
             150, 4, 142, 13, 11.8, 4, 177.3, 145, 4.15, 2.5, 7.5;
             155, 4, 146, 13, 12, 4, 182.3, 150, 4.15, 2.5, 7.5;
             160, 4, 151, 13.3, 12.2, 4, 188, 155, 4.15, 2.5, 7.5;
             165, 4, 155.5, 13.5, 12.5, 4, 193.4, 160, 4.15, 2.5, 7.5;
             170, 4, 160.5, 13.5, 12.9, 4, 198.4, 165, 4.15, 2.5, 7.5;
             175, 4, 165.5, 13.5, 12.9, 4, 203.4, 170, 4.15, 2.5, 7.5;
             180, 4, 170.5, 14.2, 13.5, 4, 210, 175, 4.15, 2.5, 7.5;
             185, 4, 175.5, 14.2, 13.5, 4, 215, 180, 4.15, 2.5, 7.5;
             190, 4, 180.5, 14.2, 14, 4, 220, 185, 4.15, 2.5, 7.5;
             195, 4, 185.5, 14.2, 14, 4, 225, 190, 4.15, 2.5, 7.5;
             200, 4, 190.5, 14.2, 14, 4, 230, 195, 4.15, 2.5, 7.5;
             210, 5, 198, 14.2, 14, 4, 240, 204, 5.15, 3, 9;
             220, 5, 208, 14.2, 14, 4, 250, 214, 5.15, 3, 9;
             230, 5, 218, 14.2, 14, 4, 260, 224, 5.15, 3, 9;
             240, 5, 228, 14.2, 14, 4, 270, 234, 5.15, 3, 9;
             250, 5, 238, 14.2, 14, 4, 280, 244, 5.15, 3, 9;
             260, 5, 245, 16.2, 16, 5, 294, 252, 5.15, 4, 12;
             270, 5, 255, 16.2, 16, 5, 304, 262, 5.15, 4, 12;
             280, 5, 265, 16.2, 16, 5, 314, 272, 5.15, 4, 12;
             290, 5, 275, 16.2, 16, 5, 324, 282, 5.15, 4, 12;
             300, 5, 285, 16.2, 16, 5, 334, 292, 5.15, 4, 12];
      case '471h'
        ## DIN 471, heavy type
        T = [15, 1.5, 13.8, 4.8, 2.4, 2, 25.1, 14.3, 1.6, 0.35, 1.1;
             16, 1.5, 14.7, 5, 2.5, 2, 26.5, 15.2, 1.6, 0.4, 1.2;
             17, 1.5, 15.7, 5, 2.6, 2, NaN, 16.2, 1.6, 0.4, 1.2;
             18, 1.5, 16.5, 5.1, 2.7, 2, NaN, 17, 1.6, 0.5, 1.5;
             20, 1.75, 18.5, 5.5, 3, 2, 31.6, 19, 1.85, 0.5, 1.5;
             22, 1.75, 20.5, 6, 3.1, 2, NaN, 21, 1.85, 0.5, 1.5;
             24, 1.75, 22.2, 6.3, 3.2, 2, NaN, 22.9, 1.85, 0.55, 1.7;
             25, 2, 23.2, 6.4, 3.4, 2, 38.5, 23.9, 2.15, 0.55, 1.7;
             28, 2, 25.9, 6.5, 3.5, 2, NaN, 26.6, 2.15, 0.7, 2.1;
             30, 2, 27.9, 6.5, 4.1, 2, 43.7, 28.6, 2.15, 0.7, 2.1;
             32, 2, 29.6, 6.5, 4.1, 2.5, NaN, 30.3, 2.15, 0.85, 2.6;
             34, 2.5, 31.5, 6.6, 4.2, 2.5, NaN, 32.3, 2.65, 0.85, 2.6;
             35, 2.5, 32.2, 6.7, 4.2, 2.5, 49.1, 33, 2.65, 1, 3;
             38, 2.5, 35.2, 6.8, 4.3, 2.5, NaN, 36, 2.65, 1, 3;
             40, 2.5, 36.5, 7, 4.4, 2.5, 54.7, 37.5, 2.65, 1.25, 3.8;
             42, 2.5, 38.5, 7.2, 4.5, 2.5, NaN, 39.5, 2.65, 1.25, 3.8;
             45, 2.5, 41.5, 7.5, 4.7, 2.5, 60.8, 42.5, 2.65, 1.25, 3.8;
             48, 2.5, 44.5, 7.8, 5, 2.5, NaN, 45.5, 2.65, 1.25, 3.8;
             50, 3, 45.8, 8, 5.1, 2.5, 66.8, 47, 3.15, 1.5, 4.5;
             52, 3, 47.8, 8.2, 5.2, 2.5, NaN, 49, 3.15, 1.5, 4.5;
             55, 3, 50.8, 8.5, 5.4, 2.5, 72.9, 52, 3.15, 1.5, 4.5;
             58, 3, 53.8, 8.8, 5.6, 2.5, NaN, 55, 3.15, 1.5, 4.5;
             60, 3, 55.8, 9, 5.8, 2.5, 78.9, 57, 3.15, 1.5, 4.5;
             65, 4, 60.8, 9.3, 6.3, 3, NaN, 62, 4.15, 1.5, 4.5;
             70, 4, 65.5, 9.5, 6.6, 3, NaN, 67, 4.15, 1.5, 4.5;
             75, 4, 70.5, 9.7, 7, 3, NaN, 72, 4.15, 1.5, 4.5;
             80, 4, 74.5, 9.8, 7.4, 3, NaN, 76.5, 4.15, 1.75, 5.3;
             85, 4, 79.5, 10, 7.8, 3.5, NaN, 81.5, 4.15, 1.75, 5.3;
             90, 4, 84.5, 10.2, 8.2, 3.5, NaN, 86.5, 4.15, 1.75, 5.3;
             100, 4, 94.5, 10.5, 9, 3.5, NaN, 96.5, 4.15, 1.75, 5.3];
      case '472'
        ## DIN 472, normal type
        T = [8, 0.8, 8.7, 2.4, 1.1, 1, 3, 8.4, 0.9, 0.2, 0.6;
             9, 0.8, 9.8, 2.5, 1.3, 1, 3.7, 9.4, 0.9, 0.2, 0.6;
             10, 1, 10.8, 3.2, 1.4, 1.2, 3.3, 10.4, 1.1, 0.2, 0.6;
             11, 1, 11.8, 3.3, 1.5, 1.2, 4.1, 11.4, 1.1, 0.2, 0.6;
             12, 1, 13, 3.4, 1.7, 1.5, 4.9, 12.5, 1.1, 0.25, 0.8;
             13, 1, 14.1, 3.6, 1.8, 1.5, 5.4, 13.6, 1.1, 0.3, 0.9;
             14, 1, 15.1, 3.7, 1.8, 1.7, 6.2, 14.6, 1.1, 0.3, 0.9;
             15, 1, 16.2, 3.7, 2, 1.7, 7.2, 15.7, 1.1, 0.35, 1.1;
             16, 1, 17.3, 3.8, 2, 1.7, 8, 16.8, 1.1, 0.4, 1.2;
             17, 1, 18.3, 3.9, 2.1, 1.7, 8.8, 17.8, 1.1, 0.4, 1.2;
             18, 1, 19.5, 4.1, 2.2, 2, 9.4, 19, 1.1, 0.5, 1.5;
             19, 1, 20.5, 4.1, 2.2, 2, 10.4, 20, 1.1, 0.5, 1.5;
             20, 1, 21.5, 4.1, 2.3, 2, 11.2, 21, 1.1, 0.5, 1.5;
             21, 1, 22.5, 4.2, 2.4, 2, 12.2, 22, 1.1, 0.5, 1.5;
             22, 1, 23.5, 4.2, 2.5, 2, 13.2, 23, 1.1, 0.5, 1.5;
             24, 1.2, 25.9, 4.4, 2.6, 2, 14.8, 25.2, 1.3, 0.6, 1.8;
             25, 1.2, 26.9, 4.5, 2.7, 2, 15.5, 26.2, 1.3, 0.6, 1.8;
             26, 1.2, 27.9, 4.7, 2.8, 2, 16.1, 27.2, 1.3, 0.6, 1.8;
             28, 1.2, 30.1, 4.8, 2.9, 2, 17.9, 29.4, 1.3, 0.7, 2.1;
             30, 1.2, 32.1, 4.8, 3, 2, 19.9, 31.4, 1.3, 0.7, 2.1;
             31, 1.2, 33.4, 5.2, 3.1, 2.5, 20, 32.7, 1.3, 0.85, 2.6;
             32, 1.2, 34.4, 5.4, 3.2, 2.5, 20.6, 33.7, 1.3, 0.85, 2.6;
             34, 1.5, 36.5, 5.4, 3.3, 2.5, 22.6, 35.7, 1.6, 0.85, 2.6;
             35, 1.5, 37.8, 5.4, 3.4, 2.5, 23.6, 37, 1.6, 1, 3;
             36, 1.5, 38.8, 5.4, 3.5, 2.5, 24.6, 38, 1.6, 1, 3;
             37, 1.5, 39.8, 5.5, 3.6, 2.5, 25.4, 39, 1.6, 1, 3;
             38, 1.5, 40.8, 5.5, 3.7, 2.5, 26.4, 40, 1.6, 1, 3;
             40, 1.75, 43.5, 5.8, 3.9, 2.5, 27.8, 42.5, 1.85, 1.25, 3.8;
             42, 1.75, 45.5, 5.9, 4.1, 2.5, 29.6, 44.5, 1.85, 1.25, 3.8;
             45, 1.75, 48.5, 6.2, 4.3, 2.5, 32, 47.5, 1.85, 1.25, 3.8;
             47, 1.75, 50.5, 6.4, 4.4, 2.5, 33.5, 49.5, 1.85, 1.25, 3.8;
             48, 1.75, 51.5, 6.4, 4.5, 2.5, 34.5, 50.5, 1.85, 1.25, 3.8;
             50, 2, 54.2, 6.5, 4.6, 2.5, 36.3, 53, 2.15, 1.5, 4.5;
             52, 2, 56.2, 6.7, 4.7, 2.5, 37.9, 55, 2.15, 1.5, 4.5;
             55, 2, 59.2, 6.8, 5, 2.5, 40.7, 58, 2.15, 1.5, 4.5;
             56, 2, 60.2, 6.8, 5.1, 2.5, 41.7, 59, 2.15, 1.5, 4.5;
             58, 2, 62.2, 6.9, 5.2, 2.5, 43.5, 61, 2.15, 1.5, 4.5;
             60, 2, 64.2, 7.3, 5.4, 2.5, 44.7, 63, 2.15, 1.5, 4.5;
             62, 2, 66.2, 7.3, 5.5, 2.5, 46.7, 65, 2.15, 1.5, 4.5;
             63, 2, 67.2, 7.3, 5.6, 2.5, 47.7, 66, 2.15, 1.5, 4.5;
             65, 2.5, 69.2, 7.6, 5.8, 3, 49, 68, 2.65, 1.5, 4.5;
             68, 2.5, 72.5, 7.8, 6.1, 3, 51.6, 71, 2.65, 1.5, 4.5;
             70, 2.5, 74.5, 7.8, 6.2, 3, 53.6, 73, 2.65, 1.5, 4.5;
             72, 2.5, 76.5, 7.8, 6.4, 3, 55.6, 75, 2.65, 1.5, 4.5;
             75, 2.5, 79.5, 7.8, 6.6, 3, 58.6, 78, 2.65, 1.5, 4.5;
             78, 2.5, 82.5, 8.5, 6.8, 3, 60.1, 81, 2.65, 1.5, 4.5;
             80, 2.5, 85.5, 8.5, 7, 3, 62.1, 83.5, 2.65, 1.75, 5.3;
             82, 2.5, 87.5, 8.5, 7, 3, 64.1, 85.5, 2.65, 1.75, 5.3;
             85, 3, 90.5, 8.6, 7.2, 3.5, 66.9, 88.5, 3.15, 1.75, 5.3;
             88, 3, 93.5, 8.6, 7.4, 3.5, 69.9, 91.5, 3.15, 1.75, 5.3;
             90, 3, 95.5, 8.6, 7.6, 3.5, 71.9, 93.5, 3.15, 1.75, 5.3;
             92, 3, 97.5, 8.7, 7.8, 3.5, 73.7, 95.5, 3.15, 1.75, 5.3;
             95, 3, 100.5, 8.8, 8.1, 3.5, 76.5, 98.5, 3.15, 1.75, 5.3;
             98, 3, 103.5, 9, 8.3, 3.5, 79, 101.5, 3.15, 1.75, 5.3;
             100, 3, 105.5, 9.2, 8.4, 3.5, 80.6, 103.5, 3.15, 1.75, 5.3;
             102, 4, 108, 9.5, 8.5, 3.5, 82, 106, 4.15, 2, 6;
             105, 4, 112, 9.5, 8.7, 3.5, 85, 109, 4.15, 2, 6;
             108, 4, 115, 9.5, 8.9, 3.5, 88, 112, 4.15, 2, 6;
             110, 4, 117, 10.4, 9, 3.5, 88.2, 114, 4.15, 2, 6;
             112, 4, 119, 10.5, 9.1, 3.5, 90, 116, 4.15, 2, 6;
             115, 4, 122, 10.5, 9.3, 3.5, 93, 119, 4.15, 2, 6;
             120, 4, 127, 11, 9.7, 3.5, 96.9, 124, 4.15, 2, 6;
             125, 4, 132, 11, 10, 4, 101.9, 129, 4.15, 2, 6;
             130, 4, 137, 11, 10.2, 4, 106.9, 134, 4.15, 2, 6;
             135, 4, 142, 11.2, 10.5, 4, 111.5, 139, 4.15, 2, 6;
             140, 4, 147, 11.2, 10.7, 4, 116.5, 144, 4.15, 2, 6;
             145, 4, 152, 11.4, 10.9, 4, 121, 149, 4.15, 2, 6;
             150, 4, 158, 12, 11.2, 4, 124.8, 155, 4.15, 2.5, 7.5;
             155, 4, 164, 12, 11.4, 4, 129.8, 160, 4.15, 2.5, 7.5;
             160, 4, 169, 13, 11.6, 4, 132.7, 165, 4.15, 2.5, 7.5;
             165, 4, 174.5, 13, 11.8, 4, 137.7, 170, 4.15, 2.5, 7.5;
             170, 4, 179.5, 13.5, 12.2, 4, 141.6, 175, 4.15, 2.5, 7.5;
             175, 4, 184.5, 13.5, 12.7, 4, 146.6, 180, 4.15, 2.5, 7.5;
             180, 4, 189.5, 14.2, 13.2, 4, 150.2, 185, 4.15, 2.5, 7.5;
             185, 4, 194.5, 14.2, 13.7, 4, 155.2, 190, 4.15, 2.5, 7.5;
             190, 4, 199.5, 14.2, 13.8, 4, 160.2, 195, 4.15, 2.5, 7.5;
             195, 4, 204.5, 14.2, 13.8, 4, 165.2, 200, 4.15, 2.5, 7.5;
             200, 4, 209.5, 14.2, 14, 4, 170.2, 205, 4.15, 2.5, 7.5;
             210, 5, 222, 14.2, 14, 4, 180.2, 216, 5.15, 3, 9;
             220, 5, 232, 14.2, 14, 4, 190.2, 226, 5.15, 3, 9;
             230, 5, 242, 14.2, 14, 4, 200.2, 236, 5.15, 3, 9;
             240, 5, 252, 14.2, 14, 4, 210.2, 246, 5.15, 3, 9;
             250, 5, 262, 14.2, 14, 4, 220.2, 256, 5.15, 3, 9;
             260, 5, 275, 16.2, 16, 5, 226, 268, 5.15, 4, 12;
             270, 5, 285, 16.2, 16, 5, 236, 278, 5.15, 4, 12;
             280, 5, 295, 16.2, 16, 5, 246, 288, 5.15, 4, 12;
             290, 5, 305, 16.2, 16, 5, 256, 298, 5.15, 4, 12;
             300, 5, 315, 16.2, 16, 5, 266, 308, 5.15, 4, 12];
      case '472h'
        ## DIN 472, heavy type
        T = [20, 1.5, 21.5, 4.5, 2.4, 2, NaN, 21, 1.6, 0.5, 1.5;
             22, 1.5, 23.5, 4.7, 2.8, 2, NaN, 23, 1.6, 0.5, 1.5;
             24, 1.5, 25.9, 4.9, 3, 2, NaN, 25.2, 1.6, 0.6, 1.8;
             25, 1.5, 26.9, 5, 3.1, 2, NaN, 26.2, 1.6, 0.6, 1.8;
             26, 1.5, 27.9, 5.1, 3.1, 2, NaN, 27.2, 1.6, 0.6, 1.8;
             28, 1.5, 30.1, 5.3, 3.2, 2, NaN, 29.4, 1.6, 0.7, 2.1;
             30, 1.5, 32.1, 5.5, 3.3, 2, NaN, 31.4, 1.6, 0.7, 2.1;
             32, 1.5, 34.4, 5.7, 3.4, 2, NaN, 33.7, 1.6, 0.85, 2.6;
             34, 1.75, 36.5, 5.9, 3.7, 2.5, NaN, 35.7, 1.85, 0.85, 2.6;
             35, 1.75, 37.8, 6, 3.8, 2.5, NaN, 37, 1.85, 1, 3;
             37, 1.75, 39.8, 6.2, 3.9, 2.5, NaN, 39, 1.85, 1, 3;
             38, 1.75, 40.8, 6.3, 3.9, 2.5, NaN, 40, 1.85, 1, 3;
             40, 2, 43.5, 6.5, 3.9, 2.5, NaN, 42.5, 2.15, 1.25, 3.8;
             42, 2, 45.5, 6.7, 4.1, 2.5, NaN, 44.5, 2.15, 1.25, 3.8;
             45, 2, 48.5, 7, 4.3, 2.5, NaN, 47.5, 2.15, 1.25, 3.8;
             47, 2, 50.5, 7.2, 4.4, 2.5, NaN, 49.5, 2.15, 1.25, 3.8;
             50, 2.5, 54.2, 7.5, 4.6, 2.5, NaN, 53, 2.65, 1.5, 4.5;
             52, 2.5, 56.2, 7.7, 4.7, 2.5, NaN, 55, 2.65, 1.5, 4.5;
             55, 2.5, 59.2, 8, 5, 2.5, NaN, 58, 2.65, 1.5, 4.5;
             60, 3, 64.2, 8.5, 5.4, 2.5, NaN, 63, 3.15, 1.5, 4.5;
             62, 3, 66.2, 8.6, 5.5, 2.5, NaN, 65, 3.15, 1.5, 4.5;
             65, 3, 69.2, 8.7, 5.8, 3, NaN, 68, 3.15, 1.5, 4.5;
             68, 3, 72.5, 8.8, 6.1, 3, NaN, 71, 3.15, 1.5, 4.5;
             70, 3, 74.5, 9, 6.2, 3, NaN, 73, 3.15, 1.5, 4.5;
             72, 3, 76.5, 9.2, 6.4, 3, NaN, 75, 3.15, 1.5, 4.5;
             75, 3, 79.5, 9.3, 6.6, 3, NaN, 78, 3.15, 1.5, 4.5;
             80, 4, 85.5, 9.5, 7, 3, NaN, 83.5, 4.15, 1.75, 5.3;
             85, 4, 90.5, 9.7, 7.2, 3.5, NaN, 88.5, 4.15, 1.75, 5.3;
             90, 4, 95.5, 10, 7.6, 3.5, NaN, 93.5, 4.15, 1.75, 5.3;
             95, 4, 100.5, 10.3, 8.1, 3.5, NaN, 98.5, 4.15, 1.75, 5.3;
             100, 4, 105.5, 10.5, 8.4, 3.5, NaN, 103.5, 4.15, 1.75, 5.3];
  endswitch

endfunction

## The kind of a ring, its standard and its type
function [kind, std, type] = kindof (bore, heavy)

  kinds = {'471', '471h'; '472', '472h'};
  kind = kinds{bore + 1, heavy + 1};
  std = 'DIN 471';
  if (bore)
    std = 'DIN 472';
  endif
  type = 'normal';
  if (heavy)
    type = 'heavy';
  endif

endfunction

function C = catalogue (D1, bore, bybore, heavy, byheavy, maker)

  ## Built on the first call, kept for the session
  persistent E;
  if (isempty (E))
    E = entries ();
  endif

  keep = true (height (E), 1);
  if (! isempty (D1))
    keep &= E.d1 == D1;
  endif
  if (bybore)
    keep &= strcmp (E.standard, 'DIN 472') == bore;
  endif
  if (byheavy)
    keep &= strcmp (E.type, 'heavy') == heavy;
  endif
  if (! isempty (maker))
    keep &= strcmpi (E.maker, maker);
  endif
  C = E(keep,:);

  if (height (C) == 0)
    what = '';
    if (! isempty (D1))
      what = sprintf ("%g mm ", D1);
    endif
    kind = 'retaining ring';
    if (byheavy)
      kind = sprintf ("%s type %s", ifelse (heavy, 'heavy', 'normal'), kind);
    endif
    if (bybore)
      kind = [kind, ifelse(bore, ' for a bore', ' for a shaft')];
    endif
    how = '';
    if (! isempty (maker))
      how = sprintf (" by %s", maker);
    endif
    error ("parts.ring.retaining: no %s%s%s in the catalogue.", what, kind, ...
           how);
  endif

endfunction

## A when C is true, else B
function X = ifelse (C, A, B)

  if (C)
    X = A;
  else
    X = B;
  endif

endfunction

## Every entry of the catalogue, sorted by diameter
function E = entries ()

  ## BEGIN generated by tools/reyher_tables.py ring
  ## REYHER article, printed page, standard and type, material, finish;
  ## then its shaft or bore diameters
  A = {'00471.000', 89, '471', 'spring steel', 'plain', ...
         [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, ...
          21, 22, 24, 25, 26, 28, 29, 30, 32, 34, 35, 36, 38, 40, 42, 45, ...
          48, 50, 52, 55, 56, 58, 60, 62, 63, 65, 68, 70, 72, 75, 78, 80, ...
          82, 85, 88, 90, 92, 95, 100, 105, 110, 115, 120, 125, 130, 135, ...
          140, 145, 150, 155, 160, 165, 170, 175, 180, 185, 190, 195, 200, ...
          210, 220, 230, 240, 250, 260, 270, 280, 290, 300];
       '00471.004', 90, '471h', 'spring steel', 'plain', ...
         [15, 16, 20, 22, 24, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80];
       '00471.318', 90, '471', 'spring steel', 'zinc flake', ...
         [10, 12, 14, 15, 16, 17, 20, 25, 30, 32, 35, 38, 40, 42, 45, 50, ...
          55, 60, 70];
       '00472.000', 90, '472', 'spring steel', 'plain', ...
         [8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 24, 25, ...
          26, 28, 30, 31, 32, 34, 35, 36, 37, 38, 40, 42, 45, 47, 48, 50, ...
          52, 55, 56, 58, 60, 62, 63, 65, 68, 70, 72, 75, 78, 80, 82, 85, ...
          88, 90, 92, 95, 98, 100, 102, 105, 108, 110, 112, 115, 120, 125, ...
          130, 135, 140, 145, 150, 155, 160, 165, 170, 175, 180, 185, 190, ...
          195, 200, 210, 220, 230, 240, 250, 260, 270, 280, 290, 300];
       '00472.318', 91, '472', 'spring steel', 'zinc flake', ...
         [10, 12, 16, 20, 25, 30, 35, 40, 50, 60, 70];
       '00471.300', 469, '471', '1.4122', 'plain', ...
         [3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 15, 16, 17, 18, 19, 20, 22, 24, ...
          25, 26, 28, 29, 30, 32, 34, 35, 36, 38, 40, 42, 45, 48, 50, 52, ...
          55, 56, 58, 60, 65, 68, 70, 75, 80, 90, 95, 100];
       '00472.300', 470, '472', '1.4122', 'plain', ...
         [8, 9, 10, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 24, 25, 26, ...
          28, 30, 32, 35, 36, 37, 38, 40, 42, 45, 47, 48, 50, 52, 55, 56, ...
          60, 62, 65, 68, 70, 72, 75, 80, 82, 85, 90, 95, 100];
       '00472.300', 470, '472', '1.4310', 'plain', ...
         [120, 130, 140, 165];
      };
  ## END generated

  n = cellfun (@numel, A(:,6));
  a = repelem ((1:rows (A))', n);
  d1 = [A{:,6}]';
  kind = A(a,3);
  h = NaN (numel (a), 11);
  kinds = {'471', '471h', '472', '472h'};
  for k = 1:numel (kinds)
    T = sizes (kinds{k});
    pick = strcmp (kind, kinds{k});
    [~, r] = ismember (d1(pick), T(:,1));
    h(pick,:) = T(r,:);
  endfor
  std = repmat ({'DIN 471'}, numel (a), 1);
  std(strncmp (kind, '472', 3)) = {'DIN 472'};
  type = repmat ({'normal'}, numel (a), 1);
  type(cellfun (@(k) k(end) == 'h', kind)) = {'heavy'};
  name = cellfun (@(x, d, s) sprintf ("Retaining ring %s - %g x %g", x, d, ...
                                      s), std, num2cell (h(:,1)), ...
                  num2cell (h(:,2)), 'UniformOutput', false);
  source = arrayfun (@(p) sprintf ("REYHER, The Catalogue, 2020.04, p. %d", ...
                                   p), [A{:,2}]', 'UniformOutput', false);

  maker = repmat ({'REYHER'}, numel (a), 1);
  E = table (name, std, type, h(:,1), h(:,2), h(:,3), h(:,4), h(:,5), ...
             h(:,6), h(:,7), h(:,8), h(:,9), h(:,10), h(:,11), A(a,4), ...
             A(a,5), maker, A(a,1), source(a));
  E.Properties.VariableNames = {'designation', 'standard', 'type', 'd1', ...
                                's', 'd3', 'a', 'b', 'd5', 'd4', 'd2', 'm', ...
                                't', 'n', 'material', 'finish', 'maker', ...
                                'article', 'source'};
  E.Properties.VariableUnits = {'', '', '', 'mm', 'mm', 'mm', 'mm', 'mm', ...
                                'mm', 'mm', 'mm', 'mm', 'mm', 'mm', '', '', ...
                                '', '', ''};
  E.Properties.VariableDescriptions = {...
    'designation of the standard', ...
    'DIN 471 or DIN 472', ...
    'normal or heavy', ...
    'diameter of the shaft or the bore', ...
    'thickness of the ring, nominal', ...
    'diameter of the free ring, nominal', ...
    'radial height of the lugs, largest', ...
    'radial width of the ring opposite the gap, about', ...
    'diameter of the holes in the lugs, smallest', ...
    'diameter the fitted ring sweeps, the room it needs', ...
    'diameter of the groove, nominal', ...
    'width of the groove, smallest (H13)', ...
    'depth of the groove', ...
    ['distance from the groove to the end of the shaft', ...
     ' or bore, smallest'], ...
    'material', ...
    'finish as the maker names it', ...
    'maker', ...
    "maker's article number", ...
    'catalogue and page the article was read from'};
  E.Properties.Description = 'Retaining rings, with the grooves they sit in';
  E = sortrows (E, 'd1');

endfunction

function S = shape (D1, bore, heavy, detailed)

  [kind, std, type] = kindof (bore, heavy);
  T = sizes (kind);
  h = T(T(:,1) == D1,:);
  if (isempty (h))
    error ("parts.ring.retaining: %s defines no %s type ring for %g mm.", ...
           std, type, D1);
  endif
  s = h(2);
  r = h(3) / 2;
  a = h(4);
  b = h(5);
  d5 = h(6);
  U = geom.UCS ([0, 0, 1], [0, 0, 0]);
  if (! detailed)
    if (bore)
      S = subtract (solid.cylinder (r, s, U), solid.cylinder (r - b, s, U));
    else
      S = subtract (solid.cylinder (r + b, s, U), solid.cylinder (r, s, U));
    endif
  else
    ## The section b wide opposite the gap, b/2 at it: the free edge a
    ## circle off the axis by b/4
    e = b / 4;
    if (bore)
      S = subtract (solid.cylinder (r, s, U), ...
                    translate (solid.cylinder (r - 3 * b / 4, s, U), ...
                               [e, 0, 0]));
      rc = r - a / 2;
      lugs = subtract (solid.cylinder (r, s, U), ...
                       solid.cylinder (r - a, s, U));
    else
      S = subtract (translate (solid.cylinder (r + 3 * b / 4, s, U), ...
                               [-e, 0, 0]), solid.cylinder (r, s, U));
      rc = r + a / 2;
      lugs = subtract (solid.cylinder (r + a, s, U), ...
                       solid.cylinder (r, s, U));
    endif
    ## The gap as wide as a hole, then a lug a wide on each side, holed in
    ## its middle
    beta = d5 / 2 / rc;
    gamma = a / 2 / rc;
    R = 4 * (r + a);
    g = beta + 2 * gamma;
    S = union (S, intersect (lugs, sector (-g, g, R, s)));
    S = subtract (S, sector (-beta, beta, R, s));
    w = beta + gamma;
    for p = [w, -w]
      C = [rc * cos(p), rc * sin(p), 0];
      S = subtract (S, solid.cylinder (d5 / 2, s, geom.UCS ([0, 0, 1], C)));
    endfor
  endif
  S.Name = sprintf ("Retaining ring %s - %g x %g", std, D1, s);

endfunction

## The prism s high over the sector from angle P to Q, reaching R
function W = sector (P, Q, R, s)

  t = linspace (P, Q, 9)';
  W = solid.extrude (geom.Region ([0, 0; R * [cos(t), sin(t)]]), s);

endfunction

%!test  # a ring for a 50 mm shaft
%! C = parts.ring.retaining ('data', 50, 'Bore', false, 'Heavy', false);
%! E = C(strcmp (C.article, '00471.000'),:);
%! assert_equal ([E.designation, E.type, E.material, E.finish], ...
%!               {'Retaining ring DIN 471 - 50 x 2', 'normal', ...
%!                'spring steel', 'plain'});
%!test  # the ring
%! C = parts.ring.retaining ('data', 50, 'Bore', false, 'Heavy', false);
%! E = C(strcmp (C.article, '00471.000'),:);
%! assert_equal ([E.d1, E.s, E.d3, E.a, E.b, E.d5, E.d4], ...
%!               [50, 2, 45.8, 6.9, 5.1, 2.5, 64.5]);
%!test  # its groove
%! C = parts.ring.retaining ('data', 50, 'Bore', false, 'Heavy', false);
%! E = C(strcmp (C.article, '00471.000'),:);
%! assert_equal ([E.d2, E.m, E.t, E.n], [47, 2.15, 1.5, 4.5]);
%!test  # its source
%! C = parts.ring.retaining ('data', 50, 'Bore', false, 'Heavy', false);
%! E = C(strcmp (C.article, '00471.000'),:);
%! assert_equal (E.source, {'REYHER, The Catalogue, 2020.04, p. 89'});
%!test  # each variable carries its unit and description
%! C = parts.ring.retaining ('data', 50);
%! assert_equal (C.Properties.VariableUnits([4, 11]), {'mm', 'mm'});
%! assert_equal (C.Properties.VariableDescriptions{11}, ...
%!               'diameter of the groove, nominal');
%!test  # a ring for a 50 mm bore
%! C = parts.ring.retaining ('data', 50, 'Bore', true);
%! assert_equal (unique (C.designation), ...
%!               {'Retaining ring DIN 472 - 50 x 2'});
%!test  # its groove
%! C = parts.ring.retaining ('data', 50, 'Bore', true);
%! assert_equal ([C.d3(1), C.d2(1), C.t(1)], [54.2, 53, 1.5]);
%!test  # the heavy type
%! C = parts.ring.retaining ('data', 50, 'Heavy', true);
%! assert_equal ([C.designation, C.type], ...
%!               {'Retaining ring DIN 471 - 50 x 3', 'heavy'});
%!test  # without the options both kinds and types come
%! C = parts.ring.retaining ('data', 50);
%! assert_equal (unique (C.designation), ...
%!               {'Retaining ring DIN 471 - 50 x 2'; ...
%!                'Retaining ring DIN 471 - 50 x 3'; ...
%!                'Retaining ring DIN 472 - 50 x 2'});
%!test  # a footnote changes the material of the large sizes
%! C = parts.ring.retaining ('data', 120, 'Bore', true);
%! E = C(strcmp (C.article, '00472.300'),:);
%! assert_equal (E.material, {'1.4310'});
%!test  # a heavy ring's d4
%! C = parts.ring.retaining ('data', 20, 'Heavy', true, 'Bore', false);
%! assert_equal (C.d4(1), 31.6);
%!test  # no d4 where the sources give none
%! C = parts.ring.retaining ('data', 92, 'Bore', false);
%! assert_equal (isnan (C.d4), true);
%!test  # sorted by diameter
%! C = parts.ring.retaining ('data');
%! assert_equal (issorted (C.d1), true);
%!test  # 'Maker' in any case
%! C = parts.ring.retaining ('data', 20, 'Maker', 'reyher');
%! assert_equal (unique (C.maker), {'REYHER'});
%!testif ; exist ('__occt__') == 3  # a flat ring for a shaft
%! S = parts.ring.retaining ('solid', 50);
%! assert_equal (volume (S), pi * (28 ^ 2 - 22.9 ^ 2) * 2, 1e-6);
%!testif ; exist ('__occt__') == 3  # for a bore
%! S = parts.ring.retaining ('solid', 50, 'Bore', true);
%! assert_equal (volume (S), pi * (27.1 ^ 2 - 22.5 ^ 2) * 2, 1e-6);
%!testif ; exist ('__occt__') == 3  # on the plane
%! S = parts.ring.retaining ('solid', 50);
%! assert_equal (bbox (S), [-28, -28, 0, 28, 28, 2], 1e-6);
%!testif ; exist ('__occt__') == 3  # its name
%! S = parts.ring.retaining ('solid', 50, 'Heavy', true);
%! assert_equal (S.Name, {'Retaining ring DIN 471 - 50 x 3'});
%!testif ; exist ('__occt__') == 3  # detailed: valid
%! S = parts.ring.retaining ('solid', 50, 'Detailed', true);
%! assert_equal (isvalid (S), true);
%!testif ; exist ('__occt__') == 3  # b wide opposite the gap
%! S = parts.ring.retaining ('solid', 50, 'Detailed', true);
%! B = bbox (S);
%! assert_equal (B(1), -22.9 - 5.1, 1e-6);
%!testif ; exist ('__occt__') == 3  # the lugs a high, beside the gap
%! S = parts.ring.retaining ('solid', 50, 'Detailed', true);
%! B = bbox (S);
%! assert_equal (B(4), (22.9 + 6.9) * cos (1.25 / 26.35), 1e-6);
%!testif ; exist ('__occt__') == 3  # detailed for a bore: valid
%! S = parts.ring.retaining ('solid', 50, 'Bore', true, 'Detailed', true);
%! assert_equal (isvalid (S), true);
%!testif ; exist ('__occt__') == 3  # the smallest ring
%! S = parts.ring.retaining ('solid', 3, 'Detailed', true);
%! assert_equal (isvalid (S), true);

%!error<parts.ring.retaining: MODE must be 'data' or 'solid'.> ...
%! parts.ring.retaining ('cad')
%!error<parts.ring.retaining: D1 must be a positive diameter.> ...
%! parts.ring.retaining ('data', -5)
%!error<parts.ring.retaining: a solid needs a diameter D1.> ...
%! parts.ring.retaining ('solid')
%!error<parts.ring.retaining: Name/Value arguments must come in pairs.> ...
%! parts.ring.retaining ('data', 20, 'Bore')
%!error<parts.ring.retaining: option names must be character vectors.> ...
%! parts.ring.retaining ('data', 20, 1, 2)
%!error<parts.ring.retaining: 'Bore' must be true or false.> ...
%! parts.ring.retaining ('data', 20, 'Bore', 'yes')
%!error<parts.ring.retaining: 'Bore' must be true or false.> ...
%! parts.ring.retaining ('data', 20, 'Bore', 1)
%!error<parts.ring.retaining: 'Heavy' must be true or false.> ...
%! parts.ring.retaining ('data', 20, 'Heavy', [1, 0])
%!error<parts.ring.retaining: 'Heavy' must be true or false.> ...
%! parts.ring.retaining ('data', 20, 'Heavy', 1)
%!error<parts.ring.retaining: 'Maker' applies to 'data' only.> ...
%! parts.ring.retaining ('solid', 20, 'Maker', 'REYHER')
%!error<parts.ring.retaining: 'Maker' must be a character vector.> ...
%! parts.ring.retaining ('data', 20, 'Maker', 3)
%!error<parts.ring.retaining: 'Detailed' applies to 'solid' only.> ...
%! parts.ring.retaining ('data', 20, 'Detailed', true)
%!error<parts.ring.retaining: 'Detailed' must be true or false.> ...
%! parts.ring.retaining ('solid', 20, 'Detailed', 'yes')
%!error<parts.ring.retaining: 'Detailed' must be true or false.> ...
%! parts.ring.retaining ('solid', 20, 'Detailed', 1)
%!error<parts.ring.retaining: unknown option 'Type'.> ...
%! parts.ring.retaining ('data', 20, 'Type', 'A')
%!error<parts.ring.retaining: DIN 471 defines no heavy type ring for 19 mm.> ...
%! parts.ring.retaining ('solid', 19, 'Heavy', true)
%!error<parts.ring.retaining: no 23 mm retaining ring in the catalogue.> ...
%! parts.ring.retaining ('data', 23)
%!error<parts.ring.retaining: no 19 mm heavy type retaining ring for a shaft in the catalogue.> ...
%! parts.ring.retaining ('data', 19, 'Heavy', true, 'Bore', false)
%!error<parts.ring.retaining: no 20 mm retaining ring by ACME in the catalogue.> ...
%! parts.ring.retaining ('data', 20, 'Maker', 'ACME')
