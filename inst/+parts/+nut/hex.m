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
## @deftypefn  {parts} {@var{C} =} parts.nut.hex (@qcode{'data'})
## @deftypefnx {parts} {@var{C} =} parts.nut.hex (@qcode{'data'}, @var{NAME})
## @deftypefnx {parts} {@var{S} =} parts.nut.hex (@qcode{'solid'}, @var{NAME})
## @deftypefnx {parts} {@dots{} =} parts.nut.hex (@dots{}, @var{Name}, @var{Value})
##
## Hexagon nuts: regular, ISO 4032 and with a fine thread ISO 8673, thin,
## ISO 4035 and with a fine thread ISO 8675, and prevailing torque nuts with
## a non-metallic insert, regular, ISO 7040, and thin, ISO 10511.
##
## @code{@var{C} = parts.nut.hex (@qcode{'data'})} returns every hexagon nut
## in the catalogue as a table, one row for each maker's article in each
## size, sorted by size and pitch.
## @code{@var{C} = parts.nut.hex (@qcode{'data'}, @var{NAME})} returns those
## of the thread @var{NAME}, a coarse thread as @qcode{'M10'} or a fine one
## as @qcode{'M10x1.25'}: every article sold as that nut, each with its
## property class and finish.  Nothing is built.
##
## @code{@var{S} = parts.nut.hex (@qcode{'solid'}, @var{NAME})} builds the
## nut as a @code{solid.Shape} whether or not anyone sells it: any thread
## whose nut the standards define, in any pitch.  The bearing face lies on
## the @math{xy} plane, the nut above it to @math{z} = @var{h} with two of
## its corners on the @math{x} axis.  @code{@var{S}.Name} holds the
## designation.
##
## Name/Value pairs:
##
## @table @asis
## @item @qcode{'Thin'}
## @code{true} for a thin nut, ISO 4035, 8675 or 10511, @code{false} for a
## regular one, the default for @qcode{'solid'}.  For @qcode{'data'} it
## keeps that kind only; without it both come.
##
## @item @qcode{'Locking'}
## @code{true} for a prevailing torque nut with a non-metallic insert, ISO
## 7040 or ISO 10511, @code{false} for a plain one, the default for
## @qcode{'solid'}.  For @qcode{'data'} it keeps that kind only; without it
## both come.
##
## @item @qcode{'Maker'}
## For @qcode{'data'}: only that maker's articles, such as
## @qcode{'REYHER'}, in any case.
##
## @item @qcode{'Detailed'}
## For @qcode{'solid'}: @code{true} chamfers the hexagon at 30 degrees
## from the flats on both faces, countersinks the bore at 120 degrees to
## @var{da} on both faces and cuts the thread by @code{solid.Shape.thread}
## through the nut.  By default (@code{false}) the nut is a plain
## hexagonal prism with a bore of diameter @var{d}.  A prevailing torque
## nut is the hexagon @var{h} high in both; the standards leave the form of
## its collar and insert to the maker.
## @end table
##
## The table has these variables, each with its unit and its description,
## which @code{summary (@var{C})} lists; lengths are in millimetres:
##
## @multitable @columnfractions 0.16 0.84
## @item @code{designation} @tab designation of ISO 8991, as in
## @qcode{'Hexagon regular nut ISO 4032 - M12'}, without the property class
## @item @code{standard} @tab standard when its table defines the nut, else
## empty: such a nut is custom
## @item @code{d} @tab nominal diameter
## @item @code{P} @tab pitch
## @item @code{s} @tab width across flats, nominal
## @item @code{e} @tab width across corners, smallest
## @item @code{m} @tab height of the thread: the nut's largest height; for
## a prevailing torque nut the smallest, the only one its standard gives
## @item @code{h} @tab overall height, largest: @var{m} for a plain nut
## @item @code{dw} @tab diameter of the bearing face, smallest
## @item @code{da} @tab diameter of the countersink, largest
## @item @code{grade} @tab product grade, @qcode{'A'} up to M16, @qcode{'B'}
## above
## @item @code{class} @tab property class or material, as @qcode{'8'},
## @qcode{'A4-70'} or @qcode{'brass'}
## @item @code{finish} @tab finish as the maker names it, as
## @qcode{'plain'} or @qcode{'hot dip galvanized'}
## @item @code{maker} @tab maker
## @item @code{article} @tab maker's article number
## @item @code{source} @tab catalogue and page the article was read from
## @end multitable
##
## A nut is designated by its standard's number when the standard's table
## defines its thread.  Any other is custom, a prevailing torque nut with a
## fine thread, or a plain one in a pitch ISO 8673 or 8675 does not list,
## and takes the dimensions of its kind's coarse thread.
##
## @subheading The catalogue
##
## Articles from REYHER, @cite{The Catalogue}, edition 2020.04, English,
## pages 279 to 285, 324, 325 and 369 to 371 (steel), 544 to 547, 559, 582,
## 586 and 587 (stainless steel), and 637 to 643 (brass, copper alloy,
## aluminium, titanium): every article of a hexagon nut of the six
## standards, pressure vessel grades and hot dip galvanized ones included,
## in sizes the standards define.  Left out: left hand threads, the type 2
## nut of ISO 4033, and the steel prevailing torque nuts REYHER sells under
## DIN 982 and DIN 985, withdrawn and not identical to ISO 7040 and ISO
## 10511.
##
## Dimensions from ISO 4032, 4035, 8673, 8675, 7040 and 10511, all 2012,
## Table 1 of each, read in their official previews and checked cell by
## cell against IS 1364 Parts 3:2002 and 4:2003, IS 13722:2002, IS
## 13724:2002 and IS 7002:2005, which adopt the previous editions unchanged,
## and the 1997 edition of ISO 10511, which agree but for ISO 10511's
## @var{dw} at M3, 4.56 against 4.6; REYHER's @cite{Technical Information}
## (2019, TI-61 to 63 and TI-9) agrees.
##
## @seealso{parts.screw.hex, parts.screw.cap}
## @end deftypefn

