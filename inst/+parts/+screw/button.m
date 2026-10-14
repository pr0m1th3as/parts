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
## @deftypefn  {parts} {@var{C} =} parts.screw.button (@qcode{'data'})
## @deftypefnx {parts} {@var{C} =} parts.screw.button (@qcode{'data'}, @var{NAME})
## @deftypefnx {parts} {@var{C} =} parts.screw.button (@qcode{'data'}, @var{NAME}, @var{L})
## @deftypefnx {parts} {@var{S} =} parts.screw.button (@qcode{'solid'}, @var{NAME}, @var{L})
## @deftypefnx {parts} {@dots{} =} parts.screw.button (@dots{}, @var{Name}, @var{Value})
##
## Hexagon socket button head screws, ISO 7380-1, and with collar,
## ISO 7380-2.
##
## @code{@var{C} = parts.screw.button (@qcode{'data'})} returns every button
## head screw in the catalogue as a struct array, one entry for each maker's
## article in each size and length, sorted by size and length.
## @code{@var{C} = parts.screw.button (@qcode{'data'}, @var{NAME})} returns
## those of the thread @var{NAME}, such as @qcode{'M5'}, and
## @code{@var{C} = parts.screw.button (@qcode{'data'}, @var{NAME}, @var{L})}
## those of nominal length @var{L} too: every article sold as that screw,
## each with its property class and finish.  Nothing is built.
##
## @code{@var{S} = parts.screw.button (@qcode{'solid'}, @var{NAME}, @var{L})}
## builds the screw as a @code{solid.Shape} whether or not anyone sells it:
## any thread of a size the standard defines, any pitch, any length.  The
## bearing face of the head lies on the @math{xy} plane, the head above it,
## the shank below it to @math{z} = -@var{L}, the socket with two corners
## on the @math{x} axis.  @code{@var{S}.Name} holds the screw's
## designation.
##
## Name/Value pairs:
##
## @table @asis
## @item @qcode{'Flange'}
## @code{true} for the screw with a collar under its head, ISO 7380-2;
## @code{false} for the plain head, ISO 7380-1, the default of a solid.
## For @qcode{'data'} it keeps those screws only; without it both come.
##
## @item @qcode{'Maker'}
## For @qcode{'data'}: only that maker's articles, such as
## @qcode{'REYHER'}, in any case.
##
## @item @qcode{'ThreadLength'}
## For @qcode{'solid'}: the length of thread @var{b} from the end of the
## shank, from 0 to @var{L}; @var{L} threads it to the head.  Without it the
## screw follows Table 1 of ISO 7380-1 or ISO 7380-2, which agree:
## threaded to the head up to the length the table gives, longer ones
## threaded @var{b}.
##
## @item @qcode{'Detailed'}
## For @qcode{'solid'}: @code{true} also builds the fillet under the head,
## of radius @var{rs} under a plain shank and @var{rt} on a screw threaded
## to the head, and the thread, cut by @code{solid.Shape.thread}; a thread
## to the head runs to within 3@var{P} of it.  By default (@code{false})
## the shank is a plain cylinder of diameter @var{d}.  Either way the socket
## is cut to its smallest depth @var{t} and the end is left flat, as rolled.
## @end table
##
## The head is a dome that springs from the bearing face, or from the
## collar of ISO 7380-2, @var{dk} across and rises to @var{k} above the
## bearing face; its radius follows from the two, the standards giving
## @var{rf} for reference and leaving the contour to the maker.  The collar
## is @var{dc} across and @var{c} high.
##
## Each entry is a struct with these fields, lengths in millimetres:
##
## @multitable @columnfractions 0.16 0.84
## @item @code{designation} @tab the designation of ISO 8991, as in
## @qcode{'Hexagon socket button head screw ISO 7380-1 - M5 x 20'}, without
## the property class
## @item @code{standard} @tab @qcode{'ISO 7380-1'} or @qcode{'ISO 7380-2'}
## when its table defines the screw, else empty: such a screw is custom
## @item @code{d} @tab nominal diameter
## @item @code{P} @tab pitch, coarse
## @item @code{l} @tab nominal length
## @item @code{b} @tab length of thread from the end, @var{l} when threaded
## to the head
## @item @code{dk} @tab head diameter, largest
## @item @code{dc} @tab collar diameter, largest; NaN without a collar
## @item @code{k} @tab head height, the collar included, largest
## @item @code{drive} @tab @qcode{'hexsocket'}
## @item @code{tool} @tab the hexagon key, across flats, as @qcode{'3'}
## @item @code{class} @tab property class or material, as REYHER prints it:
## @qcode{'010.9'} marks the reduced loadability of the head
## @item @code{finish} @tab the finish as the maker names it
## @item @code{maker} @tab the maker
## @item @code{article} @tab the maker's article number
## @item @code{source} @tab the catalogue and page the article was read from
## @end multitable
##
## A screw is designated by the standard's number when its table defines it:
## a length of the size's commercial range with the thread form the table
## gives it.  Every other screw is custom and takes its standard's title,
## its thread length written when shorter than @var{l}, as
## @qcode{'Hexagon socket button head screw with collar M5 x 60 x 22'}.
##
## @subheading The catalogue
##
## Articles from REYHER, @cite{The Catalogue}, edition 2020.04, English,
## pages 342 to 345 (steel) and 571 to 573 (stainless steel): every article
## with a hexagon socket.  Left out: the hexalobular articles 07380.114,
## 07380.349, 07380.921 and 07380.924, whose socket ISO 7380 does not
## define.  REYHER notes that some of its screws are threaded to the head;
## they are taken here as the standard threads them.
##
## Heads, sockets, thread lengths and lengths from ISO 7380-1:2011 and
## ISO 7380-2:2011, read in their official previews, which agree with
## GOST ISO 7380-1-2014 and GOST ISO 7380-2-2014.
##
## @seealso{parts.screw.cap, parts.screw.lowcap}
## @end deftypefn

