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
## @deftypefn  {parts} {@var{C} =} parts.screw.shoulder (@qcode{'data'})
## @deftypefnx {parts} {@var{C} =} parts.screw.shoulder (@qcode{'data'}, @var{DS})
## @deftypefnx {parts} {@var{C} =} parts.screw.shoulder (@qcode{'data'}, @var{DS}, @var{L})
## @deftypefnx {parts} {@var{S} =} parts.screw.shoulder (@qcode{'solid'}, @var{DS}, @var{L})
## @deftypefnx {parts} {@dots{} =} parts.screw.shoulder (@dots{}, @var{Name}, @var{Value})
##
## Hexagon socket head shoulder screws, ISO 7379.
##
## A shoulder screw is sized by its shoulder: diameter @var{DS} and length
## @var{L}, from the underside of the head to the end of the shoulder.
##
## @code{@var{C} = parts.screw.shoulder (@qcode{'data'})} returns every
## shoulder screw in the catalogue as a table, one row for each maker's
## article in each size and length, sorted by shoulder diameter and
## length.  @code{@var{C} = parts.screw.shoulder (@qcode{'data'}, @var{DS})}
## returns those of shoulder diameter @var{DS}, and
## @code{@var{C} = parts.screw.shoulder (@qcode{'data'}, @var{DS}, @var{L})}
## those of shoulder length @var{L} too: every article sold as that screw,
## each with its shank fit, property class and finish.  Nothing is built.
##
## @code{@var{S} = parts.screw.shoulder (@qcode{'solid'}, @var{DS}, @var{L})}
## builds the screw as a @code{solid.Shape} whether or not anyone sells it.
## The underside of the head lies on the @math{xy} plane, the head above it,
## the shoulder below it to @math{z} = -@var{L} and the thread below that,
## @var{b} long; the socket is sunk into the head with two of its corners on
## the @math{x} axis.  @code{@var{S}.Name} holds the screw's designation.
##
## Name/Value pairs:
##
## @table @asis
## @item @qcode{'Thread'}
## For @qcode{'solid'}: the thread, as @qcode{'M8'} or @qcode{'M8x1'},
## whose head, socket and thread length the screw takes.  Without it the
## thread is the one ISO 7379 gives @var{DS}; a shoulder diameter the
## standard does not list needs it.
##
## @item @qcode{'Maker'}
## For @qcode{'data'}: only that maker's articles, such as
## @qcode{'REYHER'}, in any case.
##
## @item @qcode{'Detailed'}
## For @qcode{'solid'}: @code{true} also cuts the undercut under the head,
## @var{dg1} across and @var{g1} wide with its 45 degree flank, the undercut
## at the end of the shoulder, @var{dg2} across and @var{g2} wide, and the
## thread, by @code{solid.Shape.thread}.  By default (@code{false}) the
## shoulder and the thread are plain cylinders.  The radii @var{r1} and
## @var{r2} and the chamfer at the end of the thread are left out.
## @end table
##
## The table has these variables, each with its unit and its description,
## which @code{summary (@var{C})} lists; lengths are in millimetres:
##
## @multitable @columnfractions 0.16 0.84
## @item @code{designation} @tab designation of ISO 8991, as in
## @qcode{'Hexagon socket head shoulder screw ISO 7379 - 10 x 40'}, without
## the property class
## @item @code{standard} @tab @qcode{'ISO 7379'} when the standard defines
## the screw, else empty: such a screw is custom
## @item @code{ds} @tab shoulder diameter
## @item @code{d} @tab thread diameter
## @item @code{P} @tab pitch, coarse
## @item @code{l} @tab shoulder length
## @item @code{b} @tab thread length, largest
## @item @code{dk} @tab head diameter, plain head, largest
## @item @code{k} @tab head height, largest
## @item @code{fit} @tab tolerance of the shoulder, @qcode{'f9'} as
## ISO 7379 gives it or @qcode{'h8'}
## @item @code{drive} @tab @qcode{'hexsocket'}
## @item @code{tool} @tab hexagon key, as @qcode{'5'}
## @item @code{class} @tab property class or stainless steel grade
## @item @code{finish} @tab finish as the maker names it
## @item @code{maker} @tab maker
## @item @code{article} @tab maker's article number
## @item @code{source} @tab catalogue and page the article was read from
## @end multitable
##
## A screw is designated by the standard's number when ISO 7379 defines it:
## a shoulder diameter of its table with the thread it gives, a shoulder of
## fit f9, and a length of the table's commercial range or of ISO 888 within
## it; the thread is then not written.  Every other screw is custom and
## writes its thread, as @qcode{'Hexagon socket head shoulder screw 6-M5 x
## 20'}.  The market's 6-M5 and 12-M10 are custom, the standard giving 6.5
## and 13.
##
## @subheading The catalogue
##
## Articles from REYHER, @cite{The Catalogue}, edition 2020.04, English,
## pages 342 (steel) and 571 (stainless steel): every article.
##
## Dimensions and commercial ranges of lengths from ISO 7379:1983, read in
## its official preview and in GOST 28962-91, which adopts it and agrees
## with it in every value used here.  REYHER's @cite{Technical
## Information} (2019, TI-13) gives the same heads, sockets and thread
## lengths, and the heads of the market's 6-M5 and 12-M10.
##
## @seealso{parts.screw.cap, parts.screw.set}
## @end deftypefn