function OUT = hex (MODE, varargin)

  if (nargin < 1 || ! ischar (MODE)
      || ! any (strcmp (MODE, {'data', 'solid'})))
    error ("parts.nut.hex: MODE must be 'data' or 'solid'.");
  endif

  ## A thread NAME leads the Name/Value pairs
  args = varargin;
  NAME = '';
  if (! isempty (args) && ischar (args{1})
      && ! isempty (regexp (args{1}, '^M\d', 'once')))
    NAME = args{1};
    args(1) = [];
  endif
  if (strcmp (MODE, 'solid') && isempty (NAME))
    error ("parts.nut.hex: a solid needs a NAME.");
  endif

  thin = false;
  bythin = false;
  locking = false;
  bylocking = false;
  maker = '';
  detailed = false;
  if (mod (numel (args), 2) != 0)
    error ("parts.nut.hex: Name/Value arguments must come in pairs.");
  endif
  for ii = 1:2:numel (args)
    name = args{ii};
    val = args{ii+1};
    if (! ischar (name) || ! isrow (name))
      error ("parts.nut.hex: option names must be character vectors.");
    endif
    switch (lower (name))
      case 'thin'
        if (! islogical (val) || ! isscalar (val))
          error ("parts.nut.hex: 'Thin' must be true or false.");
        endif
        thin = val;
        bythin = true;
      case 'locking'
        if (! islogical (val) || ! isscalar (val))
          error ("parts.nut.hex: 'Locking' must be true or false.");
        endif
        locking = val;
        bylocking = true;
      case 'maker'
        if (strcmp (MODE, 'solid'))
          error ("parts.nut.hex: 'Maker' applies to 'data' only.");
        endif
        if (! ischar (val) || ! isrow (val))
          error ("parts.nut.hex: 'Maker' must be a character vector.");
        endif
        maker = val;
      case 'detailed'
        if (strcmp (MODE, 'data'))
          error ("parts.nut.hex: 'Detailed' applies to 'solid' only.");
        endif
        if (! islogical (val) || ! isscalar (val))
          error ("parts.nut.hex: 'Detailed' must be true or false.");
        endif
        detailed = val;
      otherwise
        error ("parts.nut.hex: unknown option '%s'.", name);
    endswitch
  endfor

  ## The thread
  d = [];
  P = NaN;
  if (! isempty (NAME))
    tok = regexp (NAME, '^M(\d+(?:\.\d+)?)(?:x(\d+(?:\.\d+)?))?$', ...
                  'tokens', 'once');
    if (! isempty (tok) && numel (tok) < 2)
      tok{2} = '';
    endif
    if (isempty (tok) || (! isempty (tok{2}) && str2double (tok{2}) <= 0))
      error (strcat ("parts.nut.hex: NAME must name a metric thread,", ...
                     " such as 'M10' or 'M10x1.25'."));
    endif
    d = str2double (tok{1});
    if (! isempty (tok{2}))
      P = str2double (tok{2});
    endif
  endif

  if (strcmp (MODE, 'data'))
    OUT = catalogue (NAME, d, P, thin, bythin, locking, bylocking, maker);
  else
    OUT = shape (d, P, thin, locking, detailed);
  endif

endfunction