function OUT = button (MODE, varargin)

  if (nargin < 1 || ! ischar (MODE)
      || ! any (strcmp (MODE, {'data', 'solid'})))
    error ("parts.screw.button: MODE must be 'data' or 'solid'.");
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
        error ("parts.screw.button: L must be a positive length.");
      endif
    endif
  endif
  if (strcmp (MODE, 'solid') && isempty (L))
    error ("parts.screw.button: a solid needs a NAME and a length L.");
  endif

  flange = false;
  byflange = false;
  maker = '';
  detailed = false;
  B = [];
  if (mod (numel (args), 2) != 0)
    error ("parts.screw.button: Name/Value arguments must come in pairs.");
  endif
  for ii = 1:2:numel (args)
    name = args{ii};
    val = args{ii+1};
    if (! ischar (name) || ! isrow (name))
      error ("parts.screw.button: option names must be character vectors.");
    endif
    switch (lower (name))
      case 'flange'
        if (! islogical (val) || ! isscalar (val))
          error ("parts.screw.button: 'Flange' must be true or false.");
        endif
        flange = val;
        byflange = true;
      case 'maker'
        if (strcmp (MODE, 'solid'))
          error ("parts.screw.button: 'Maker' applies to 'data' only.");
        endif
        if (! ischar (val) || ! isrow (val))
          error ("parts.screw.button: 'Maker' must be a character vector.");
        endif
        maker = val;
      case 'detailed'
        if (strcmp (MODE, 'data'))
          error ("parts.screw.button: 'Detailed' applies to 'solid' only.");
        endif
        if (! islogical (val) || ! isscalar (val))
          error ("parts.screw.button: 'Detailed' must be true or false.");
        endif
        detailed = val;
      case 'threadlength'
        if (strcmp (MODE, 'data'))
          error (strcat ("parts.screw.button: 'ThreadLength' applies to", ...
                         " 'solid' only."));
        endif
        B = val;
      otherwise
        error ("parts.screw.button: unknown option '%s'.", name);
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
      error (strcat ("parts.screw.button: NAME must name a metric thread,", ...
                     " such as 'M5' or 'M5x0.5'."));
    endif
    d = str2double (tok{1});
    if (! isempty (tok{2}))
      P = str2double (tok{2});
    endif
  endif

  if (strcmp (MODE, 'data'))
    OUT = catalogue (NAME, d, P, L, flange, byflange, maker);
  else
    OUT = shape (d, P, L, B, flange, detailed);
  endif

