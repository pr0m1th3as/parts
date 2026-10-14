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
## @deftypefn  {parts} {@var{C} =} parts.screw.lowcap (@qcode{'data'})
## @deftypefnx {parts} {@var{C} =} parts.screw.lowcap (@qcode{'data'}, @var{NAME})
## @deftypefnx {parts} {@var{C} =} parts.screw.lowcap (@qcode{'data'}, @var{NAME}, @var{L})
## @deftypefnx {parts} {@var{S} =} parts.screw.lowcap (@qcode{'solid'}, @var{NAME}, @var{L})
## @deftypefnx {parts} {@dots{} =} parts.screw.lowcap (@dots{}, @var{Name}, @var{Value})
##
## Hexagon socket head cap screws with low head, DIN 7984.
##
## @code{@var{C} = parts.screw.lowcap (@qcode{'data'})} returns every low
## head cap screw in the catalogue as a struct array, one entry for each
## maker's article in each size and length, sorted by size and length.
## @code{@var{C} = parts.screw.lowcap (@qcode{'data'}, @var{NAME})} returns
## those of the thread @var{NAME}, such as @qcode{'M8'}, and
## @code{@var{C} = parts.screw.lowcap (@qcode{'data'}, @var{NAME}, @var{L})}
## those of nominal length @var{L} too: every article sold as that screw,
## each with its property class and finish.  Nothing is built.
##
## @code{@var{S} = parts.screw.lowcap (@qcode{'solid'}, @var{NAME}, @var{L})}
## builds the screw as a @code{solid.Shape} whether or not anyone sells it:
## any thread of a size the standard defines, any pitch, any length.  The
## underside of the head lies on the @math{xy} plane, the head above it,
## the shank below it to @math{z} = -@var{L}, the hexagon socket sunk into
## the head with two of its corners on the @math{x} axis.
## @code{@var{S}.Name} holds the screw's designation.
##
## Name/Value pairs:
##
## @table @asis
## @item @qcode{'Maker'}
## For @qcode{'data'}: only that maker's articles, such as
## @qcode{'REYHER'}, in any case.
##
## @item @qcode{'ThreadLength'}
## For @qcode{'solid'}: the length of thread @var{b} from the end of the
## shank, from 0 to @var{L}; @var{L} threads it to the head.  Without it the
## screw follows DIN 7984: threaded to the head up to the length its table
## gives each size, longer ones threaded @var{b}, which depends on the
## length (125 or less, up to 200, longer).
##
## @item @qcode{'Detailed'}
## For @qcode{'solid'}: @code{true} also builds the fillet of radius
## @var{r} under the head and the thread, cut by @code{solid.Shape.thread};
## a screw threaded to the head is threaded to within 3 @var{P} of it, as
## the standard puts its last full thread.  By default (@code{false}) the
## shank is a plain cylinder of diameter @var{d}.  Either way the socket is
## @var{s} across flats and @var{t} min deep, and the end is left flat.
## @end table
##
## Each entry is a struct with these fields, lengths in millimetres:
##
## @multitable @columnfractions 0.16 0.84
## @item @code{designation} @tab the designation, as in
## @qcode{'Hexagon socket head cap screw with low head DIN 7984 - M8 x
## 20'}, without the property class
## @item @code{standard} @tab @qcode{'DIN 7984'} when its table defines the
## screw, else empty: such a screw is custom
## @item @code{d} @tab nominal diameter
## @item @code{P} @tab pitch, coarse
## @item @code{l} @tab nominal length
## @item @code{b} @tab length of thread from the end, @var{l} when threaded
## to the head
## @item @code{dk} @tab head diameter, largest
## @item @code{k} @tab head height, largest
## @item @code{drive} @tab @qcode{'hexsocket'}
## @item @code{tool} @tab the hexagon key, as @qcode{'5'}
## @item @code{class} @tab property class, as the maker marks it: a leading
## 0, as in @qcode{'08.8'}, marks the reduced loadability of the low head
## @item @code{finish} @tab the finish as the maker names it
## @item @code{maker} @tab the maker
## @item @code{article} @tab the maker's article number
## @item @code{source} @tab the catalogue and page the article was read from
## @end multitable
##
## A screw is designated by the standard's number when its table defines it:
## a length of the size's commercial range with the thread form the table
## gives it.  Every other screw is custom, its thread length written when
## shorter than @var{l}.
##
## @subheading The catalogue
##
## Articles from REYHER, @cite{The Catalogue}, edition 2020.04, English,
## pages 362 to 364: every article with a hexagon socket.  Left out: the
## hexalobular article 07984.814, whose socket DIN 7984 does not define.
##
## Dimensions, thread lengths and lengths from DIN 7984:2009-06, Tabelle 1,
## read in a copy of its German text, which agrees with fasteners.eu in
## every thread form and thread length; fasteners.eu gives other ranges for
## some sizes, which an older edition explains.
##
## @seealso{parts.screw.cap}
## @end deftypefn

