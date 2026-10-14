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
## @deftypefn  {parts} {@var{P} =} parts.dowel (@qcode{'data'})
## @deftypefnx {parts} {@var{P} =} parts.dowel (@qcode{'data'}, @var{D})
## @deftypefnx {parts} {@var{P} =} parts.dowel (@qcode{'data'}, @var{D}, @var{L})
## @deftypefnx {parts} {@var{S} =} parts.dowel (@qcode{'solid'}, @var{D}, @var{L})
## @deftypefnx {parts} {@var{S} =} parts.dowel (@dots{}, @var{Name}, @var{Value})
##
## Parallel dowel pins to ISO 8734, hardened.
##
## @code{@var{P} = parts.dowel (@qcode{'data'})} returns every pin in the
## catalogue as a table, one row for each diameter and length in stock,
## smallest first.  @code{@var{P} = parts.dowel (@qcode{'data'}, @var{D})}
## returns the pins of diameter @var{D} millimetres, one for each length in
## stock, and @code{@var{P} = parts.dowel (@qcode{'data'}, @var{D},
## @var{L})} the one @var{L} long.  Nothing is built.
##
## @code{@var{S} = parts.dowel (@qcode{'solid'}, @var{D}, @var{L})} builds
## the pin of diameter @var{D} as a @code{solid.Shape} @var{L} long, whether
## or not that length is in stock: its axis on the @math{z} axis, from
## @math{z} = 0 to @var{L}.
##
## Name/Value pairs:
##
## @table @asis
## @item @qcode{'Detailed'}
## For @qcode{'solid'}: @code{true} chamfers both ends @var{c} along the axis
## at 15 degrees.  By default (@code{false}) the pin is a plain cylinder.
## @end table
##
## The table has these variables, each with its unit and its description,
## which @code{summary (@var{P})} lists; lengths are in millimetres:
##
## @multitable @columnfractions 0.12 0.88
## @item @code{d} @tab nominal diameter, toleranced m6
## @item @code{l} @tab length
## @item @code{c} @tab chamfer at each end, approximate
## @item @code{maker} @tab maker
## @item @code{article} @tab maker's article number
## @item @code{source} @tab catalogue and pages the pin was read from
## @end multitable
##
## @subheading The catalogue
##
## REYHER, @cite{The Catalogue}, edition 2020.04, English, pages 374 and
## 375: article 08734.001, steel, type A, through-hardened, every diameter
## ISO 8734 defines, 1 to 20 mm, with the lengths in stock.  Left out: the
## 14 mm pin REYHER also sells, a diameter ISO 8734 does not define.  The
## pins REYHER sells under DIN 6325, which ISO 8734 replaced, are not
## included.
##
## The chamfer @var{c} from Table 1 of ISO 8734:1997, as adopted word for
## word in IS 6689:2003, and REYHER's @cite{Technical Information} (2019,
## TI-116).
##
## @seealso{parts.bearing.deepgroove, parts.screw.cap, parts.key}
## @end deftypefn