## The nuts of each kind, a row for each thread: d, P, s nom, e min, m (max;
## min for a prevailing torque nut), h max, dw min, da max.  Each standard's
## Table 1, 2012 edition.
function T = sizes (kind)

  switch (kind)
    case 'regular'
      ## ISO 4032
      T = [1.6, 0.35, 3.2, 3.41, 1.3, 1.3, 2.4, 1.84;
           2, 0.4, 4, 4.32, 1.6, 1.6, 3.1, 2.3;
           2.5, 0.45, 5, 5.45, 2, 2, 4.1, 2.9;
           3, 0.5, 5.5, 6.01, 2.4, 2.4, 4.6, 3.45;
           3.5, 0.6, 6, 6.58, 2.8, 2.8, 5, 4;
           4, 0.7, 7, 7.66, 3.2, 3.2, 5.9, 4.6;
           5, 0.8, 8, 8.79, 4.7, 4.7, 6.9, 5.75;
           6, 1, 10, 11.05, 5.2, 5.2, 8.9, 6.75;
           8, 1.25, 13, 14.38, 6.8, 6.8, 11.6, 8.75;
           10, 1.5, 16, 17.77, 8.4, 8.4, 14.6, 10.8;
           12, 1.75, 18, 20.03, 10.8, 10.8, 16.6, 13;
           14, 2, 21, 23.36, 12.8, 12.8, 19.6, 15.1;
           16, 2, 24, 26.75, 14.8, 14.8, 22.5, 17.3;
           18, 2.5, 27, 29.56, 15.8, 15.8, 24.9, 19.5;
           20, 2.5, 30, 32.95, 18, 18, 27.7, 21.6;
           22, 2.5, 34, 37.29, 19.4, 19.4, 31.4, 23.7;
           24, 3, 36, 39.55, 21.5, 21.5, 33.3, 25.9;
           27, 3, 41, 45.2, 23.8, 23.8, 38, 29.1;
           30, 3.5, 46, 50.85, 25.6, 25.6, 42.8, 32.4;
           33, 3.5, 50, 55.37, 28.7, 28.7, 46.6, 35.6;
           36, 4, 55, 60.79, 31, 31, 51.1, 38.9;
           39, 4, 60, 66.44, 33.4, 33.4, 55.9, 42.1;
           42, 4.5, 65, 71.3, 34, 34, 60, 45.4;
           45, 4.5, 70, 76.95, 36, 36, 64.7, 48.6;
           48, 5, 75, 82.6, 38, 38, 69.5, 51.8;
           52, 5, 80, 88.25, 42, 42, 74.2, 56.2;
           56, 5.5, 85, 93.56, 45, 45, 78.7, 60.5;
           60, 5.5, 90, 99.21, 48, 48, 83.4, 64.8;
           64, 6, 95, 104.86, 51, 51, 88.2, 69.1];
    case 'fine'
      ## ISO 8673
      T = [8, 1, 13, 14.38, 6.8, 6.8, 11.63, 8.75;
           10, 1, 16, 17.77, 8.4, 8.4, 14.63, 10.8;
           10, 1.25, 16, 17.77, 8.4, 8.4, 14.63, 10.8;
           12, 1.25, 18, 20.03, 10.8, 10.8, 16.63, 13;
           12, 1.5, 18, 20.03, 10.8, 10.8, 16.63, 13;
           14, 1.5, 21, 23.36, 12.8, 12.8, 19.64, 15.1;
           16, 1.5, 24, 26.75, 14.8, 14.8, 22.49, 17.3;
           18, 1.5, 27, 29.56, 15.8, 15.8, 24.85, 19.5;
           20, 1.5, 30, 32.95, 18, 18, 27.7, 21.6;
           20, 2, 30, 32.95, 18, 18, 27.7, 21.6;
           22, 1.5, 34, 37.29, 19.4, 19.4, 31.35, 23.7;
           24, 2, 36, 39.55, 21.5, 21.5, 33.25, 25.9;
           27, 2, 41, 45.2, 23.8, 23.8, 38, 29.1;
           30, 2, 46, 50.85, 25.6, 25.6, 42.75, 32.4;
           33, 2, 50, 55.37, 28.7, 28.7, 46.55, 35.6;
           36, 3, 55, 60.79, 31, 31, 51.11, 38.9;
           39, 3, 60, 66.44, 33.4, 33.4, 55.86, 42.1;
           42, 3, 65, 71.3, 34, 34, 59.95, 45.4;
           45, 3, 70, 76.95, 36, 36, 64.7, 48.6;
           48, 3, 75, 82.6, 38, 38, 69.45, 51.8;
           52, 4, 80, 88.25, 42, 42, 74.2, 56.2;
           56, 4, 85, 93.56, 45, 45, 78.66, 60.5;
           60, 4, 90, 99.21, 48, 48, 83.41, 64.8;
           64, 4, 95, 104.86, 51, 51, 88.16, 69.1];
    case 'thinfine'
      ## ISO 8675
      T = [8, 1, 13, 14.38, 4, 4, 11.63, 8.75;
           10, 1, 16, 17.77, 5, 5, 14.63, 10.8;
           10, 1.25, 16, 17.77, 5, 5, 14.63, 10.8;
           12, 1.25, 18, 20.03, 6, 6, 16.63, 13;
           12, 1.5, 18, 20.03, 6, 6, 16.63, 13;
           14, 1.5, 21, 23.36, 7, 7, 19.64, 15.1;
           16, 1.5, 24, 26.75, 8, 8, 22.49, 17.3;
           18, 1.5, 27, 29.56, 9, 9, 24.85, 19.5;
           20, 1.5, 30, 32.95, 10, 10, 27.7, 21.6;
           20, 2, 30, 32.95, 10, 10, 27.7, 21.6;
           22, 1.5, 34, 37.29, 11, 11, 31.35, 23.7;
           24, 2, 36, 39.55, 12, 12, 33.25, 25.9;
           27, 2, 41, 45.2, 13.5, 13.5, 38, 29.1;
           30, 2, 46, 50.85, 15, 15, 42.75, 32.4;
           33, 2, 50, 55.37, 16.5, 16.5, 46.55, 35.6;
           36, 3, 55, 60.79, 18, 18, 51.11, 38.9;
           39, 3, 60, 66.44, 19.5, 19.5, 55.86, 42.1;
           42, 3, 65, 71.3, 21, 21, 59.95, 45.4;
           45, 3, 70, 76.95, 22.5, 22.5, 64.7, 48.6;
           48, 3, 75, 82.6, 24, 24, 69.45, 51.8;
           52, 4, 80, 88.25, 26, 26, 74.2, 56.2;
           56, 4, 85, 93.56, 28, 28, 78.66, 60.5;
           60, 4, 90, 99.21, 30, 30, 83.41, 64.8;
           64, 4, 95, 104.86, 32, 32, 88.16, 69.1];
    case 'thin'
      ## ISO 4035
      T = [1.6, 0.35, 3.2, 3.41, 1, 1, 2.4, 1.84;
           2, 0.4, 4, 4.32, 1.2, 1.2, 3.1, 2.3;
           2.5, 0.45, 5, 5.45, 1.6, 1.6, 4.1, 2.9;
           3, 0.5, 5.5, 6.01, 1.8, 1.8, 4.6, 3.45;
           3.5, 0.6, 6, 6.58, 2, 2, 5.1, 4;
           4, 0.7, 7, 7.66, 2.2, 2.2, 5.9, 4.6;
           5, 0.8, 8, 8.79, 2.7, 2.7, 6.9, 5.75;
           6, 1, 10, 11.05, 3.2, 3.2, 8.9, 6.75;
           8, 1.25, 13, 14.38, 4, 4, 11.6, 8.75;
           10, 1.5, 16, 17.77, 5, 5, 14.6, 10.8;
           12, 1.75, 18, 20.03, 6, 6, 16.6, 13;
           14, 2, 21, 23.36, 7, 7, 19.6, 15.1;
           16, 2, 24, 26.75, 8, 8, 22.5, 17.3;
           18, 2.5, 27, 29.56, 9, 9, 24.9, 19.5;
           20, 2.5, 30, 32.95, 10, 10, 27.7, 21.6;
           22, 2.5, 34, 37.29, 11, 11, 31.4, 23.7;
           24, 3, 36, 39.55, 12, 12, 33.2, 25.9;
           27, 3, 41, 45.2, 13.5, 13.5, 38, 29.1;
           30, 3.5, 46, 50.85, 15, 15, 42.8, 32.4;
           33, 3.5, 50, 55.37, 16.5, 16.5, 46.6, 35.6;
           36, 4, 55, 60.79, 18, 18, 51.1, 38.9;
           39, 4, 60, 66.44, 19.5, 19.5, 55.9, 42.1;
           42, 4.5, 65, 71.3, 21, 21, 60, 45.4;
           45, 4.5, 70, 76.95, 22.5, 22.5, 64.7, 48.6;
           48, 5, 75, 82.6, 24, 24, 69.5, 51.8;
           52, 5, 80, 88.25, 26, 26, 74.2, 56.2;
           56, 5.5, 85, 93.56, 28, 28, 78.7, 60.5;
           60, 5.5, 90, 99.21, 30, 30, 83.4, 64.8;
           64, 6, 95, 104.86, 32, 32, 88.2, 69.1];
    case 'locking'
      ## ISO 7040
      T = [3, 0.5, 5.5, 6.01, 2.15, 4.5, 4.57, 3.45;
           4, 0.7, 7, 7.66, 2.9, 6, 5.88, 4.6;
           5, 0.8, 8, 8.79, 4.4, 6.8, 6.88, 5.75;
           6, 1, 10, 11.05, 4.9, 8, 8.88, 6.75;
           8, 1.25, 13, 14.38, 6.44, 9.5, 11.63, 8.75;
           10, 1.5, 16, 17.77, 8.04, 11.9, 14.63, 10.8;
           12, 1.75, 18, 20.03, 10.37, 14.9, 16.63, 13;
           14, 2, 21, 23.36, 12.1, 17, 19.64, 15.1;
           16, 2, 24, 26.75, 14.1, 19.1, 22.49, 17.3;
           20, 2.5, 30, 32.95, 16.9, 22.8, 27.7, 21.6;
           24, 3, 36, 39.55, 20.2, 27.1, 33.25, 25.9;
           30, 3.5, 46, 50.85, 24.3, 32.6, 42.75, 32.4;
           36, 4, 55, 60.79, 29.4, 38.9, 51.11, 38.9];
    case 'thinlocking'
      ## ISO 10511
      T = [3, 0.5, 5.5, 6.01, 1.55, 3.9, 4.56, 3.45;
           4, 0.7, 7, 7.66, 1.95, 5, 5.9, 4.6;
           5, 0.8, 8, 8.79, 2.45, 5, 6.9, 5.75;
           6, 1, 10, 11.05, 2.9, 6, 8.9, 6.75;
           8, 1.25, 13, 14.38, 3.7, 6.76, 11.6, 8.75;
           10, 1.5, 16, 17.77, 4.7, 8.56, 14.6, 10.8;
           12, 1.75, 18, 20.03, 5.7, 10.23, 16.6, 13;
           14, 2, 21, 23.35, 6.42, 11.32, 19.6, 15.1;
           16, 2, 24, 26.75, 7.42, 12.42, 22.5, 17.3;
           20, 2.5, 30, 32.95, 9.1, 14.9, 27.7, 21.6;
           24, 3, 36, 39.55, 10.9, 17.8, 33.2, 25.9;
           30, 3.5, 46, 50.85, 13.9, 22.2, 42.8, 32.4;
           36, 4, 55, 60.79, 16.9, 25.5, 51.1, 38.9];
  endswitch

endfunction

## The kind of nut, its standard and its denomination
function [kind, std, denom] = kindof (thin, locking)

  kinds = {'regular', 'thin'; 'locking', 'thinlocking'};
  kind = kinds{locking + 1, thin + 1};
  stds = {'ISO 4032', 'ISO 4035'; 'ISO 7040', 'ISO 10511'};
  std = stds{locking + 1, thin + 1};
  denom = 'Hexagon regular nut';
  if (thin)
    denom = 'Hexagon thin nut';
  endif
  if (locking)
    denom = ['Prevailing torque type ', lower(denom(1)), denom(2:end)];
  endif

endfunction

## The row of the nut of thread d and pitch P (NaN for coarse), its standard
## (empty for a custom one) and its pitch; a row of NaN where its kind
## defines no nut of the diameter
function [h, std, P] = lookup (d, P, thin, locking)

  [kind, std] = kindof (thin, locking);
  T = sizes (kind);
  h = T(T(:,1) == d,:);
  if (isempty (h))
    h = NaN (1, 8);
    return;
  endif
  if (isnan (P))
    P = h(2);
  elseif (P != h(2))
    std = '';
    if (! locking)
      fines = {'fine', 'ISO 8673'; 'thinfine', 'ISO 8675'};
      F = sizes (fines{thin + 1, 1});
      k = F(:,1) == d & F(:,2) == P;
      if (any (k))
        h = F(k,:);
        std = fines{thin + 1, 2};
      endif
    endif
  endif