endfunction

## ISO 7380-1:2011 and ISO 7380-2:2011, a row for each size: d, P, dk max
## (7380-1), dk max, dc max and c max (7380-2), k max, s nom, t min, rs
## min, rt min, b ref, the longest length threaded to the head, and the
## shortest and longest commercial length
function T = sizes ()

  T = [3, 0.5, 5.7, 5.2, 6.9, 0.7, 1.65, 2, 1.04, 0.1, 0.3, 18, 20, 6, 30;
       4, 0.7, 7.6, 7.2, 9.4, 0.8, 2.2, 2.5, 1.3, 0.2, 0.4, 20, 25, 6, 40;
       5, 0.8, 9.5, 8.8, 11.8, 1, 2.75, 3, 1.56, 0.2, 0.45, 22, 25, 8, 50;
       6, 1, 10.5, 10, 13.6, 1.2, 3.3, 4, 2.08, 0.25, 0.5, 24, 30, 10, 60;
       8, 1.25, 14, 13.2, 17.8, 1.5, 4.4, 5, 2.6, 0.4, 0.7, 28, 35, 12, 80;
       10, 1.5, 17.5, 16.5, 21.9, 2, 5.5, 6, 3.12, 0.4, 0.7, 32, 40, 16, 90;
       12, 1.75, 21, 19.4, 26, 2.4, 6.6, 8, 4.16, 0.6, 1.1, 36, 50, 20, 90;
       16, 2, 28, 26, 34, 2.8, 8.8, 10, 5.2, 0.6, 1.1, 44, 60, 25, 90];

endfunction

## The thread lengths of screws of size rows h and lengths l by Table 1, a
## column
function b = tableform (h, l)

  b = l;
  part = l > h(:,13);
  b(part) = h(part,12);

endfunction

## The designations, standards and threads of screws of size rows h,
## pitches P, lengths l, thread lengths b and collars FLANGE, columns;
## character vectors for one
function [name, standard, thread] = designate (h, P, l, b, flange)

  series = [6, 8, 10, 12, 16, 20:5:70, 80, 90];
  n = numel (l);
  flange = flange(:) & true (n, 1);
  iso = (P == h(:,2) & ismember (l, series) & l >= h(:,14) & l <= h(:,15)
         & b == tableform (h, l));
  standard = repmat ({''}, n, 1);
  standard(iso & ! flange) = {'ISO 7380-1'};
  standard(iso & flange) = {'ISO 7380-2'};
  denom = repmat ({'Hexagon socket button head screw'}, n, 1);
  denom(! iso & flange) = {'Hexagon socket button head screw with collar'};
  [name, thread] = parts.__designation__ (denom, standard, h(:,1), P, l, b);
  if (n == 1)
    name = name{1};
    standard = standard{1};
    thread = thread{1};
  endif

endfunction

function C = catalogue (NAME, d, P, L, flange, byflange, maker)

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
  if (byflange)
    keep &= ! isnan ([E.dc]) == flange;
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
    if (byflange && flange)
      how = " with collar";
    elseif (byflange)
      how = " without collar";
    endif
    if (! isempty (maker))
      how = sprintf ("%s by %s", how, maker);
    endif
    error ("parts.screw.button: no %sbutton head screw%s in the catalogue.", ...
           what, how);
  endif

endfunction