function OUT = dowel (MODE, varargin)

  if (nargin < 1 || ! ischar (MODE)
      || ! any (strcmp (MODE, {'data', 'solid'})))
    error ("parts.dowel: MODE must be 'data' or 'solid'.");
  endif

  ## A diameter D, then a length L, lead the Name/Value pairs
  args = varargin;
  D = [];
  L = [];
  if (! isempty (args) && ! ischar (args{1}))
    D = args{1};
    args(1) = [];
    if (! isempty (args) && ! ischar (args{1}))
      L = args{1};
      args(1) = [];
    endif
  endif
  if (strcmp (MODE, 'solid') && isempty (L))
    error ("parts.dowel: a solid needs a diameter D and a length L.");
  endif

  detailed = false;
  if (mod (numel (args), 2) != 0)
    error ("parts.dowel: Name/Value arguments must come in pairs.");
  endif
  for ii = 1:2:numel (args)
    name = args{ii};
    val = args{ii+1};
    if (! ischar (name) || ! isrow (name))
      error ("parts.dowel: option names must be character vectors.");
    endif
    switch (lower (name))
      case 'detailed'
        if (strcmp (MODE, 'data'))
          error ("parts.dowel: 'Detailed' applies to 'solid' only.");
        endif
        if (! islogical (val) || ! isscalar (val))
          error ("parts.dowel: 'Detailed' must be true or false.");
        endif
        detailed = val;
      otherwise
        error ("parts.dowel: unknown option '%s'.", name);
    endswitch
  endfor

  P = catalogue ();
  if (isempty (D))
    OUT = P;
    return;
  endif
  if (! isnumeric (D) || ! isreal (D) || ! isscalar (D))
    error ("parts.dowel: D must be a real scalar.");
  endif
  P = P(abs (P.d - D) < 1e-9, :);
  if (height (P) == 0)
    error ("parts.dowel: no %g mm dowel in the catalogue.", D);
  endif
  if (! isempty (L)
      && (! isnumeric (L) || ! isreal (L) || ! isscalar (L) || ! isfinite (L)))
    error ("parts.dowel: L must be a real scalar.");
  endif
  if (strcmp (MODE, 'data'))
    if (! isempty (L))
      P = P(abs (P.l - L) < 1e-9, :);
      if (height (P) == 0)
        error ("parts.dowel: no %g x %g mm dowel in the catalogue.", D, L);
      endif
    endif
    OUT = P;
    return;
  endif

  c = P.c(1);
  if (L <= 2 * c)
    error ("parts.dowel: a %g mm dowel must be longer than %g mm.", D, 2 * c);
  endif
  r = D / 2;
  if (! detailed)
    OUT = solid.cylinder (r, L);
  else
    q = r - c * tand (15);
    R = geom.Region ([0, 0; q, 0; r, c; r, L - c; q, L; 0, L]);
    R.UCS = geom.UCS ([0, -1, 0], [0, 0, 0]);
    OUT = solid.revolve (R);
  endif

endfunction