function OUT = shoulder (MODE, varargin)

  if (nargin < 1 || ! ischar (MODE)
      || ! any (strcmp (MODE, {'data', 'solid'})))
    error ("parts.screw.shoulder: MODE must be 'data' or 'solid'.");
  endif

  ## A shoulder diameter DS and length L lead the Name/Value pairs
  args = varargin;
  DS = [];
  L = [];
  if (! isempty (args) && ! ischar (args{1}))
    DS = args{1};
    args(1) = [];
    if (! isnumeric (DS) || ! isreal (DS) || ! isscalar (DS)
        || ! isfinite (DS) || DS <= 0)
      error ("parts.screw.shoulder: DS must be a positive diameter.");
    endif
    if (! isempty (args) && ! ischar (args{1}))
      L = args{1};
      args(1) = [];
      if (! isnumeric (L) || ! isreal (L) || ! isscalar (L) || ! isfinite (L)
          || L <= 0)
        error ("parts.screw.shoulder: L must be a positive length.");
      endif
    endif
  endif
  if (strcmp (MODE, 'solid') && isempty (L))
    error (strcat ("parts.screw.shoulder: a solid needs a shoulder", ...
                   " diameter DS and a length L."));
  endif

  tspec = '';
  maker = '';
  detailed = false;
  if (mod (numel (args), 2) != 0)
    error ("parts.screw.shoulder: Name/Value arguments must come in pairs.");
  endif
  for ii = 1:2:numel (args)
    name = args{ii};
    val = args{ii+1};
    if (! ischar (name) || ! isrow (name))
      error ("parts.screw.shoulder: option names must be character vectors.");
    endif
    switch (lower (name))
      case 'thread'
        if (strcmp (MODE, 'data'))
          error ("parts.screw.shoulder: 'Thread' applies to 'solid' only.");
        endif
        tspec = val;
      case 'maker'
        if (strcmp (MODE, 'solid'))
          error ("parts.screw.shoulder: 'Maker' applies to 'data' only.");
        endif
        if (! ischar (val) || ! isrow (val))
          error ("parts.screw.shoulder: 'Maker' must be a character vector.");
        endif
        maker = val;
      case 'detailed'
        if (strcmp (MODE, 'data'))
          error ("parts.screw.shoulder: 'Detailed' applies to 'solid' only.");
        endif
        if (! islogical (val) || ! isscalar (val))
          error ("parts.screw.shoulder: 'Detailed' must be true or false.");
        endif
        detailed = val;
      otherwise
        error ("parts.screw.shoulder: unknown option '%s'.", name);
    endswitch
  endfor

  if (strcmp (MODE, 'data'))
    OUT = catalogue (DS, L, maker);
  else
    OUT = shape (DS, L, tspec, detailed);
  endif

endfunction