endfunction

function C = catalogue (NAME, d, P, thin, bythin, locking, bylocking, maker)

  ## Built on the first call, kept for the session
  persistent E;
  if (isempty (E))
    E = entries ();
  endif

  keep = true (height (E), 1);
  if (! isempty (d))
    if (isnan (P))
      T = sizes ('regular');
      if (any (T(:,1) == d))
        P = T(T(:,1) == d,2);
      endif
    endif
    keep &= E.d == d & E.P == P;
  endif
  kind = E.standard;
  if (bythin)
    keep &= ismember (kind, {'ISO 4035', 'ISO 8675', 'ISO 10511'}) == thin;
  endif
  if (bylocking)
    keep &= ismember (kind, {'ISO 7040', 'ISO 10511'}) == locking;
  endif
  if (! isempty (maker))
    keep &= strcmpi (E.maker, maker);
  endif
  C = E(keep,:);

  if (height (C) == 0)
    what = '';
    if (! isempty (NAME))
      what = [NAME, ' '];
    endif
    kind = 'hexagon nut';
    if (bythin && thin)
      kind = 'thin nut';
    elseif (bythin)
      kind = 'regular nut';
    endif
    if (bylocking && locking)
      kind = ['prevailing torque ', kind];
    endif
    how = '';
    if (! isempty (maker))
      how = sprintf (" by %s", maker);
    endif
    error ("parts.nut.hex: no %s%s%s in the catalogue.", what, kind, how);
  endif

endfunction