function OUT = lowcap (MODE, varargin)

  if (nargin < 1 || ! ischar (MODE)
      || ! any (strcmp (MODE, {'data', 'solid'})))
    error ("parts.screw.lowcap: MODE must be 'data' or 'solid'.");
  endif

  ## A thread NAME and a length L lead the Name/Value pairs
  args = varargin;
  NAME = '';
  L = [];
  if (! isempty (args) && ischar (args{1})
      && ! isempty (regexp (args{1}, '^M\d', 'once')))
    NAME = args{1};
    args(1) = [];
    if (! isempty (args) && ! ischar (args{1}))
      L = args{1};
      args(1) = [];
      if (! isnumeric (L) || ! isreal (L) || ! isscalar (L) || ! isfinite (L)
          || L <= 0)
        error ("parts.screw.lowcap: L must be a positive length.");
      endif
    endif
  endif
  if (strcmp (MODE, 'solid') && isempty (L))
    error ("parts.screw.lowcap: a solid needs a NAME and a length L.");
  endif

  maker = '';
  detailed = false;
  B = [];
  if (mod (numel (args), 2) != 0)
    error ("parts.screw.lowcap: Name/Value arguments must come in pairs.");
  endif
  for ii = 1:2:numel (args)
    name = args{ii};
    val = args{ii+1};
    if (! ischar (name) || ! isrow (name))
      error ("parts.screw.lowcap: option names must be character vectors.");
    endif
    switch (lower (name))
      case 'maker'
        if (strcmp (MODE, 'solid'))
          error ("parts.screw.lowcap: 'Maker' applies to 'data' only.");
        endif
        if (! ischar (val) || ! isrow (val))
          error ("parts.screw.lowcap: 'Maker' must be a character vector.");
        endif
        maker = val;
      case 'detailed'
        if (strcmp (MODE, 'data'))
          error ("parts.screw.lowcap: 'Detailed' applies to 'solid' only.");
        endif
        if (! islogical (val) || ! isscalar (val))
          error ("parts.screw.lowcap: 'Detailed' must be true or false.");
        endif
        detailed = val;
      case 'threadlength'
        if (strcmp (MODE, 'data'))
          error (strcat ("parts.screw.lowcap: 'ThreadLength' applies to", ...
                         " 'solid' only."));
        endif
        B = val;
      otherwise
        error ("parts.screw.lowcap: unknown option '%s'.", name);
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
      error (strcat ("parts.screw.lowcap: NAME must name a metric thread,", ...
                     " such as 'M8' or 'M8x1'."));
    endif
    d = str2double (tok{1});
    if (! isempty (tok{2}))
      P = str2double (tok{2});
    endif
  endif

  if (strcmp (MODE, 'data'))
    OUT = catalogue (NAME, d, P, L, maker);
  else
    OUT = shape (d, P, L, B, detailed);
  endif

endfunction