## ISO 7379:1983, a row for each size: ds, d, P, b max, dk max (plain head),
## k max, s nom, t min, dg1 min, g1 max, dg2 max, g2 max, and the shortest
## and longest length of the commercial range
function T = sizes ()

  T = [6.5, 5, 0.8, 9.75, 10, 4.5, 3, 2.4, 5.92, 2.5, 3.86, 2, 10, 40;
       8, 6, 1, 11.25, 13, 5.5, 4, 3.3, 7.42, 2.5, 4.58, 2.5, 12, 50;
       10, 8, 1.25, 13.25, 16, 7, 5, 4.2, 9.42, 2.5, 6.25, 3.1, 16, 120;
       13, 10, 1.5, 16.4, 18, 9, 6, 4.9, 12.42, 2.5, 7.91, 3.7, 16, 120;
       16, 12, 1.75, 18.4, 24, 11, 8, 6.6, 15.42, 2.5, 9.57, 4.4, 30, 120;
       20, 16, 2, 22.4, 30, 14, 10, 8.8, 19.42, 2.5, 13.33, 5, 40, 120;
       25, 20, 2.5, 27.4, 36, 16, 12, 10, 24.42, 3, 16.57, 6.3, 50, 120];

endfunction

## The designations, standards and threads of screws of shoulder diameters
## DS, threads d of pitch P, lengths l and fits FIT, columns; character
## vectors for one screw
function [name, standard, thread] = designate (ds, d, P, l, fit)

  ## The preferred nominal lengths of ISO 888:1976 Table 1, which hold the
  ## table's own and the intermediate ones ISO 7379 permits
  series = [10, 12, 14, 16, 20:5:90, 100:10:120];
  n = numel (l);
  if (ischar (fit))
    fit = repmat ({fit}, n, 1);
  endif
  T = sizes ();
  [~, k] = ismember (ds, T(:,1));
  r = max (k, 1);
  iso = (k > 0 & d == T(r,2) & P == T(r,3) & strcmp (fit(:), 'f9')
         & ismember (l, series) & l >= T(r,13) & l <= T(r,14));
  standard = repmat ({''}, n, 1);
  standard(iso) = {'ISO 7379'};
  denom = 'Hexagon socket head shoulder screw';
  [name, thread] = parts.__designation__ (denom, standard, d, P, l, l, ds);
  if (n == 1)
    name = name{1};
    standard = standard{1};
    thread = thread{1};
  endif

endfunction

## The head of the thread D: its row of sizes, by thread rather than shoulder
function h = head (D)

  T = sizes ();
  h = T(T(:,2) == D,:);

endfunction

function C = catalogue (DS, L, maker)

  ## Built on the first call, kept for the session
  persistent E;
  if (isempty (E))
    E = entries ();
  endif

  keep = true (height (E), 1);
  if (! isempty (DS))
    keep &= E.ds == DS;
  endif
  if (! isempty (L))
    keep &= E.l == L;
  endif
  if (! isempty (maker))
    keep &= strcmpi (E.maker, maker);
  endif
  C = E(keep,:);

  if (height (C) == 0)
    what = '';
    if (! isempty (DS))
      what = sprintf ("%g ", DS);
      if (! isempty (L))
        what = sprintf ("%g x %g ", DS, L);
      endif
    endif
    how = '';
    if (! isempty (maker))
      how = sprintf (" by %s", maker);
    endif
    error ("parts.screw.shoulder: no %sshoulder screw%s in the catalogue.", ...
           what, how);
  endif

endfunction