## Every entry of the catalogue, sorted by size, then length
function E = entries ()

  ## BEGIN generated by tools/reyher_tables.py button
  ## REYHER article, printed page, collar, class, finish; then each
  ## size with its lengths
  A = {'07380.100', 342, false, '010.9', 'plain', {
         3, [5, 6, 8, 10, 12, 16, 20, 25];
         4, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40];
         5, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 45];
         6, [6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, ...
             60];
         8, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60];
         10, [12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60]};
       '07380.110', 343, false, '010.9', 'zinc plated', {
         3, [5, 6, 8, 10, 12, 16, 20, 25, 30];
         4, [5, 6, 8, 10, 12, 16, 20, 25, 30, 40];
         5, [6, 8, 10, 12, 14, 16, 20, 25, 30, 35, 40, 45];
         6, [6, 8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60];
         8, [8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60];
         10, [12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60];
         12, [14, 16, 20, 25, 30, 35, 40, 45, 50, 60];
         16, [30, 40, 45, 50, 60]};
       '07380.102', 344, true, '010.9', 'plain', {
         4, [6, 8, 10, 12, 16, 20, 25, 30];
         5, [6, 8, 10, 12, 16, 20, 25, 30, 35];
         6, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40];
         8, [12, 16, 20, 25, 30, 35, 40, 50, 60];
         10, [20, 25, 30, 35]};
       '07380.112', 344, true, '010.9', 'zinc plated', {
         3, [6, 8, 10, 12];
         4, [6, 8, 10, 12, 16, 20, 25, 30];
         5, [6, 8, 10, 12, 16, 20, 25, 30, 35];
         6, [8, 10, 12, 14, 16, 20, 25, 30, 35, 40, 45, 50, 60];
         8, [10, 12, 14, 16, 20, 25, 30, 35, 40, 45, 50, 60];
         10, [20, 30, 35, 40, 50];
         12, [20, 25, 30, 40, 50, 60]};
       '07380.920', 571, false, 'A2', 'plain', {
         3, [4, 5, 6, 8, 10, 12, 16, 20, 25];
         4, [4, 5, 6, 8, 10, 12, 16, 20, 25, 30, 35];
         5, [6, 8, 10, 12, 16, 20, 25, 30, 40, 45];
         6, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60];
         8, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60];
         10, [16, 20, 25, 30, 40, 50]};
       '07380.922', 572, true, 'A2', 'plain', {
         3, [6, 8, 10];
         4, [6, 8, 10, 12, 16, 20, 25];
         5, [6, 8, 10, 12, 16, 20, 25];
         6, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45];
         8, [10, 12, 16, 20, 25]};
      };
  ## END generated

  ## One row for each article, size and length
  Z = vertcat (A{:,6});
  nl = cellfun (@numel, Z(:,2));
  a = repelem (repelem ((1:rows (A))', cellfun (@rows, A(:,6))), nl);
  d = repelem (cell2mat (Z(:,1)), nl);
  l = [Z{:,2}]';
  n = numel (l);
  flange = [A{a,3}]';

  T = sizes ();
  [~, k] = ismember (d, T(:,1));
  h = T(k,:);
  b = tableform (h, l);
  [name, standard] = designate (h, h(:,2), l, b, flange);
  dk = h(:,3);
  dk(flange) = h(flange,4);
  dc = NaN (n, 1);
  dc(flange) = h(flange,5);
  tool = arrayfun (@(s) sprintf ("%g", s), h(:,8), 'UniformOutput', false);
  source = arrayfun (@(p) sprintf ("REYHER, The Catalogue, 2020.04, p. %d", ...
                                   p), [A{:,2}]', 'UniformOutput', false);

  F = [name, standard, num2cell([d, h(:,2), l, b, dk, dc, h(:,7)]), ...
       repmat({'hexsocket'}, n, 1), tool, A(a,4:5), ...
       repmat({'REYHER'}, n, 1), A(a,1), source(a)]';
  E = cell2struct (F, {'designation', 'standard', 'd', 'P', 'l', 'b', ...
                       'dk', 'dc', 'k', 'drive', 'tool', 'class', ...
                       'finish', 'maker', 'article', 'source'}, 1)';
  [~, k] = sortrows ([d, l], [1, 2]);
  E = E(k);

endfunction

function S = shape (d, P, L, B, flange, detailed)

  T = sizes ();
  h = T(T(:,1) == d,:);
  if (isempty (h))
    if (flange)
      error ("parts.screw.button: ISO 7380-2 defines no M%g head.", d);
    else
      error ("parts.screw.button: ISO 7380-1 defines no M%g head.", d);
    endif
  endif
  if (isnan (P))
    P = h(2);
  endif
  if (isempty (B))
    B = tableform (h, L);
  elseif (! isnumeric (B) || ! isreal (B) || ! isscalar (B) || B <= 0
          || B > L)
    error (strcat ("parts.screw.button: 'ThreadLength' must be a length", ...
                   " from 0 to L."));
  endif
  [name, ~, tname] = designate (h, P, L, B, flange);

  k = h(7);
  if (detailed)
    if (B == L)
      r = h(11);
    else
      r = h(10);
    endif
    U = [0, -L, 0; d / 2, -L, 0; d / 2, -r, -tan(pi/8); d / 2 + r, 0, 0];
  else
    U = [0, -L, 0; d / 2, -L, 0; d / 2, 0, 0];
  endif
  ## The collar, then the dome from dk across to the top, its radius
  ## following
  if (flange)
    dk = h(4);
    c = h(6);
    U = [U; h(5) / 2, 0, 0; h(5) / 2, c, 0];
  else
    dk = h(3);
    c = 0;
  endif
  rho = dk / 2;
  rf = (rho ^ 2 + (k - c) ^ 2) / (2 * (k - c));
  w = asin (rho / rf);
  R = geom.Region ([U; rho, c, tan(w/4); 0, k, 0]);
  R.UCS = geom.UCS ([0, -1, 0], [0, 0, 0]);
  S = solid.revolve (R);
  S = parts.screw.__recess__ (S, 'hexsocket', h(8:9), k);
  if (detailed)
    if (B == L)
      B = L - 3 * P;
    endif
    S = thread (S, [0, 0, -L], tname, B, 'Direction', [0, 0, 1], ...
                'Custom', true);
  endif
  S.Name = name;

endfunction

%!test  # the catalogue, every article in every size and length
%! C = parts.screw.button ('data');
%! assert_equal (numel (C), 347);
%!test  # an article as REYHER lists it
%! C = parts.screw.button ('data', 'M5', 20);
%! E = C(strcmp ({C.article}, '07380.100'));
%! assert_equal ({E.designation, E.class, E.finish, E.tool, E.drive}, ...
%!               {'Hexagon socket button head screw ISO 7380-1 - M5 x 20', ...
%!                '010.9', 'plain', '3', 'hexsocket'});
%!test  # its sizes
%! C = parts.screw.button ('data', 'M5', 20);
%! E = C(strcmp ({C.article}, '07380.100'));
%! assert_equal ([E.d, E.P, E.l, E.b, E.dk, E.dc, E.k], ...
%!               [5, 0.8, 20, 20, 9.5, NaN, 2.75]);
%!test  # with collar, ISO 7380-2
%! C = parts.screw.button ('data', 'M5', 20, 'Flange', true);
%! assert_equal ({C(1).designation, C(1).dk, C(1).dc}, ...
%!               {'Hexagon socket button head screw ISO 7380-2 - M5 x 20', ...
%!                8.8, 11.8});
%!test  # 'Flange' false keeps the plain heads
%! C = parts.screw.button ('data', 'M5', 20, 'Flange', false);
%! assert_equal (isnan ([C.dc]), true (1, numel (C)));
%!test  # a length past the table is b
%! C = parts.screw.button ('data', 'M10', 50);
%! assert_equal ([C(1).b], 32);
%!test  # a length off the series is custom
%! C = parts.screw.button ('data', 'M6', 14, 'Flange', true);
%! assert_equal (unique ({C.designation}), ...
%!               {'Hexagon socket button head screw with collar M6 x 14'});
%!testif ; exist ('__occt__') == 3  # the dome, the socket below its top
%! S = parts.screw.button ('solid', 'M5', 30);
%! R = (4.75 ^ 2 + 2.75 ^ 2) / 5.5;
%! z = 2.75 - R + sqrt (R ^ 2 - 2.25);
%! assert_equal (bbox (S), [-4.75, -4.75, -30, 4.75, 4.75, z], 1e-6);
%!testif ; exist ('__occt__') == 3  # the collar
%! S = parts.screw.button ('solid', 'M5', 30, 'Flange', true);
%! assert_equal (bbox (S)([1, 4]), [-5.9, 5.9], 1e-6);
%!testif ; exist ('__occt__') == 3  # named by its designation
%! S = parts.screw.button ('solid', 'M5', 30, 'Flange', true);
%! assert_equal (S.Name, ...
%!               {'Hexagon socket button head screw ISO 7380-2 - M5 x 30'});
%!testif ; exist ('__occt__') == 3  # custom by its thread length
%! S = parts.screw.button ('solid', 'M5', 60, 'ThreadLength', 60);
%! assert_equal (S.Name, {'Hexagon socket button head screw M5 x 60'});
%!testif ; exist ('__occt__') == 3  # every head dk across
%! S = parts.screw.button ('solid', 'M12', 30);
%! assert_equal (bbox (S)([1, 4]), [-10.5, 10.5], 1e-6);
%!testif ; exist ('__occt__') == 3  # detailed: fillet, thread
%! S = parts.screw.button ('solid', 'M8', 30, 'Flange', true, ...
%!                         'Detailed', true);
%! assert_equal (isvalid (S), true);

%!error<parts.screw.button: MODE must be 'data' or 'solid'.> ...
%! parts.screw.button ()
%!error<parts.screw.button: a solid needs a NAME and a length L.> ...
%! parts.screw.button ('solid', 'M5')
%!error<parts.screw.button: L must be a positive length.> ...
%! parts.screw.button ('solid', 'M5', 0)
%!error<parts.screw.button: NAME must name a metric thread, such as 'M5' or 'M5x0.5'.> ...
%! parts.screw.button ('data', 'M5y')
%!error<parts.screw.button: Name/Value arguments must come in pairs.> ...
%! parts.screw.button ('data', 'M5', 'Maker')
%!error<parts.screw.button: option names must be character vectors.> ...
%! parts.screw.button ('data', 5, 'Maker')
%!error<parts.screw.button: unknown option 'Drive'.> ...
%! parts.screw.button ('data', 'Drive', 'torx')
%!error<parts.screw.button: 'Flange' must be true or false.> ...
%! parts.screw.button ('data', 'Flange', 'yes')
%!error<parts.screw.button: 'Flange' must be true or false.> ...
%! parts.screw.button ('data', 'Flange', 1)
%!error<parts.screw.button: 'Maker' applies to 'data' only.> ...
%! parts.screw.button ('solid', 'M5', 20, 'Maker', 'REYHER')
%!error<parts.screw.button: 'Maker' must be a character vector.> ...
%! parts.screw.button ('data', 'Maker', 1)
%!error<parts.screw.button: 'Detailed' applies to 'solid' only.> ...
%! parts.screw.button ('data', 'Detailed', true)
%!error<parts.screw.button: 'Detailed' must be true or false.> ...
%! parts.screw.button ('solid', 'M5', 20, 'Detailed', 'yes')
%!error<parts.screw.button: 'Detailed' must be true or false.> ...
%! parts.screw.button ('solid', 'M5', 20, 'Detailed', 1)
%!error<parts.screw.button: 'ThreadLength' applies to 'solid' only.> ...
%! parts.screw.button ('data', 'ThreadLength', 10)
%!error<parts.screw.button: 'ThreadLength' must be a length from 0 to L.> ...
%! parts.screw.button ('solid', 'M5', 20, 'ThreadLength', 30)
%!error<parts.screw.button: ISO 7380-1 defines no M20 head.> ...
%! parts.screw.button ('solid', 'M20', 40)
%!error<parts.screw.button: ISO 7380-2 defines no M20 head.> ...
%! parts.screw.button ('solid', 'M20', 40, 'Flange', true)
%!error<parts.screw.button: no M2 button head screw in the catalogue.> ...
%! parts.screw.button ('data', 'M2')
%!error<parts.screw.button: no M16 x 20 button head screw with collar by NSK in the catalogue.> ...
%! parts.screw.button ('data', 'M16', 20, 'Flange', true, 'Maker', 'NSK')