## DIN 7984:2009, a row for each size: d, P, b for 125 or less, up to 200
## and longer, dk max, k max, s nom, t min, r min, the longest length
## threaded to the head, and the shortest and longest commercial length
function T = sizes ()

  T = [3, 0.5, 12, NaN, NaN, 5.5, 2, 2, 1.38, 0.1, 18, 5, 20;
       4, 0.7, 14, NaN, NaN, 7, 2.8, 2.5, 2.18, 0.2, 20, 6, 25;
       5, 0.8, 16, NaN, NaN, 8.5, 3.5, 3, 2.58, 0.2, 25, 8, 30;
       6, 1, 18, NaN, NaN, 10, 4, 4, 2.88, 0.25, 25, 10, 40;
       8, 1.25, 22, 28, NaN, 13, 5, 5, 3.65, 0.4, 30, 12, 80;
       10, 1.5, 26, 32, NaN, 16, 6, 7, 4.35, 0.4, 35, 16, 100;
       12, 1.75, 30, 36, NaN, 18, 7, 8, 4.85, 0.6, 45, 20, 80;
       14, 2, 34, 40, NaN, 21, 8, 10, 5.15, 0.6, 50, 30, 80;
       16, 2, 38, 44, 57, 24, 9, 12, 5.35, 0.6, 55, 30, 80;
       18, 2.5, 42, 48, 61, 27, 10, 12, 6.32, 0.6, 60, 30, 100;
       20, 2.5, 46, 52, 65, 30, 11, 14, 7.32, 0.8, 60, 30, 100;
       22, 2.5, 50, 56, 69, 33, 12, 14, 7.82, 0.8, 70, 40, 100;
       24, 3, 54, 60, 73, 36, 13, 17, 7.82, 0.8, 80, 40, 100];

endfunction