## Every entry of the catalogue, sorted by shoulder diameter, then length
function E = entries ()

  ## BEGIN generated by tools/reyher_tables.py shoulder
  ## REYHER article, printed page, shank fit, class, finish; then
  ## each shoulder diameter, thread and its lengths
  A = {'07379.200', 342, 'h8', '12.9', 'plain', {
         6, 5, [10, 12, 16, 20, 25, 30];
         8, 6, [10, 12, 16, 20, 25, 30, 40, 45, 50];
         10, 8, [10, 12, 16, 20, 25, 30, 40, 45, 50, 60, 70, 80];
         12, 10, [12, 16, 20, 25, 30, 35, 40, 50, 60, 70, 80, 100];
         16, 12, [20, 25, 30, 40, 50, 70];
         20, 16, [40, 50, 60, 70, 80]};
       '07379.204', 342, 'f9', '12.9', 'plain', {
         6, 5, [16, 20, 25, 30];
         8, 6, [10, 12, 16, 20, 25, 30, 40, 45, 50];
         10, 8, [10, 12, 16, 20, 25, 30, 40, 45, 50, 60, 70, 80];
         12, 10, [12, 16, 20, 25, 30, 35, 40, 50, 60, 70, 80, 100];
         16, 12, [20, 25, 30, 40, 50, 70];
         20, 16, [40, 50, 60, 70, 80]};
       '07379.920', 571, 'f9', 'A2', 'plain', {
         6, 5, [10, 12, 16, 20, 25];
         8, 6, [12, 16, 20, 25];
         10, 8, [16, 20, 25, 30];
         12, 10, [20, 25, 30, 40];
         16, 12, [30, 40, 50]};
      };
  ## END generated

  ## One row for each article, size and length
  Z = vertcat (A{:,6});
  nl = cellfun (@numel, Z(:,3));
  a = repelem (repelem ((1:rows (A))', cellfun (@rows, A(:,6))), nl);
  ds = repelem (cell2mat (Z(:,1)), nl);
  d = repelem (cell2mat (Z(:,2)), nl);
  l = [Z{:,3}]';
  n = numel (l);

  T = sizes ();
  [~, k] = ismember (d, T(:,2));
  h = T(k,:);
  fit = A(a,3);
  [name, standard] = designate (ds, d, h(:,3), l, fit);
  tool = arrayfun (@(s) sprintf ("%g", s), h(:,7), 'UniformOutput', false);
  source = arrayfun (@(p) sprintf ("REYHER, The Catalogue, 2020.04, p. %d", ...
                                   p), [A{:,2}]', 'UniformOutput', false);

  drive = repmat ({'hexsocket'}, n, 1);
  maker = repmat ({'REYHER'}, n, 1);
  E = table (name, standard, ds, d, h(:,3), l, h(:,4), h(:,5), h(:,6), fit, ...
             drive, tool, A(a,4), A(a,5), maker, A(a,1), source(a));
  E.Properties.VariableNames = {'designation', 'standard', 'ds', 'd', 'P', ...
                                'l', 'b', 'dk', 'k', 'fit', 'drive', 'tool', ...
                                'class', 'finish', 'maker', 'article', ...
                                'source'};
  E.Properties.VariableUnits = {'', '', 'mm', 'mm', 'mm', 'mm', 'mm', 'mm', ...
                                'mm', '', '', '', '', '', '', '', ''};
  E.Properties.VariableDescriptions = {...
    'designation of ISO 8991, without the property class', ...
    'ISO 7379 when the standard defines the screw', ...
    'shoulder diameter', ...
    'thread diameter', ...
    'pitch, coarse', ...
    'shoulder length', ...
    'thread length, largest', ...
    'head diameter, plain head, largest', ...
    'head height, largest', ...
    'tolerance of the shoulder', ...
    'hexsocket', ...
    'hexagon key', ...
    'property class or stainless steel grade', ...
    'finish as the maker names it', ...
    'maker', ...
    "maker's article number", ...
    'catalogue and page the article was read from'};
  E.Properties.Description = 'Hexagon socket head shoulder screws, ISO 7379';
  E = sortrows (E, {'ds', 'l'});

endfunction

function S = shape (DS, L, TSPEC, detailed)

  T = sizes ();
  if (isempty (TSPEC))
    h = T(T(:,1) == DS,:);
    if (isempty (h))
      error (strcat ("parts.screw.shoulder: ISO 7379 gives no thread for", ...
                     " a shoulder of %g; give 'Thread'."), DS);
    endif
    d = h(2);
    P = h(3);
  else
    if (! ischar (TSPEC) || ! isrow (TSPEC))
      tok = {};
    else
      tok = regexp (TSPEC, '^M(\d+(?:\.\d+)?)(?:x(\d+(?:\.\d+)?))?$', ...
                    'tokens', 'once');
    endif
    if (! isempty (tok) && numel (tok) < 2)
      tok{2} = '';
    endif
    if (isempty (tok) || (! isempty (tok{2}) && str2double (tok{2}) <= 0))
      error (strcat ("parts.screw.shoulder: 'Thread' must name a metric", ...
                     " thread, such as 'M8' or 'M8x1'."));
    endif
    d = str2double (tok{1});
    h = head (d);
    if (isempty (h))
      error ("parts.screw.shoulder: ISO 7379 defines no M%g head.", d);
    endif
    P = h(3);
    if (! isempty (tok{2}))
      P = str2double (tok{2});
    endif
  endif
  dk = h(5);
  k = h(6);
  b = h(4);
  if (DS <= d || DS >= dk)
    error (strcat ("parts.screw.shoulder: a shoulder of %g does not fit", ...
                   " the head and thread of M%g."), DS, d);
  endif
  [name, ~, tname] = designate (DS, d, P, L, 'f9');

  if (detailed)
    ## The undercuts under the head and at the end of the shoulder; one no
    ## smaller than the shoulder is left out
    g1 = h(10);
    if (h(9) < DS)
      e = (DS - h(9)) / 2;
      U = [DS / 2, -g1; h(9) / 2, e - g1; h(9) / 2, 0];
    else
      U = [DS / 2, 0];
    endif
    g2 = h(12);
    R = geom.Region ([0, -L - b; d / 2, -L - b; d / 2, -L - g2;
                      h(11) / 2, -L - g2; h(11) / 2, -L; DS / 2, -L; U;
                      dk / 2, 0; dk / 2, k; 0, k]);
  else
    R = geom.Region ([0, -L - b; d / 2, -L - b; d / 2, -L; DS / 2, -L;
                      DS / 2, 0; dk / 2, 0; dk / 2, k; 0, k]);
  endif
  R.UCS = geom.UCS ([0, -1, 0], [0, 0, 0]);
  S = solid.revolve (R);
  if (detailed)
    S = thread (S, [0, 0, -L - b], tname, b - g2, 'Direction', [0, 0, 1], ...
                'Custom', true);
  endif
  S = parts.screw.__recess__ (S, 'hexsocket', h(7:8), k);
  S.Name = name;

endfunction

%!test  # the catalogue, every article in every size and length
%! C = parts.screw.shoulder ('data');
%! assert_equal (height (C), 118);
%!test  # sorted by shoulder diameter, then length
%! C = parts.screw.shoulder ('data');
%! assert_equal (issorted ([C.ds, C.l], 'rows'), true);
%!test  # an article as REYHER lists it
%! C = parts.screw.shoulder ('data', 10, 40);
%! E = C(strcmp (C.article, '07379.204'),:);
%! assert_equal ([E.designation, E.fit, E.class, E.tool], ...
%!               {['Hexagon socket head shoulder screw ISO 7379', ...
%!                 ' - 10 x 40'], 'f9', '12.9', '5'});
%!test  # its sizes
%! C = parts.screw.shoulder ('data', 10, 40);
%! E = C(strcmp (C.article, '07379.204'),:);
%! assert_equal ([E.ds, E.d, E.P, E.l, E.b, E.dk, E.k], ...
%!               [10, 8, 1.25, 40, 13.25, 16, 7]);
%!test  # each variable carries its unit and description
%! C = parts.screw.shoulder ('data', 10, 40);
%! assert_equal (C.Properties.VariableUnits([3, 6]), {'mm', 'mm'});
%! assert_equal (C.Properties.VariableDescriptions{3}, 'shoulder diameter');
%!test  # a shoulder of fit h8 is custom
%! C = parts.screw.shoulder ('data', 10, 40);
%! E = C(strcmp (C.article, '07379.200'),:);
%! assert_equal ([E.designation, E.standard], ...
%!               {'Hexagon socket head shoulder screw 10-M8 x 40', ...
%!                ''});
%!test  # the market's 6-M5 is custom
%! C = parts.screw.shoulder ('data', 6, 20, 'Maker', 'reyher');
%! assert_equal (unique (C.designation), ...
%!               {'Hexagon socket head shoulder screw 6-M5 x 20'});
%!test  # an intermediate length of ISO 888
%! C = parts.screw.shoulder ('data', 8, 45);
%! E = C(strcmp (C.fit, 'f9'),:);
%! assert_equal (E.standard, {'ISO 7379'});
%!testif ; exist ('__occt__') == 3  # head, shoulder and thread, socket
%! S = parts.screw.shoulder ('solid', 10, 40);
%! V = pi * (8 ^ 2 * 7 + 5 ^ 2 * 40 + 4 ^ 2 * 13.25) ...
%!     - sqrt (3) / 2 * 5 ^ 2 * 4.2;
%! assert_equal (volume (S), V, 1e-6);
%!testif ; exist ('__occt__') == 3  # the underside of the head on the plane
%! S = parts.screw.shoulder ('solid', 10, 40);
%! assert_equal (bbox (S), [-8, -8, -53.25, 8, 8, 7], 1e-6);
%!testif ; exist ('__occt__') == 3  # named by its designation
%! S = parts.screw.shoulder ('solid', 6, 20, 'Thread', 'M5');
%! assert_equal (S.Name, ...
%!               {'Hexagon socket head shoulder screw 6-M5 x 20'});
%!testif ; exist ('__occt__') == 3  # detailed: undercuts and thread, valid
%! S = parts.screw.shoulder ('solid', 10, 40, 'Detailed', true);
%! assert_equal (isvalid (S), true);

%!error<parts.screw.shoulder: MODE must be 'data' or 'solid'.> ...
%! parts.screw.shoulder ()
%!error<parts.screw.shoulder: DS must be a positive diameter.> ...
%! parts.screw.shoulder ('data', -10)
%!error<parts.screw.shoulder: L must be a positive length.> ...
%! parts.screw.shoulder ('data', 10, [40, 50])
%!error<parts.screw.shoulder: a solid needs a shoulder diameter DS and a length L.> ...
%! parts.screw.shoulder ('solid', 10)
%!error<parts.screw.shoulder: Name/Value arguments must come in pairs.> ...
%! parts.screw.shoulder ('data', 10, 'Maker')
%!error<parts.screw.shoulder: option names must be character vectors.> ...
%! parts.screw.shoulder ('data', 10, 40, 1, 2)
%!error<parts.screw.shoulder: unknown option 'Drive'.> ...
%! parts.screw.shoulder ('data', 'Drive', 'torx')
%!error<parts.screw.shoulder: 'Thread' applies to 'solid' only.> ...
%! parts.screw.shoulder ('data', 'Thread', 'M8')
%!error<parts.screw.shoulder: 'Maker' applies to 'data' only.> ...
%! parts.screw.shoulder ('solid', 10, 40, 'Maker', 'REYHER')
%!error<parts.screw.shoulder: 'Maker' must be a character vector.> ...
%! parts.screw.shoulder ('data', 'Maker', 1)
%!error<parts.screw.shoulder: 'Detailed' applies to 'solid' only.> ...
%! parts.screw.shoulder ('data', 'Detailed', true)
%!error<parts.screw.shoulder: 'Detailed' must be true or false.> ...
%! parts.screw.shoulder ('solid', 10, 40, 'Detailed', 'yes')
%!error<parts.screw.shoulder: 'Detailed' must be true or false.> ...
%! parts.screw.shoulder ('solid', 10, 40, 'Detailed', 1)
%!error<parts.screw.shoulder: ISO 7379 gives no thread for a shoulder of 6; give 'Thread'.> ...
%! parts.screw.shoulder ('solid', 6, 20)
%!error<parts.screw.shoulder: 'Thread' must name a metric thread, such as 'M8' or 'M8x1'.> ...
%! parts.screw.shoulder ('solid', 10, 40, 'Thread', 'M8y')
%!error<parts.screw.shoulder: ISO 7379 defines no M7 head.> ...
%! parts.screw.shoulder ('solid', 10, 40, 'Thread', 'M7')
%!error<parts.screw.shoulder: a shoulder of 20 does not fit the head and thread of M8.> ...
%! parts.screw.shoulder ('solid', 20, 40, 'Thread', 'M8')
%!error<parts.screw.shoulder: no 11 shoulder screw in the catalogue.> ...
%! parts.screw.shoulder ('data', 11)
%!error<parts.screw.shoulder: no 10 x 41 shoulder screw by NSK in the catalogue.> ...
%! parts.screw.shoulder ('data', 10, 41, 'Maker', 'NSK')