## Every entry of the catalogue, sorted by size, then pitch
function E = entries ()

  ## BEGIN generated by tools/reyher_tables.py nut
  ## REYHER article, printed page, kind, class, finish; then each size
  ## and its pitch (0 for coarse)
  A = {'04032.514', 279, 'regular', '5-2', 'zinc plated', ...
         [6, 0; 8, 0; 10, 0; 12, 0; 16, 0; 20, 0; 24, 0; 27, 0; 30, 0; ...
          33, 0; 36, 0; 39, 0];
       '04032.524', 279, 'regular', '5-2', 'hot dip galvanized', ...
         [10, 0; 12, 0; 16, 0; 20, 0; 24, 0; 27, 0; 30, 0; 33, 0; 36, 0];
       '04032.004', 279, 'regular', 'C35', 'plain', ...
         [12, 0; 16, 0; 20, 0; 24, 0; 27, 0; 30, 0; 33, 0; 36, 0];
       '04032.374', 279, 'regular', '25CrMo4', 'plain', ...
         [12, 0; 16, 0; 20, 0; 24, 0; 27, 0; 30, 0; 33, 0; 36, 0; 39, 0];
       '04032.375', 279, 'regular', '25CrMo4', 'zinc plated', ...
         [12, 0; 16, 0; 20, 0; 24, 0; 27, 0; 30, 0; 33, 0; 36, 0];
       '04032.301', 279, 'regular', '6', 'plain', ...
         [1.6, 0; 2, 0; 2.5, 0; 3, 0; 3.5, 0; 4, 0; 5, 0; 6, 0; 8, 0; ...
          10, 0; 12, 0; 14, 0; 16, 0; 18, 0; 20, 0; 22, 0; 24, 0; 27, 0; ...
          30, 0; 36, 0; 39, 0; 42, 0; 45, 0; 48, 0; 52, 0; 56, 0; 60, 0; ...
          64, 0];
       '04032.800', 280, 'regular', '8', 'plain', ...
         [2.5, 0; 3, 0; 4, 0; 5, 0; 6, 0; 8, 0; 10, 0; 12, 0; 14, 0; 16, 0; ...
          18, 0; 20, 0; 22, 0; 24, 0; 27, 0; 30, 0; 33, 0; 36, 0; 39, 0; ...
          42, 0; 45, 0; 48, 0; 52, 0; 56, 0; 60, 0; 64, 0];
       '04032.810', 280, 'regular', '8', 'zinc plated', ...
         [2, 0; 2.5, 0; 3, 0; 4, 0; 5, 0; 6, 0; 8, 0; 10, 0; 12, 0; 14, 0; ...
          16, 0; 18, 0; 20, 0; 22, 0; 24, 0; 27, 0; 30, 0; 33, 0; 36, 0; ...
          39, 0; 42, 0; 45, 0; 48, 0; 52, 0; 56, 0; 60, 0; 64, 0];
       '04032.359', 281, 'regular', '6', 'zinc plated 8 TLP', ...
         [2.5, 0; 3, 0; 4, 0; 5, 0];
       '04032.359', 281, 'regular', '8', 'zinc plated 8 TLP', ...
         [6, 0; 8, 0; 10, 0; 12, 0; 14, 0; 16, 0; 20, 0; 24, 0; 30, 0; ...
          36, 0];
       '04032.428', 281, 'regular', '6', 'zinc plated 8 TLP + SL', ...
         [3, 0; 4, 0; 5, 0];
       '04032.428', 281, 'regular', '8', 'zinc plated 8 TLP + SL', ...
         [6, 0; 8, 0; 10, 0; 12, 0; 14, 0; 16, 0; 20, 0; 24, 0; 30, 0; ...
          36, 0];
       '04032.353', 281, 'regular', '8', 'flZn/TL480h', ...
         [6, 0; 8, 0; 10, 0; 12, 0; 16, 0; 20, 0; 24, 0];
       '04032.820', 281, 'regular', '8', 'hot dip galvanized', ...
         [6, 0; 8, 0; 10, 0; 12, 0; 14, 0; 16, 0; 18, 0; 20, 0; 22, 0; ...
          24, 0; 27, 0; 30, 0; 33, 0; 36, 0; 39, 0; 42, 0; 45, 0; 48, 0; ...
          52, 0; 56, 0; 64, 0];
       '04032.830', 281, 'regular', '8', 'nickel plated', ...
         [3, 0; 4, 0; 5, 0; 6, 0; 8, 0; 10, 0];
       '04032.809', 282, 'regular', '8', 'plain', ...
         [8, 0; 10, 0; 12, 0; 16, 0; 20, 0; 24, 0; 27, 0];
       '04032.819', 282, 'regular', '8', 'zinc plated', ...
         [8, 0; 10, 0; 12, 0; 16, 0; 20, 0; 24, 0; 27, 0];
       '04032.100', 282, 'regular', '10', 'plain', ...
         [4, 0; 5, 0; 6, 0; 8, 0; 10, 0; 12, 0; 14, 0; 16, 0; 18, 0; 20, 0; ...
          22, 0; 24, 0; 27, 0; 30, 0; 33, 0; 36, 0; 39, 0; 42, 0; 45, 0; ...
          48, 0; 52, 0];
       '04032.110', 282, 'regular', '10', 'zinc plated', ...
         [4, 0; 5, 0; 6, 0; 8, 0; 10, 0; 12, 0; 14, 0; 16, 0; 18, 0; 20, 0; ...
          22, 0; 24, 0; 27, 0; 30, 0; 33, 0; 36, 0; 39, 0; 42, 0; 48, 0; ...
          52, 0];
       '04032.180', 283, 'regular', '10', 'zinc plated 8 TLP', ...
         [5, 0; 6, 0; 8, 0; 10, 0; 12, 0; 16, 0; 20, 0; 24, 0; 27, 0; ...
          30, 0];
       '04032.354', 283, 'regular', '10', 'flZn/TL480h', ...
         [6, 0; 8, 0; 10, 0; 12, 0; 16, 0; 20, 0; 24, 0; 30, 0];
       '04032.133', 283, 'regular', '10', 'flZnL480h', ...
         [6, 0; 8, 0; 10, 0; 12, 0; 16, 0; 18, 0; 20, 0; 24, 0; 30, 0];
       '04032.120', 283, 'regular', '10', 'hot dip galvanized', ...
         [12, 0; 16, 0; 20, 0; 22, 0; 24, 0; 27, 0; 30, 0; 33, 0; 36, 0; ...
          42, 0; 48, 0];
       '04032.200', 283, 'regular', '12', 'plain', ...
         [6, 0; 8, 0; 10, 0; 12, 0; 16, 0; 20, 0; 24, 0; 27, 0; 30, 0; ...
          36, 0];
       '04032.270', 284, 'regular', '12', 'flZnL480h', ...
         [6, 0; 8, 0; 10, 0; 12, 0; 16, 0; 20, 0];
       '04035.400', 284, 'thin', '04', 'plain', ...
         [2, 0; 2.5, 0; 3, 0; 3.5, 0; 4, 0; 5, 0; 6, 0; 8, 0; 10, 0; 12, 0; ...
          14, 0; 16, 0; 18, 0; 20, 0; 22, 0; 24, 0; 27, 0; 30, 0; 33, 0; ...
          36, 0; 42, 0];
       '04035.410', 284, 'thin', '04', 'zinc plated', ...
         [2, 0; 2.5, 0; 3, 0; 4, 0; 5, 0; 6, 0; 8, 0; 10, 0; 12, 0; 14, 0; ...
          16, 0; 20, 0; 24, 0; 30, 0; 33, 0; 36, 0; 42, 0];
       '04035.308', 285, 'thin', '04', 'zinc plated 8 TLP', ...
         [3, 0; 4, 0; 5, 0; 6, 0; 8, 0];
       '04035.470', 285, 'thin', '04', 'flZn/TL480h', ...
         [6, 0; 8, 0; 10, 0; 12, 0; 16, 0; 20, 0; 24, 0; 30, 0];
       '04035.420', 285, 'thin', '04', 'hot dip galvanized', ...
         [8, 0; 10, 0; 12, 0; 16, 0; 20, 0; 24, 0; 27, 0; 30, 0];
       '04035.500', 285, 'thin', '05', 'plain', ...
         [10, 0; 12, 0; 14, 0; 22, 0];
       '04035.510', 285, 'thin', '05', 'zinc plated', ...
         [4, 0; 5, 0; 6, 0; 8, 0; 10, 0; 12, 0; 14, 0; 16, 0; 20, 0; 22, 0];
       '07040.810', 324, 'locking', '8', 'zinc plated', ...
         [4, 0; 5, 0; 6, 0; 8, 0; 10, 0; 12, 0; 14, 0; 16, 0; 20, 0; 24, 0];
       '07040.814', 325, 'locking', '8', 'zinc plated, heat-stabilised', ...
         [5, 0; 6, 0; 8, 0; 10, 0; 12, 0; 16, 0; 20, 0; 24, 0];
       '07040.110', 325, 'locking', '10', 'zinc plated', ...
         [10, 0; 12, 0; 16, 0; 20, 0; 24, 0];
       '08673.300', 369, 'fine', '6', 'plain', ...
         [8, 1; 10, 1; 10, 1.25; 12, 1.25; 12, 1.5; 14, 1.5; 16, 1.5; ...
          18, 1.5; 20, 1.5; 20, 2; 22, 1.5; 24, 2; 27, 2; 30, 2; 33, 2; ...
          36, 3; 39, 3; 42, 3; 45, 3; 48, 3; 56, 4; 60, 4; 64, 4];
       '08673.830', 370, 'fine', '8', 'black', ...
         [8, 1; 10, 1; 12, 1.25; 12, 1.5; 14, 1.5; 16, 1.5; 18, 1.5; ...
          20, 1.5; 20, 2; 22, 1.5; 24, 2; 27, 2; 30, 2; 33, 2; 36, 3; ...
          39, 3; 42, 3; 45, 3; 48, 3; 56, 4; 60, 4; 64, 4];
       '08673.810', 370, 'fine', '8', 'zinc plated', ...
         [10, 1; 10, 1.25; 12, 1.25; 12, 1.5; 14, 1.5; 16, 1.5; 18, 1.5; ...
          20, 1.5; 20, 2; 22, 1.5; 24, 2; 27, 2; 30, 2; 33, 2; 36, 3; ...
          39, 3; 42, 3; 45, 3; 48, 3];
       '08673.100', 370, 'fine', '10', 'plain', ...
         [8, 1; 10, 1; 12, 1.5; 14, 1.5; 16, 1.5; 18, 1.5; 20, 1.5; 20, 2; ...
          22, 1.5; 24, 2; 30, 2; 42, 3; 48, 3];
       '08673.110', 370, 'fine', '10', 'zinc plated', ...
         [8, 1; 10, 1; 12, 1.5; 14, 1.5; 16, 1.5; 18, 1.5; 20, 1.5; 20, 2; ...
          24, 2; 30, 2; 36, 3; 42, 3; 48, 3];
       '08675.400', 371, 'thinfine', '04', 'plain', ...
         [8, 1; 10, 1; 10, 1.25; 12, 1.25; 12, 1.5; 14, 1.5; 16, 1.5; ...
          18, 1.5; 20, 1.5; 20, 2; 24, 2; 30, 2; 36, 3; 39, 3; 42, 3; ...
          48, 3];
       '08675.410', 371, 'thinfine', '04', 'zinc plated', ...
         [8, 1; 10, 1; 10, 1.25; 12, 1.25; 12, 1.5; 14, 1.5; 16, 1.5; ...
          18, 1.5; 20, 1.5; 22, 1.5; 24, 2; 30, 2; 36, 3; 42, 3];
       '08675.500', 371, 'thinfine', '05', 'plain', ...
         [10, 1; 10, 1.25; 12, 1.25; 12, 1.5; 14, 1.5; 22, 1.5];
       '08675.510', 371, 'thinfine', '05', 'zinc plated', ...
         [10, 1; 10, 1.25; 12, 1.25; 14, 1.5; 20, 1.5];
       '08675.920', 582, 'thinfine', 'A2', 'plain', ...
         [8, 1; 10, 1; 10, 1.25; 12, 1.25; 12, 1.5; 14, 1.5; 16, 1.5; ...
          18, 1.5; 20, 1.5; 22, 1.5; 30, 2];
       '08675.940', 582, 'thinfine', 'A4', 'plain', ...
         [10, 1; 10, 1.25; 12, 1.25; 12, 1.5; 16, 1.5; 18, 1.5; 20, 1.5; ...
          22, 1.5; 24, 2; 30, 2; 33, 2; 36, 3];
       '08675.700', 643, 'thinfine', 'brass', 'plain', ...
         [10, 1; 12, 1.5; 14, 1.5];
       '04032.910', 544, 'regular', 'A1', 'plain', ...
         [1.6, 0; 2, 0; 2.5, 0];
       '04032.920', 544, 'regular', 'A2', 'plain', ...
         [3, 0; 3.5, 0; 4, 0; 30, 0; 33, 0; 36, 0; 42, 0; 48, 0];
       '04032.920', 544, 'regular', 'A2-70', 'plain', ...
         [5, 0; 6, 0; 8, 0; 10, 0; 12, 0; 14, 0; 16, 0; 18, 0; 20, 0; ...
          22, 0; 24, 0; 27, 0];
       '04032.931', 544, 'regular', 'A2-70', 'lubricated', ...
         [6, 0; 8, 0; 10, 0; 12, 0; 16, 0; 20, 0; 24, 0];
       '04032.926', 545, 'regular', 'A2-70', 'plain', ...
         [10, 0; 12, 0; 14, 0; 16, 0; 20, 0; 24, 0; 27, 0];
       '04032.926', 545, 'regular', 'A2-50', 'plain', ...
         [30, 0; 33, 0];
       '04032.940', 545, 'regular', 'A4', 'plain', ...
         [2, 0; 2.5, 0; 3, 0; 4, 0; 27, 0; 30, 0; 33, 0; 36, 0; 39, 0; ...
          42, 0; 48, 0];
       '04032.940', 545, 'regular', 'A4-70', 'plain', ...
         [5, 0; 6, 0; 8, 0; 10, 0; 12, 0; 14, 0; 16, 0; 18, 0; 20, 0; ...
          22, 0; 24, 0];
       '04032.951', 545, 'regular', 'A4-70', 'lubricated', ...
         [6, 0; 8, 0; 10, 0; 12, 0; 16, 0; 20, 0; 24, 0];
       '04032.947', 545, 'regular', 'A4-70', 'plain', ...
         [8, 0; 10, 0; 12, 0; 14, 0; 16, 0; 20, 0; 24, 0; 27, 0];
       '04032.947', 545, 'regular', 'A4-50', 'plain', ...
         [30, 0];
       '04032.948', 545, 'regular', 'A4-80', 'plain', ...
         [5, 0; 6, 0; 8, 0; 10, 0; 12, 0; 14, 0; 16, 0; 18, 0; 20, 0; ...
          24, 0];
       '04032.941', 545, 'regular', 'BUMAX88', 'plain', ...
         [6, 0; 8, 0; 10, 0; 12, 0; 16, 0; 20, 0; 24, 0; 30, 0];
       '04032.942', 546, 'regular', 'BUMAX109', 'plain', ...
         [6, 0; 8, 0; 10, 0; 12, 0; 16, 0; 20, 0];
       '04032.950', 546, 'regular', 'A5', 'plain', ...
         [6, 0; 8, 0; 10, 0; 12, 0; 16, 0; 20, 0; 24, 0; 27, 0; 30, 0];
       '04035.920', 546, 'thin', 'A2', 'plain', ...
         [2, 0; 2.5, 0; 3, 0; 4, 0; 5, 0; 6, 0; 8, 0; 10, 0; 12, 0; 14, 0; ...
          16, 0; 18, 0; 20, 0; 22, 0; 24, 0; 27, 0; 30, 0; 36, 0];
       '04035.940', 547, 'thin', 'A4', 'plain', ...
         [2, 0; 2.5, 0; 3, 0; 4, 0; 5, 0; 6, 0; 8, 0; 10, 0; 12, 0; 14, 0; ...
          16, 0; 18, 0; 20, 0; 24, 0; 27, 0; 30, 0; 36, 0; 42, 0];
       '07040.920', 559, 'locking', 'A2', 'plain', ...
         [5, 0; 6, 0; 8, 0; 10, 0; 12, 0; 16, 0; 20, 0];
       '07040.924', 559, 'locking', 'A2-70', 'plain, heat-stabilised', ...
         [3, 0; 4, 0; 5, 0; 6, 0; 8, 0; 10, 0; 12, 0; 16, 0];
       '07040.940', 559, 'locking', 'A4', 'plain', ...
         [5, 0; 6, 0; 8, 0; 10, 0; 12, 0; 16, 0; 20, 0; 24, 0];
       '08673.920', 582, 'fine', 'A2', 'plain', ...
         [8, 1; 10, 1; 10, 1.25; 12, 1.25; 12, 1.5; 14, 1.5; 16, 1.5; ...
          18, 1.5; 20, 1.5; 24, 2; 30, 2];
       '10511.920', 586, 'thinlocking', 'A2', 'plain', ...
         [3, 0; 4, 0; 5, 0; 6, 0; 8, 0; 10, 0; 12, 0; 14, 0; 16, 0; 20, 0; ...
          24, 0; 30, 0; 36, 0];
       '10511.940', 587, 'thinlocking', 'A4', 'plain', ...
         [3, 0; 4, 0; 5, 0; 6, 0; 8, 0; 10, 0; 12, 0; 14, 0; 16, 0; 20, 0; ...
          24, 0; 30, 0];
       '04032.700', 637, 'regular', 'brass', 'plain', ...
         [1.6, 0; 2, 0; 2.5, 0; 3, 0; 3.5, 0; 4, 0; 5, 0; 6, 0; 8, 0; ...
          10, 0; 12, 0; 14, 0; 16, 0; 18, 0; 20, 0; 22, 0; 24, 0; 27, 0; ...
          30, 0; 33, 0; 36, 0; 42, 0];
       '04032.730', 637, 'regular', 'brass', 'nickel plated', ...
         [2, 0; 2.5, 0; 3, 0; 3.5, 0; 4, 0; 5, 0; 6, 0; 8, 0; 10, 0; 12, 0; ...
          16, 0];
       '04032.740', 637, 'regular', 'brass', 'chrome plated', ...
         [3, 0; 4, 0; 5, 0; 6, 0; 8, 0];
       '04032.302', 638, 'regular', 'CuNiSi', 'plain', ...
         [6, 0; 8, 0; 10, 0; 12, 0; 16, 0; 20, 0; 24, 0];
       '04032.303', 638, 'regular', 'aluminium', 'plain', ...
         [4, 0; 5, 0; 6, 0; 8, 0; 10, 0; 12, 0; 16, 0];
       '04032.305', 638, 'regular', 'titanium', 'plain', ...
         [6, 0; 8, 0; 10, 0; 12, 0; 16, 0];
       '04035.700', 638, 'thin', 'brass', 'plain', ...
         [2, 0; 2.5, 0; 3, 0; 4, 0; 5, 0; 6, 0; 8, 0; 10, 0; 12, 0; 14, 0; ...
          16, 0; 20, 0];
       '04035.730', 638, 'thin', 'brass', 'nickel plated', ...
         [3, 0; 4, 0; 5, 0; 6, 0; 8, 0; 10, 0; 12, 0; 16, 0; 20, 0];
       '08673.700', 642, 'fine', 'brass', 'plain', ...
         [8, 1; 10, 1; 14, 1.5; 16, 1.5; 20, 1.5; 22, 1.5];
       '10511.700', 643, 'thinlocking', 'brass', 'plain', ...
         [4, 0; 5, 0; 6, 0; 8, 0; 10, 0; 12, 0];
      };
  ## END generated

  kinds = {'regular', 'fine', 'thin', 'thinfine', 'locking', 'thinlocking'};
  stds = {'ISO 4032', 'ISO 8673', 'ISO 4035', 'ISO 8675', 'ISO 7040', ...
          'ISO 10511'};
  denoms = {'Hexagon regular nut', 'Hexagon regular nut', ...
            'Hexagon thin nut', 'Hexagon thin nut', ...
            'Prevailing torque type hexagon regular nut', ...
            'Prevailing torque type hexagon thin nut'};
  n = cellfun (@rows, A(:,6));
  a = repelem ((1:rows (A))', n);
  X = cell2mat (A(:,6));
  [~, j] = ismember (A(a,3), kinds);
  h = NaN (numel (a), 8);
  for k = 1:numel (kinds)
    T = sizes (kinds{k});
    pick = j == k;
    if (any (k == [2, 4]))
      [~, r] = ismember (X(pick,:), T(:,1:2), 'rows');
    else
      [~, r] = ismember (X(pick,1), T(:,1));
    endif
    h(pick,:) = T(r,:);
  endfor
  name = parts.__designation__ (denoms(j)', stds(j)', h(:,1), h(:,2), [], []);
  grade = repmat ({'B'}, numel (a), 1);
  grade(h(:,1) <= 16) = {'A'};
  source = arrayfun (@(p) sprintf ("REYHER, The Catalogue, 2020.04, p. %d", ...
                                   p), [A{:,2}]', 'UniformOutput', false);

  standard = stds(j)';
  maker = repmat ({'REYHER'}, numel (a), 1);
  E = table (name, standard, h(:,1), h(:,2), h(:,3), h(:,4), h(:,5), h(:,6), ...
             h(:,7), h(:,8), grade, A(a,4), A(a,5), maker, A(a,1), source(a));
  E.Properties.VariableNames = {'designation', 'standard', 'd', 'P', 's', ...
                                'e', 'm', 'h', 'dw', 'da', 'grade', 'class', ...
                                'finish', 'maker', 'article', 'source'};
  E.Properties.VariableUnits = {'', '', 'mm', 'mm', 'mm', 'mm', 'mm', 'mm', ...
                                'mm', 'mm', '', '', '', '', '', ''};
  E.Properties.VariableDescriptions = {...
    'designation of ISO 8991, without the property class', ...
    'standard when its table defines the nut', ...
    'nominal diameter', ...
    'pitch', ...
    'width across flats, nominal', ...
    'width across corners, smallest', ...
    'height of the thread', ...
    'overall height, largest', ...
    'diameter of the bearing face, smallest', ...
    'diameter of the countersink, largest', ...
    'product grade', ...
    'property class or material', ...
    'finish as the maker names it', ...
    'maker', ...
    "maker's article number", ...
    'catalogue and page the article was read from'};
  E.Properties.Description = 'Hexagon nuts';
  E = sortrows (E, {'d', 'P'});

endfunction

function S = shape (d, P, thin, locking, detailed)

  [h, std, P] = lookup (d, P, thin, locking);
  [kind, kstd, denom] = kindof (thin, locking);
  if (isnan (h(1)))
    error ("parts.nut.hex: %s defines no M%g nut.", kstd, d);
  endif
  [name, tname] = parts.__designation__ (denom, std, d, P, [], []);

  s = h(3);
  H = h(6);
  a = pi / 3 * (0:5)';
  X = geom.Region (s / sqrt (3) * [cos(a), sin(a)]);
  S = solid.extrude (X, H);
  if (detailed)
    ## The chamfers at 30 degrees, from the flats out past the corners, on
    ## both faces
    c = 0.6 * s;
    t = (c - s / 2) * tand (30);
    R = geom.Region ([0, 0; s / 2, 0; c, t; c, H - t; s / 2, H; 0, H]);
    R.UCS = geom.UCS ([0, -1, 0], [0, 0, 0]);
    S = intersect (S, solid.revolve (R));
    ## The tapping drill, countersunk on both faces, then the thread
    D = solid.holespec (tname, 'Custom', true);
    S = hole (S, [0, 0, H], D.drill, Inf, 'Countersink', [h(8), 120]);
    S = hole (S, [0, 0, 0], D.drill, Inf, 'Countersink', [h(8), 120], ...
              'Direction', [0, 0, 1]);
    S = thread (S, [0, 0, H], tname, H, 'Custom', true);
  else
    S = subtract (S, solid.cylinder (d / 2, H));
  endif
  S.Name = name;

endfunction

%!test  # every entry has its standard's dimensions
%! C = parts.nut.hex ('data');
%! assert_equal (any (cellfun (@isempty, C.standard)), false);
%!test  # an M12 regular nut
%! C = parts.nut.hex ('data', 'M12', 'Thin', false, 'Locking', false);
%! E = C(strcmp (C.article, '04032.800'),:);
%! assert_equal ([E.designation, E.grade, E.class, E.finish], ...
%!               {'Hexagon regular nut ISO 4032 - M12', 'A', '8', ...
%!                'plain'});
%!test  # its dimensions
%! C = parts.nut.hex ('data', 'M12');
%! E = C(strcmp (C.article, '04032.800'),:);
%! assert_equal ([E.d, E.P, E.s, E.e, E.m, E.h, E.dw, E.da], ...
%!               [12, 1.75, 18, 20.03, 10.8, 10.8, 16.6, 13]);
%!test  # its source
%! C = parts.nut.hex ('data', 'M12');
%! E = C(strcmp (C.article, '04032.800'),:);
%! assert_equal (E.source, {'REYHER, The Catalogue, 2020.04, p. 280'});
%!test  # each variable carries its unit and description
%! C = parts.nut.hex ('data', 'M12');
%! assert_equal (C.Properties.VariableUnits([3, 9]), {'mm', 'mm'});
%! assert_equal (C.Properties.VariableDescriptions{9}, ...
%!               'diameter of the bearing face, smallest');
%!test  # a fine thread, ISO 8673
%! C = parts.nut.hex ('data', 'M16x1.5', 'Thin', false);
%! assert_equal (unique (C.designation), ...
%!               {'Hexagon regular nut ISO 8673 - M16x1.5'});
%!test  # its bearing face
%! C = parts.nut.hex ('data', 'M16x1.5');
%! assert_equal (unique (C.dw), 22.49);
%!test  # a thin nut, ISO 4035
%! C = parts.nut.hex ('data', 'M10', 'Thin', true, 'Locking', false);
%! assert_equal (unique (C.designation), ...
%!               {'Hexagon thin nut ISO 4035 - M10'});
%!test  # its height
%! C = parts.nut.hex ('data', 'M10', 'Thin', true, 'Locking', false);
%! assert_equal (unique ([C.m, C.h]), 5);
%!test  # a prevailing torque nut, ISO 7040
%! C = parts.nut.hex ('data', 'M8', 'Locking', true, 'Thin', false);
%! assert_equal (unique (C.designation), ...
%!               {['Prevailing torque type hexagon regular nut', ...
%!                 ' ISO 7040 - M8']});
%!test  # its heights
%! C = parts.nut.hex ('data', 'M8', 'Locking', true, 'Thin', false);
%! assert_equal ([C.m(1), C.h(1)], [6.44, 9.5]);
%!test  # a thin prevailing torque nut, ISO 10511
%! C = parts.nut.hex ('data', 'M6', 'Locking', true, 'Thin', true);
%! assert_equal (unique (C.designation), ...
%!               {['Prevailing torque type hexagon thin nut', ...
%!                 ' ISO 10511 - M6']});
%!test  # a thin nut with a fine thread, ISO 8675
%! C = parts.nut.hex ('data', 'M16x1.5', 'Thin', true);
%! assert_equal (unique (C.designation), ...
%!               {'Hexagon thin nut ISO 8675 - M16x1.5'});
%!test  # its height
%! C = parts.nut.hex ('data', 'M16x1.5', 'Thin', true);
%! assert_equal (unique ([C.m, C.h]), 8);
%!test  # 'Thin' alone keeps both thin kinds
%! C = parts.nut.hex ('data', 'M6', 'Thin', true);
%! assert_equal (unique (C.standard), {'ISO 10511'; 'ISO 4035'});
%!test  # 'Locking' alone keeps both prevailing torque kinds
%! C = parts.nut.hex ('data', 'M6', 'Locking', true);
%! assert_equal (unique (C.standard), {'ISO 10511'; 'ISO 7040'});
%!test  # a footnote changes the class of the small sizes
%! C = parts.nut.hex ('data', 'M5');
%! E = C(strcmp (C.article, '04032.359'),:);
%! assert_equal (E.class, {'6'});
%!test  # and of the large ones
%! C = parts.nut.hex ('data', 'M30');
%! E = C(strcmp (C.article, '04032.926'),:);
%! assert_equal (E.class, {'A2-50'});
%!test  # starred stainless rows carry no strength number
%! C = parts.nut.hex ('data', 'M3');
%! E = C(strcmp (C.article, '04032.920'),:);
%! assert_equal (E.class, {'A2'});
%!test  # grades
%! C = parts.nut.hex ('data', 'M20');
%! assert_equal (unique (C.grade), {'B'});
%!test  # sorted by size, then pitch
%! C = parts.nut.hex ('data');
%! assert_equal (issorted ([C.d, C.P], 'rows'), true);
%!test  # 'Maker' in any case
%! C = parts.nut.hex ('data', 'M8', 'Maker', 'reyher');
%! assert_equal (unique (C.maker), {'REYHER'});
%!testif ; exist ('__occt__') == 3  # a plain prism with its bore
%! S = parts.nut.hex ('solid', 'M10');
%! V = 3 * sqrt (3) / 2 * (16 / sqrt (3)) ^ 2 * 8.4 - pi * 25 * 8.4;
%! assert_equal (volume (S), V, 1e-6);
%!testif ; exist ('__occt__') == 3  # the bearing face on the plane
%! S = parts.nut.hex ('solid', 'M10');
%! r = 16 / sqrt (3);
%! assert_equal (bbox (S), [-r, -8, 0, r, 8, 8.4], 1e-6);
%!testif ; exist ('__occt__') == 3  # its name
%! S = parts.nut.hex ('solid', 'M10');
%! assert_equal (S.Name, {'Hexagon regular nut ISO 4032 - M10'});
%!testif ; exist ('__occt__') == 3  # a prevailing torque nut is h high
%! S = parts.nut.hex ('solid', 'M10', 'Locking', true);
%! B = bbox (S);
%! assert_equal (B(6), 11.9, 1e-6);
%!testif ; exist ('__occt__') == 3  # a fine thread in ISO 8673
%! S = parts.nut.hex ('solid', 'M10x1.25');
%! assert_equal (S.Name, {'Hexagon regular nut ISO 8673 - M10x1.25'});
%!testif ; exist ('__occt__') == 3  # a thin nut with a fine thread
%! S = parts.nut.hex ('solid', 'M10x1', 'Thin', true);
%! assert_equal (S.Name, {'Hexagon thin nut ISO 8675 - M10x1'});
%!testif ; exist ('__occt__') == 3  # in a pitch ISO 8675 lacks: custom
%! S = parts.nut.hex ('solid', 'M12x1', 'Thin', true);
%! assert_equal (S.Name, {'Hexagon thin nut M12x1'});
%!testif ; exist ('__occt__') == 3  # detailed: a valid solid
%! S = parts.nut.hex ('solid', 'M10', 'Detailed', true);
%! assert_equal (isvalid (S), true);
%!testif ; exist ('__occt__') == 3  # the 30 degree chamfer at the face
%! S = parts.nut.hex ('solid', 'M10', 'Detailed', true);
%! B = bbox (intersect (S, translate (solid.box (30, 30, 0.1), ...
%!                                    [-15, -15, 0])));
%! assert_equal (B(4), 8 + 0.1 / tand (30), 1e-6);
%!testif ; exist ('__occt__') == 3  # and at the top
%! S = parts.nut.hex ('solid', 'M10', 'Detailed', true);
%! B = bbox (intersect (S, translate (solid.box (30, 30, 0.1), ...
%!                                    [-15, -15, 8.3])));
%! assert_equal (B(4), 8 + 0.1 / tand (30), 1e-6);

%!error<parts.nut.hex: MODE must be 'data' or 'solid'.> parts.nut.hex ('cad')
%!error<parts.nut.hex: a solid needs a NAME.> parts.nut.hex ('solid')
%!error<parts.nut.hex: Name/Value arguments must come in pairs.> ...
%! parts.nut.hex ('data', 'M8', 'Thin')
%!error<parts.nut.hex: option names must be character vectors.> ...
%! parts.nut.hex ('data', 'M8', 1, 2)
%!error<parts.nut.hex: 'Thin' must be true or false.> ...
%! parts.nut.hex ('data', 'M8', 'Thin', 'yes')
%!error<parts.nut.hex: 'Thin' must be true or false.> ...
%! parts.nut.hex ('data', 'M8', 'Thin', 1)
%!error<parts.nut.hex: 'Locking' must be true or false.> ...
%! parts.nut.hex ('data', 'M8', 'Locking', [1, 0])
%!error<parts.nut.hex: 'Locking' must be true or false.> ...
%! parts.nut.hex ('data', 'M8', 'Locking', 1)
%!error<parts.nut.hex: 'Maker' applies to 'data' only.> ...
%! parts.nut.hex ('solid', 'M8', 'Maker', 'REYHER')
%!error<parts.nut.hex: 'Maker' must be a character vector.> ...
%! parts.nut.hex ('data', 'M8', 'Maker', 3)
%!error<parts.nut.hex: 'Detailed' applies to 'solid' only.> ...
%! parts.nut.hex ('data', 'M8', 'Detailed', true)
%!error<parts.nut.hex: 'Detailed' must be true or false.> ...
%! parts.nut.hex ('solid', 'M8', 'Detailed', 'yes')
%!error<parts.nut.hex: 'Detailed' must be true or false.> ...
%! parts.nut.hex ('solid', 'M8', 'Detailed', 1)
%!error<parts.nut.hex: unknown option 'Pitch'.> ...
%! parts.nut.hex ('data', 'M8', 'Pitch', 1)
%!error<parts.nut.hex: NAME must name a metric thread, such as 'M10' or 'M10x1.25'.> ...
%! parts.nut.hex ('data', 'M8x')
%!error<parts.nut.hex: ISO 7040 defines no M18 nut.> ...
%! parts.nut.hex ('solid', 'M18', 'Locking', true)
%!error<parts.nut.hex: no M7 hexagon nut in the catalogue.> ...
%! parts.nut.hex ('data', 'M7')
%!error<parts.nut.hex: no M18 prevailing torque thin nut in the catalogue.> ...
%! parts.nut.hex ('data', 'M18', 'Thin', true, 'Locking', true)
%!error<parts.nut.hex: no M8 hexagon nut by ACME in the catalogue.> ...
%! parts.nut.hex ('data', 'M8', 'Maker', 'ACME')