## The thread lengths of screws of size rows h and lengths l by DIN 7984,
## a column: l up to the longest length threaded to the head, else b of the
## length's band, or the formula of ISO 888 where the table gives none
function b = tableform (h, l)

  n = numel (l);
  r = 3 + (l > 125) + (l > 200);
  b = h(sub2ind (size (h), (1:n)', r));
  f = isnan (b);
  b(f) = 2 * h(f,1) + [6, 12, 25](r(f) - 2)(:);
  full = l <= h(:,11);
  b(full) = l(full);

endfunction

## The designations, standards and threads of screws of size rows h, pitches
## P, lengths l and thread lengths b, columns; character vectors for one
function [name, standard, thread] = designate (h, P, l, b)

  series = [5, 6, 8, 10, 12, 14, 16, 18, 20:5:60, 70:10:100];
  n = numel (l);
  iso = (P == h(:,2) & ismember (l, series) & l >= h(:,12) & l <= h(:,13)
         & b == tableform (h, l));
  standard = repmat ({''}, n, 1);
  standard(iso) = {'DIN 7984'};
  denom = 'Hexagon socket head cap screw with low head';
  [name, thread] = parts.__designation__ (denom, standard, h(:,1), P, l, b);
  if (n == 1)
    name = name{1};
    standard = standard{1};
    thread = thread{1};
  endif

endfunction

function C = catalogue (NAME, d, P, L, maker)

  ## Built on the first call, kept for the session
  persistent E;
  if (isempty (E))
    E = entries ();
  endif

  keep = true (size (E));
  if (! isempty (d))
    T = sizes ();
    if (isnan (P) && any (T(:,1) == d))
      P = T(T(:,1) == d,2);
    endif
    keep &= [E.d] == d & [E.P] == P;
  endif
  if (! isempty (L))
    keep &= [E.l] == L;
  endif
  if (! isempty (maker))
    keep &= strcmpi ({E.maker}, maker);
  endif
  C = E(keep);

  if (isempty (C))
    what = '';
    if (! isempty (NAME))
      what = [NAME, ' '];
      if (! isempty (L))
        what = sprintf ("%s x %g ", NAME, L);
      endif
    endif
    how = '';
    if (! isempty (maker))
      how = sprintf (" by %s", maker);
    endif
    error (strcat ("parts.screw.lowcap: no %slow head cap screw%s in the", ...
                   " catalogue."), what, how);
  endif

endfunction

## Every entry of the catalogue, sorted by size, then length
function E = entries ()

  ## BEGIN generated by tools/reyher_tables.py lowcap
  ## REYHER article, printed page, class, finish; then each size
  ## with its lengths
  A = {'07984.800', 362, '08.8', 'plain', {
         3, [5, 6, 8, 10, 12, 16, 18, 20, 25, 30];
         4, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50];
         5, [6, 8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60];
         6, [8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70];
         8, [10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, ...
             70, 80, 90, 100];
         10, [12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, ...
             90, 100, 120];
         12, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100];
         16, [25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100, 110, 120];
         20, [30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100, 110, 120];
         24, [40, 45, 50, 60, 70, 80, 100, 120]};
       '07984.810', 363, '08.8', 'zinc plated', {
         3, [5, 6, 8, 10, 12, 16, 18, 20, 25];
         4, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 50];
         5, [6, 8, 10, 12, 14, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60];
         6, [8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, ...
             70, 80];
         8, [10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             65, 70, 80, 90, 100];
         10, [12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, ...
             90, 100];
         12, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90];
         16, [20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100, 110];
         20, [30, 35, 40, 45, 50, 60, 70, 80, 90];
         24, [40, 50, 60, 70, 80, 100]};
       '07984.100', 364, '010.9', 'plain', {
         4, [10, 12, 16, 20, 25, 30];
         5, [10, 12, 16, 20, 25, 30];
         6, [10, 12, 16, 20, 25, 30];
         8, [12, 16, 20, 25, 30];
         10, [16, 20, 25, 30, 35, 40];
         12, [20, 25, 30, 35, 40]};
      };
  ## END generated

  ## One row for each article, size and length
  Z = vertcat (A{:,5});
  nl = cellfun (@numel, Z(:,2));
  a = repelem (repelem ((1:rows (A))', cellfun (@rows, A(:,5))), nl);
  d = repelem (cell2mat (Z(:,1)), nl);
  l = [Z{:,2}]';
  n = numel (l);

  T = sizes ();
  [~, k] = ismember (d, T(:,1));
  h = T(k,:);
  b = tableform (h, l);
  [name, standard] = designate (h, h(:,2), l, b);
  tool = arrayfun (@(x) sprintf ("%g", x), h(:,8), 'UniformOutput', false);
  source = arrayfun (@(p) sprintf ("REYHER, The Catalogue, 2020.04, p. %d", ...
                                   p), [A{:,2}]', 'UniformOutput', false);

  F = [name, standard, num2cell([d, h(:,2), l, b, h(:,6:7)]), ...
       repmat({'hexsocket'}, n, 1), tool, A(a,3:4), ...
       repmat({'REYHER'}, n, 1), A(a,1), source(a)]';
  E = cell2struct (F, {'designation', 'standard', 'd', 'P', 'l', 'b', ...
                       'dk', 'k', 'drive', 'tool', 'class', 'finish', ...
                       'maker', 'article', 'source'}, 1)';
  [~, k] = sortrows ([d, l], [1, 2]);
  E = E(k);

endfunction

function S = shape (d, P, L, B, detailed)

  T = sizes ();
  h = T(T(:,1) == d,:);
  if (isempty (h))
    error ("parts.screw.lowcap: DIN 7984 defines no M%g head.", d);
  endif
  if (isnan (P))
    P = h(2);
  endif
  if (isempty (B))
    B = tableform (h, L);
  elseif (! isnumeric (B) || ! isreal (B) || ! isscalar (B) || B <= 0
          || B > L)
    error (strcat ("parts.screw.lowcap: 'ThreadLength' must be a length", ...
                   " from 0 to L."));
  endif
  [name, ~, tname] = designate (h, P, L, B);

  dk = h(6);
  k = h(7);
  if (detailed)
    r = h(10);
    R = geom.Region ([0, -L, 0; d / 2, -L, 0; d / 2, -r, -tan(pi/8);
                      d / 2 + r, 0, 0; dk / 2, 0, 0; dk / 2, k, 0; 0, k, 0]);
  else
    R = geom.Region ([0, -L; d / 2, -L; d / 2, 0; dk / 2, 0; dk / 2, k;
                      0, k]);
  endif
  R.UCS = geom.UCS ([0, -1, 0], [0, 0, 0]);
  S = solid.revolve (R);
  if (detailed)
    if (B == L)
      B = L - 3 * P;
    endif
    S = thread (S, [0, 0, -L], tname, B, 'Direction', [0, 0, 1], ...
                'Custom', true);
  endif
  S = parts.screw.__recess__ (S, 'hexsocket', h(8:9), k);
  S.Name = name;

endfunction

%!test  # the catalogue, every article in every size and length
%! C = parts.screw.lowcap ('data');
%! assert_equal (numel (C), 306);
%!test  # an article as REYHER lists it
%! C = parts.screw.lowcap ('data', 'M8', 20);
%! E = C(strcmp ({C.article}, '07984.800'));
%! assert_equal ({E.designation, E.class, E.finish, E.tool}, ...
%!               {['Hexagon socket head cap screw with low head', ...
%!                 ' DIN 7984 - M8 x 20'], ...
%!                '08.8', 'plain', '5'});
%!test  # its sizes
%! C = parts.screw.lowcap ('data', 'M8', 20);
%! E = C(strcmp ({C.article}, '07984.800'));
%! assert_equal ([E.d, E.P, E.l, E.b, E.dk, E.k], [8, 1.25, 20, 20, 13, 5]);
%!test  # a length below the dashed line has its b
%! C = parts.screw.lowcap ('data', 'M8', 40);
%! assert_equal (unique ([C.b]), 22);
%!test  # a length past the table is custom
%! C = parts.screw.lowcap ('data', 'M10', 120);
%! assert_equal (C(1).standard, '');
%!testif ; exist ('__occt__') == 3  # head, shank and socket
%! S = parts.screw.lowcap ('solid', 'M8', 20);
%! V = pi * (6.5 ^ 2 * 5 + 4 ^ 2 * 20) - sqrt (3) / 2 * 5 ^ 2 * 3.65;
%! assert_equal (volume (S), V, 1e-6);
%!testif ; exist ('__occt__') == 3  # the underside of the head on the plane
%! S = parts.screw.lowcap ('solid', 'M8', 20);
%! assert_equal (bbox (S), [-6.5, -6.5, -20, 6.5, 6.5, 5], 1e-6);
%!testif ; exist ('__occt__') == 3  # named by its designation
%! S = parts.screw.lowcap ('solid', 'M8', 40, 'ThreadLength', 40);
%! assert_equal (S.Name, ...
%!               {'Hexagon socket head cap screw with low head M8 x 40'});
%!testif ; exist ('__occt__') == 3  # detailed: fillet and thread
%! S = parts.screw.lowcap ('solid', 'M5', 30, 'Detailed', true);
%! assert_equal (isvalid (S), true);

%!error<parts.screw.lowcap: MODE must be 'data' or 'solid'.> ...
%! parts.screw.lowcap ()
%!error<parts.screw.lowcap: a solid needs a NAME and a length L.> ...
%! parts.screw.lowcap ('solid', 'M8')
%!error<parts.screw.lowcap: L must be a positive length.> ...
%! parts.screw.lowcap ('solid', 'M8', -1)
%!error<parts.screw.lowcap: NAME must name a metric thread, such as 'M8' or 'M8x1'.> ...
%! parts.screw.lowcap ('data', 'M8y')
%!error<parts.screw.lowcap: Name/Value arguments must come in pairs.> ...
%! parts.screw.lowcap ('data', 'M8', 'Maker')
%!error<parts.screw.lowcap: option names must be character vectors.> ...
%! parts.screw.lowcap ('data', 8, 'Maker')
%!error<parts.screw.lowcap: unknown option 'Drive'.> ...
%! parts.screw.lowcap ('data', 'Drive', 'torx')
%!error<parts.screw.lowcap: 'Maker' applies to 'data' only.> ...
%! parts.screw.lowcap ('solid', 'M8', 20, 'Maker', 'REYHER')
%!error<parts.screw.lowcap: 'Maker' must be a character vector.> ...
%! parts.screw.lowcap ('data', 'Maker', 1)
%!error<parts.screw.lowcap: 'Detailed' applies to 'solid' only.> ...
%! parts.screw.lowcap ('data', 'Detailed', true)
%!error<parts.screw.lowcap: 'Detailed' must be true or false.> ...
%! parts.screw.lowcap ('solid', 'M8', 20, 'Detailed', 'yes')
%!error<parts.screw.lowcap: 'Detailed' must be true or false.> ...
%! parts.screw.lowcap ('solid', 'M8', 20, 'Detailed', 1)
%!error<parts.screw.lowcap: 'ThreadLength' applies to 'solid' only.> ...
%! parts.screw.lowcap ('data', 'ThreadLength', 10)
%!error<parts.screw.lowcap: 'ThreadLength' must be a length from 0 to L.> ...
%! parts.screw.lowcap ('solid', 'M8', 20, 'ThreadLength', 30)
%!error<parts.screw.lowcap: DIN 7984 defines no M7 head.> ...
%! parts.screw.lowcap ('solid', 'M7', 20)
%!error<parts.screw.lowcap: no M7 low head cap screw in the catalogue.> ...
%! parts.screw.lowcap ('data', 'M7')
%!error<parts.screw.lowcap: no M8 x 21 low head cap screw by NSK in the catalogue.> ...
%! parts.screw.lowcap ('data', 'M8', 21, 'Maker', 'NSK')