## The catalogue as a table, built on the first call and kept for the session
function P = catalogue ()

  persistent C;
  if (! isempty (C))
    P = C;
    return;
  endif

  ## d, c; then the lengths REYHER stocks
  T = {1, 0.2, [4, 5, 6, 8, 10, 12];
       1.5, 0.3, [4, 5, 6, 8, 10, 12, 14, 16, 20];
       2, 0.35, [4, 5, 6, 8:2:20, 24, 30, 32];
       2.5, 0.4, [6:2:20, 24, 26, 28];
       3, 0.5, [6:2:32, 40, 45, 50];
       4, 0.63, [6:2:32, 36, 40, 45, 50, 60];
       5, 0.8, [8:2:32, 36, 40:5:60, 70];
       6, 1.2, [8:2:32, 36, 40:5:60, 70:10:100];
       8, 1.6, [10:2:32, 36, 40:5:60, 70:10:100, 120];
       10, 2, [16, 20:2:32, 36, 40:5:60, 70:10:120];
       12, 2.5, [20, 24:2:32, 36, 40:5:60, 70:10:120];
       16, 3, [30, 40:5:60, 70:10:120];
       20, 3.5, [40, 50, 60, 80, 100, 120]};
  n = cellfun (@numel, T(:,3));
  k = repelem ((1:rows (T))', n);
  d = [T{:,1}]';
  c = [T{:,2}]';
  maker = repmat ({'REYHER'}, sum (n), 1);
  article = repmat ({'08734.001'}, sum (n), 1);
  source = repmat ({'REYHER, The Catalogue, 2020.04, pp. 374-375'}, ...
                   sum (n), 1);
  C = table (d(k), [T{:,3}]', c(k), maker, article, source);
  C.Properties.VariableNames = {'d', 'l', 'c', 'maker', 'article', 'source'};
  C.Properties.VariableUnits = {'mm', 'mm', 'mm', '', '', ''};
  C.Properties.VariableDescriptions = {...
    'nominal diameter, toleranced m6', ...
    'length', ...
    'chamfer at each end, approximate', ...
    'maker', ...
    "maker's article number", ...
    'catalogue and pages the pin was read from'};
  C.Properties.Description = 'Parallel dowel pins to ISO 8734, hardened';
  P = C;

endfunction

%!test  # every pin, smallest first
%! P = parts.dowel ('data');
%! assert_equal (unique (P.d)', ...
%!               [1, 1.5, 2, 2.5, 3, 4, 5, 6, 8, 10, 12, 16, 20]);
%!test  # one row for each length in stock
%! P = parts.dowel ('data');
%! assert_equal (height (P), 197);
%!test  # sorted by diameter, then length
%! P = parts.dowel ('data');
%! assert_equal (issorted ([P.d, P.l], 'rows'), true);
%!test  # one diameter, its lengths in stock
%! P = parts.dowel ('data', 6);
%! assert_equal (P.l', [8:2:32, 36, 40:5:60, 70:10:100]);
%!test  # its chamfer on every row
%! P = parts.dowel ('data', 6);
%! assert_equal (unique (P.c), 1.2);
%!test  # the largest diameter
%! P = parts.dowel ('data', 20);
%! assert_equal (P.l', [40, 50, 60, 80, 100, 120]);
%!test  # one pin
%! P = parts.dowel ('data', 1, 12);
%! assert_equal ([P.d, P.l, P.c], [1, 12, 0.2]);
%!test  # its source
%! P = parts.dowel ('data', 8, 20);
%! assert_equal ([P.maker, P.article, P.source], ...
%!               {'REYHER', '08734.001', ...
%!                'REYHER, The Catalogue, 2020.04, pp. 374-375'});
%!test  # each variable carries its unit and description
%! P = parts.dowel ('data', 8, 20);
%! assert_equal (P.Properties.VariableUnits(1:3), {'mm', 'mm', 'mm'});
%! assert_equal (P.Properties.VariableDescriptions{3}, ...
%!               'chamfer at each end, approximate');
%!testif ; exist ('__occt__') == 3  # the shape stands L tall on the xy plane
%! S = parts.dowel ('solid', 6, 30);
%! assert_equal (bbox (S), [-3, -3, 0, 3, 3, 30], 1e-6);
%!testif ; exist ('__occt__') == 3  # a plain cylinder by default
%! S = parts.dowel ('solid', 6, 30);
%! assert_equal (volume (S), pi * 9 * 30, 1e-6);
%!testif ; exist ('__occt__') == 3  # detailed: valid
%! S = parts.dowel ('solid', 6, 30, 'Detailed', true);
%! assert_equal (isvalid (S), true);
%!testif ; exist ('__occt__') == 3  # detailed: L tall on the xy plane
%! S = parts.dowel ('solid', 6, 30, 'Detailed', true);
%! assert_equal (bbox (S), [-3, -3, 0, 3, 3, 30], 1e-6);
%!testif ; exist ('__occt__') == 3  # detailed: the cylinder less chamfers
%! S = parts.dowel ('solid', 6, 30, 'Detailed', true);
%! q = 3 - 1.2 * tand (15);
%! V = pi * 9 * 27.6 + 2 * pi * 1.2 * (9 + 3 * q + q ^ 2) / 3;
%! assert_equal (volume (S), V, 1e-6);
%!testif ; exist ('__occt__') == 3  # a length not in stock
%! S = parts.dowel ('solid', 6, 31);
%! assert_equal (bbox (S), [-3, -3, 0, 3, 3, 31], 1e-6);

%!error<parts.dowel: MODE must be 'data' or 'solid'.> parts.dowel ()
%!error<parts.dowel: MODE must be 'data' or 'solid'.> parts.dowel (6)
%!error<parts.dowel: Name/Value arguments must come in pairs.> ...
%! parts.dowel ('solid', 6, 30, 'Detailed')
%!error<parts.dowel: option names must be character vectors.> ...
%! parts.dowel ('solid', 6, 30, {1}, 2)
%!error<parts.dowel: 'Detailed' applies to 'solid' only.> ...
%! parts.dowel ('data', 6, 'Detailed', true)
%!error<parts.dowel: 'Detailed' must be true or false.> ...
%! parts.dowel ('solid', 6, 30, 'Detailed', 1)
%!error<parts.dowel: unknown option 'Form'.> ...
%! parts.dowel ('solid', 6, 30, 'Form', 'A')
%!error<parts.dowel: a solid needs a diameter D and a length L.> ...
%! parts.dowel ('solid', 6)
%!error<parts.dowel: D must be a real scalar.> parts.dowel ('data', [6, 8])
%!error<parts.dowel: no 7 mm dowel in the catalogue.> parts.dowel ('data', 7)
%!error<parts.dowel: no 6 x 31 mm dowel in the catalogue.> ...
%! parts.dowel ('data', 6, 31)
%!error<parts.dowel: L must be a real scalar.> parts.dowel ('data', 6, [30, 40])
%!error<parts.dowel: no 14 mm dowel in the catalogue.> ...
%! parts.dowel ('solid', 14, 50)
%!error<parts.dowel: a 6 mm dowel must be longer than 2.4 mm.> ...
%! parts.dowel ('solid', 6, 2)
%!error<parts.dowel: L must be a real scalar.> ...
%! parts.dowel ('solid', 6, [30, 40])
