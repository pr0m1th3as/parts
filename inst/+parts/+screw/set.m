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
## @deftypefn  {parts} {@var{C} =} parts.screw.set (@qcode{'data'})
## @deftypefnx {parts} {@var{C} =} parts.screw.set (@qcode{'data'}, @var{NAME})
## @deftypefnx {parts} {@var{C} =} parts.screw.set (@qcode{'data'}, @var{NAME}, @var{L})
## @deftypefnx {parts} {@var{S} =} parts.screw.set (@qcode{'solid'}, @var{NAME}, @var{L})
## @deftypefnx {parts} {@dots{} =} parts.screw.set (@dots{}, @var{Name}, @var{Value})
##
## Hexagon socket set screws, ISO 4026, 4027, 4028 and 4029.
##
## @code{@var{C} = parts.screw.set (@qcode{'data'})} returns every set screw
## in the catalogue as a struct array, one entry for each maker's article in
## each size and length, sorted by size, pitch and length.
## @code{@var{C} = parts.screw.set (@qcode{'data'}, @var{NAME})} returns
## those of the thread @var{NAME}, such as @qcode{'M6'} or @qcode{'M8x1'},
## and @code{@var{C} = parts.screw.set (@qcode{'data'}, @var{NAME}, @var{L})}
## those of nominal length @var{L} too: every article sold as that screw,
## each with its point, property class and finish.  Nothing is built.
##
## @code{@var{S} = parts.screw.set (@qcode{'solid'}, @var{NAME}, @var{L})}
## builds the screw as a @code{solid.Shape} whether or not anyone sells it:
## any thread of a size the standards define, any pitch, any length its
## point fits in.  @var{NAME} names a coarse thread by its diameter,
## @qcode{'M6'}, or any pitch, as @qcode{'M8x1'}.  The socket end lies on
## the @math{xy} plane, the screw below it to @math{z} = -@var{L}, the
## socket sunk into it with two of its corners on the @math{x} axis.
## @code{@var{S}.Name} holds the screw's designation.
##
## Name/Value pairs:
##
## @table @asis
## @item @qcode{'Point'}
## The point, which selects the standard: @qcode{'flat'}, ISO 4026, the
## default; @qcode{'cone'}, ISO 4027; @qcode{'dog'}, ISO 4028;
## @qcode{'cup'}, ISO 4029.  For @qcode{'data'} it keeps that point's screws
## only; without it every point comes.
##
## @item @qcode{'Maker'}
## For @qcode{'data'}: only that maker's articles, such as
## @qcode{'REYHER'}, in any case.
##
## @item @qcode{'Detailed'}
## For @qcode{'solid'}: @code{true} cuts the thread, by
## @code{solid.Shape.thread}, from the socket end to the point.  By default
## (@code{false}) the screw is a plain cylinder of diameter @var{d}.
## @end table
##
## Each standard gives a short screw, of a nominal length up to its table's
## shaded lengths, a shallower socket and wider angles than a long one.
## Either way the solid takes the standard's largest point diameters and
## dog length and its smallest socket depth @var{t}, and chamfers the socket
## end from the thread's minor diameter, @math{d - 1.0825 P}, at 90 degrees
## included, 120 for a short screw.  The points:
##
## @table @asis
## @item flat
## A flat end @var{dp} across, chamfered at 45 degrees.
## @item cone
## A cone of 90 degrees included, 120 for a short screw, its tip cut flat
## @var{dt} across.
## @item dog
## A cylinder @var{dp} across and @var{z} long, short or long as the screw,
## reached from the thread by a 45 degree chamfer; the slight radius at its
## end is left out.
## @item cup
## A 45 degree chamfer down to an edge @var{dz} across, round a conical cup of
## 120 degrees.
## @end table
##
## Each entry is a struct with these fields, lengths in millimetres:
##
## @multitable @columnfractions 0.16 0.84
## @item @code{designation} @tab the designation of ISO 8991, as in
## @qcode{'Hexagon socket set screw ISO 4029 - M6 x 12'}, without the
## property class
## @item @code{standard} @tab the standard, as @qcode{'ISO 4029'}, when its
## table defines the screw, else empty: such a screw is custom
## @item @code{d} @tab nominal diameter
## @item @code{P} @tab pitch
## @item @code{l} @tab nominal length
## @item @code{point} @tab @qcode{'flat'}, @qcode{'cone'}, @qcode{'dog'} or
## @qcode{'cup'}
## @item @code{drive} @tab @qcode{'hexsocket'}
## @item @code{tool} @tab the hexagon key, as @qcode{'3'}
## @item @code{class} @tab property class or stainless steel grade, as
## @qcode{'45H'} or @qcode{'A4'}; @qcode{'A1/A2'} where the maker sells
## either
## @item @code{finish} @tab the finish as the maker names it, as
## @qcode{'plain'} or @qcode{'zinc plated'}
## @item @code{maker} @tab the maker
## @item @code{article} @tab the maker's article number
## @item @code{source} @tab the catalogue and page the article was read from
## @end multitable
##
## A screw is designated by its standard's number when the standard's table
## defines it: a coarse thread and a length of the table's commercial range.
## The four standards share one denomination, so a custom screw names its
## point instead, as @qcode{'Hexagon socket set screw with cone point M8x1 x
## 20'}.
##
## @subheading The catalogue
##
## Articles from REYHER, @cite{The Catalogue}, edition 2020.04, English,
## pages 272 to 278 (steel) and 541 to 544 (stainless steel): every
## article in sizes the standards define, M1.6 to M24, fine pitches
## included.  Left out: the size M14, which none of the four standards
## defines.
##
## Sockets, points and lengths from ISO 4026, 4027, 4028 and 4029, all
## 2003, Table 1 and Figure 1 of each, read in IS 6094 Parts 1 to 4:2006,
## which agree with REYHER's @cite{Technical Information} (2019, TI-20)
## but where REYHER drops a digit of @var{t} at M1.6 and M2.
##
## @seealso{parts.screw.cap}
## @end deftypefn

function OUT = set (MODE, varargin)

  if (nargin < 1 || ! ischar (MODE)
      || ! any (strcmp (MODE, {'data', 'solid'})))
    error ("parts.screw.set: MODE must be 'data' or 'solid'.");
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
        error ("parts.screw.set: L must be a positive length.");
      endif
    endif
  endif
  if (strcmp (MODE, 'solid') && isempty (L))
    error ("parts.screw.set: a solid needs a NAME and a length L.");
  endif

  point = 'flat';
  bypoint = false;
  maker = '';
  detailed = false;
  if (mod (numel (args), 2) != 0)
    error ("parts.screw.set: Name/Value arguments must come in pairs.");
  endif
  for ii = 1:2:numel (args)
    name = args{ii};
    val = args{ii+1};
    if (! ischar (name) || ! isrow (name))
      error ("parts.screw.set: option names must be character vectors.");
    endif
    switch (lower (name))
      case 'point'
        if (! ischar (val) || ! isrow (val))
          error ("parts.screw.set: 'Point' must be a character vector.");
        endif
        point = lower (val);
        if (! any (strcmp (point, {'flat', 'cone', 'dog', 'cup'})))
          error ("parts.screw.set: unknown point '%s'.", val);
        endif
        bypoint = true;
      case 'maker'
        if (strcmp (MODE, 'solid'))
          error ("parts.screw.set: 'Maker' applies to 'data' only.");
        endif
        if (! ischar (val) || ! isrow (val))
          error ("parts.screw.set: 'Maker' must be a character vector.");
        endif
        maker = val;
      case 'detailed'
        if (strcmp (MODE, 'data'))
          error ("parts.screw.set: 'Detailed' applies to 'solid' only.");
        endif
        if (! islogical (val) || ! isscalar (val))
          error ("parts.screw.set: 'Detailed' must be true or false.");
        endif
        detailed = val;
      otherwise
        error ("parts.screw.set: unknown option '%s'.", name);
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
      error (strcat ("parts.screw.set: NAME must name a metric thread,", ...
                     " such as 'M6' or 'M8x1'."));
    endif
    d = str2double (tok{1});
    if (! isempty (tok{2}))
      P = str2double (tok{2});
    endif
  endif

  if (strcmp (MODE, 'data'))
    OUT = catalogue (NAME, d, P, L, point, bypoint, maker);
  else
    OUT = shape (d, P, L, point, detailed);
  endif

endfunction

## The sizes, a row for each: d, coarse pitch P, socket s, its depth t min
## for a short and a long screw, dp max (flat and dog), dt max (cone), z max
## of a short and a long dog, dz max (cup), all four standards' Table 1
function T = sizes ()

  T = [1.6, 0.35, 0.7, 0.7, 1.5, 0.8, 0.4, 0.65, 1.05, 0.8;
       2, 0.4, 0.9, 0.8, 1.7, 1, 0.5, 0.75, 1.25, 1;
       2.5, 0.45, 1.3, 1.2, 2, 1.5, 0.65, 0.88, 1.5, 1.2;
       3, 0.5, 1.5, 1.2, 2, 2, 0.75, 1, 1.75, 1.4;
       4, 0.7, 2, 1.5, 2.5, 2.5, 1, 1.25, 2.25, 2;
       5, 0.8, 2.5, 2, 3, 3.5, 1.25, 1.5, 2.75, 2.5;
       6, 1, 3, 2, 3.5, 4, 1.5, 1.75, 3.25, 3;
       8, 1.25, 4, 3, 5, 5.5, 2, 2.25, 4.3, 5;
       10, 1.5, 5, 4, 6, 7, 2.5, 2.75, 5.3, 6;
       12, 1.75, 6, 4.8, 8, 8.5, 3, 3.25, 6.3, 8;
       16, 2, 8, 6.4, 10, 12, 4, 4.3, 8.36, 10;
       20, 2.5, 10, 8, 12, 15, 5, 5.3, 10.36, 14;
       24, 3, 12, 10, 15, 18, 6, 6.3, 12.43, 16];

endfunction

## For each point, a row for each size: the longest short screw, and the
## shortest and longest length of the commercial range, as Table 1 of its
## standard shades and bounds them
function [R, standard] = lengths (point)

  ## The commercial ranges' longest lengths, the same in all four
  top = [8, 10, 12, 16, 20, 25, 30, 40, 50, 60, 60, 60, 60]';
  switch (point)
    case 'flat'
      standard = 'ISO 4026';
      R = [[2, 3, 3, 3, 4, 5, 6, 8, 10, 12, 16, 20, 25]', ...
           [2, 2, 2.5, 3, 4, 5, 6, 8, 10, 12, 16, 20, 25]', top];
    case 'cone'
      standard = 'ISO 4027';
      R = [[2.5, 3, 3, 4, 5, 6, 6, 8, 10, 12, 16, 20, 25]', ...
           [2, 2, 2.5, 3, 4, 5, 6, 8, 10, 12, 16, 20, 25]', top];
    case 'dog'
      standard = 'ISO 4028';
      R = [[2.5, 3, 4, 5, 6, 6, 8, 10, 12, 16, 20, 25, 30]', ...
           [2, 2.5, 3, 4, 5, 6, 8, 8, 10, 12, 16, 20, 25]', top];
    case 'cup'
      standard = 'ISO 4029';
      R = [[2, 2.5, 3, 4, 5, 5, 6, 8, 10, 12, 16, 20, 25]', ...
           [2, 2, 2.5, 3, 4, 5, 6, 8, 10, 12, 16, 20, 25]', top];
  endswitch

endfunction

## The designations and standards of screws of sizes d, pitches P, lengths
## l and points POINT, columns; character vectors for one screw
function [name, standard, thread] = designate (d, P, l, point)

  series = [2, 2.5, 3, 4, 5, 6, 8, 10, 12, 16, 20, 25:5:60];
  n = numel (l);
  if (ischar (point))
    point = repmat ({point}, n, 1);
  endif
  T = sizes ();
  [~, k] = ismember (d, T(:,1));
  standard = repmat ({''}, n, 1);
  denom = repmat ({'Hexagon socket set screw'}, n, 1);
  for p = {'flat', 'cone', 'dog', 'cup'}
    [R, std] = lengths (p{1});
    is = strcmp (point(:), p{1});
    iso = (is & k > 0 & P == T(max (k, 1),2) & ismember (l, series)
           & l >= R(max (k, 1),2) & l <= R(max (k, 1),3));
    standard(iso) = {std};
    denom(is & ! iso) = {sprintf("Hexagon socket set screw with %s point", ...
                                 p{1})};
  endfor
  [name, thread] = parts.__designation__ (denom, standard, d, P, l, l);
  if (n == 1)
    name = name{1};
    standard = standard{1};
    thread = thread{1};
  endif

endfunction

function C = catalogue (NAME, d, P, L, point, bypoint, maker)

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
  if (bypoint)
    keep &= strcmp ({E.point}, point);
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
    if (bypoint)
      how = sprintf (" with a %s point", point);
    endif
    if (! isempty (maker))
      how = sprintf ("%s by %s", how, maker);
    endif
    error ("parts.screw.set: no %sset screw%s in the catalogue.", what, how);
  endif

endfunction

## Every entry of the catalogue, sorted by size, pitch, then length
function E = entries ()

  ## BEGIN generated by tools/reyher_tables.py set
  ## REYHER article, printed page, point, class, finish; then each
  ## size, its pitch (0 for coarse) and its lengths
  A = {'04026.200', 272, 'flat', '45H', 'plain', {
         1.6, 0, [2, 2.5, 3, 4, 5, 6, 8, 10];
         2, 0, [2, 3, 4, 5, 6, 8, 10];
         2.5, 0, [3, 4, 5, 6, 8, 10];
         3, 0, [3, 4, 5, 6, 8, 10, 12, 16, 20];
         4, 0, [3, 4, 5, 6, 8, 10, 12, 16, 20, 25, 30, 35, 40];
         5, 0, [4, 5, 6, 8, 10, 12, 16, 18, 20, 25, 30, 35, 40];
         6, 0, [4, 5, 6, 8, 10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, ...
             60, 70];
         8, 0, [6, 8, 10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, ...
             70, 80];
         10, 0, [8, 10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, ...
             80, 90, 100];
         12, 0, [10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, ...
             80, 90, 100];
         16, 0, [12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, ...
             90, 100];
         20, 0, [20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90];
         24, 0, [20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90, 100]};
       '04026.210', 273, 'flat', '45H', 'zinc plated', {
         2, 0, [4, 6, 8, 10];
         3, 0, [3, 4, 5, 6, 8, 10, 12, 16, 20];
         4, 0, [4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40];
         5, 0, [4, 5, 6, 8, 10, 12, 16, 18, 20, 25, 30, 35, 40];
         6, 0, [5, 6, 8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, ...
             60];
         8, 0, [6, 8, 10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, ...
             70, 80, 90, 100, 130];
         10, 0, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90, ...
             100];
         12, 0, [10, 12, 14, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, ...
             80, 90, 100];
         16, 0, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90];
         20, 0, [20, 25, 30, 35, 40, 50, 60, 70, 80, 90];
         24, 0, [25, 30, 35, 40, 60, 70, 80]};
       '04026.205', 273, 'flat', '45H', 'plain', {
         4, 0.5, [4, 5, 6];
         5, 0.5, [6, 8, 10, 12, 16, 20, 25, 30];
         6, 0.5, [6, 8, 10, 12, 16, 20];
         6, 0.75, [5, 6, 8, 10, 12, 20];
         8, 0.5, [10, 12, 16];
         8, 0.75, [8, 10, 12, 16, 20, 25, 30];
         8, 1, [5, 6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 50, 60, 70, 80, ...
             90, 100];
         10, 1, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60];
         10, 1.25, [8, 10, 12, 16, 20, 25, 30, 35, 40, 50, 60];
         12, 1, [8, 10, 16, 20, 25, 30, 40, 45, 50, 60];
         12, 1.25, [10, 12, 16, 20, 25, 30, 40];
         12, 1.5, [10, 12, 16, 20, 25, 30, 40, 45, 55, 70];
         16, 1, [12, 16, 20];
         16, 1.5, [12, 16, 20, 25, 30, 40, 50, 60, 70];
         20, 1.5, [20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 100];
         24, 1.5, [25, 30, 40, 60]};
       '04028.200', 275, 'dog', '45H', 'plain', {
         3, 0, [3, 4, 5, 6, 8, 10, 12, 16, 20];
         4, 0, [4, 5, 6, 8, 10, 12, 16, 20, 25, 30, 35, 40];
         5, 0, [4, 5, 6, 8, 10, 12, 16, 18, 20, 25, 30, 35, 40];
         6, 0, [5, 6, 8, 10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50];
         8, 0, [6, 8, 10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, ...
             70, 80];
         10, 0, [8, 10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, ...
             80];
         12, 0, [10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, ...
             80];
         16, 0, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100];
         20, 0, [20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90];
         24, 0, [30, 35, 40, 45, 50, 60, 70, 80, 90, 100]};
       '04028.210', 276, 'dog', '45H', 'zinc plated', {
         3, 0, [6, 8, 10, 12, 16, 20];
         4, 0, [4, 5, 6, 8, 10, 12, 16, 20, 25, 30];
         5, 0, [5, 6, 8, 10, 12, 16, 20, 25, 30];
         6, 0, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50];
         8, 0, [8, 10, 12, 16, 20, 25, 30, 35, 40, 50];
         10, 0, [8, 12, 16, 20, 25, 30, 35, 40, 50, 55, 60];
         12, 0, [12, 16, 20, 25, 30, 35, 40, 50, 55, 60, 70, 80];
         16, 0, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70];
         20, 0, [25, 35, 40, 50, 60, 70, 80];
         24, 0, [30, 40]};
       '04029.200', 277, 'cup', '45H', 'plain', {
         2, 0, [2.5, 3, 4, 5, 6];
         2.5, 0, [3, 4, 5, 6, 10];
         3, 0, [3, 4, 5, 6, 8, 10, 12, 16, 20];
         4, 0, [4, 5, 6, 8, 10, 12, 16, 20, 25, 30, 40];
         5, 0, [4, 5, 6, 8, 10, 12, 16, 18, 20, 25, 30, 35, 40];
         6, 0, [5, 6, 8, 10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50];
         8, 0, [6, 8, 10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, ...
             70, 80];
         10, 0, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80];
         12, 0, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80];
         16, 0, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100];
         20, 0, [20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90];
         24, 0, [30, 35, 50, 60, 70, 90, 100]};
       '04029.210', 278, 'cup', '45H', 'zinc plated', {
         3, 0, [3, 4, 5, 6, 8, 10, 12, 16, 20];
         4, 0, [4, 5, 6, 8, 10, 12, 16, 20];
         5, 0, [5, 6, 8, 10, 12, 16, 20, 25, 30, 40];
         6, 0, [5, 6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50];
         8, 0, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50];
         10, 0, [8, 10, 12, 14, 16, 20, 25, 30, 35, 40, 50, 60, 70, 80];
         12, 0, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60];
         16, 0, [16, 20, 25, 30, 35, 40, 50, 60, 70, 90];
         20, 0, [20, 30]};
       '04029.205', 278, 'cup', '45H', 'plain', {
         6, 0.75, [6, 8, 10, 12, 16, 20];
         8, 1, [6, 8, 10, 12, 16, 20, 25, 30, 40, 50];
         10, 1, [8, 10, 12, 16, 20, 25, 30];
         10, 1.25, [8, 10, 12, 16, 20, 25, 30];
         12, 1, [10, 12, 16];
         12, 1.25, [12, 16, 20, 25, 30];
         12, 1.5, [10, 12, 20, 25];
         16, 1.5, [16, 20, 25, 30, 40]};
       '04027.910', 541, 'cone', 'A1/A2', 'plain', {
         2, 0, [2, 3, 4, 5, 6, 8];
         2.5, 0, [4, 5, 6];
         3, 0, [3, 4, 5, 6, 8, 10, 12, 16];
         4, 0, [4, 5, 6, 8, 10, 12, 16, 20, 25, 30];
         5, 0, [4, 5, 6, 8, 10, 12, 16, 20, 25, 30];
         6, 0, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50];
         8, 0, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60];
         10, 0, [10, 12, 16, 20, 25, 30, 35, 40, 50, 60];
         12, 0, [16, 20, 25, 30, 35, 40, 50, 60]};
       '04027.940', 542, 'cone', 'A4', 'plain', {
         2.5, 0, [8];
         3, 0, [4, 5, 6, 8, 10];
         4, 0, [4, 5, 6, 8, 10, 12, 16, 20];
         5, 0, [5, 6, 8, 10, 12, 16, 20, 25, 30];
         6, 0, [6, 8, 10, 12, 16, 20, 25, 30, 35, 45, 50];
         8, 0, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60];
         10, 0, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60];
         12, 0, [12, 16, 20, 25, 30, 35, 40, 45, 50, 60];
         16, 0, [20, 25, 30, 40, 50, 60]};
       '04029.910', 543, 'cup', 'A1/A2', 'plain', {
         2, 0, [2, 3, 4, 5, 6];
         3, 0, [4, 5, 6, 8, 10, 12, 16, 20];
         4, 0, [3, 4, 5, 6, 8, 10, 12, 16, 20, 25, 30];
         5, 0, [5, 6, 8, 10, 12, 16, 20, 25, 30];
         6, 0, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60];
         8, 0, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60, 70];
         10, 0, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60];
         12, 0, [12, 16, 20, 25, 30, 35, 40, 50, 60];
         16, 0, [16, 20, 25, 30, 40, 50, 60];
         20, 0, [25, 30, 35, 50]};
       '04029.940', 544, 'cup', 'A4', 'plain', {
         2, 0, [2, 4, 5, 6];
         3, 0, [5, 6, 8, 10, 12, 16, 20];
         4, 0, [5, 6, 8, 10, 12, 16, 20];
         5, 0, [5, 6, 8, 10, 12, 16, 20, 25, 30];
         6, 0, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 50];
         8, 0, [8, 10, 12, 16, 20, 25, 30, 35, 40, 50, 60];
         10, 0, [8, 10, 12, 16, 20, 25, 30, 35, 40, 50, 60];
         12, 0, [12, 16, 20, 25, 30, 35, 40, 50, 60];
         16, 0, [16, 20, 25, 30, 35, 40]};
      };
  ## END generated

  ## One row for each article, size and length
  Z = vertcat (A{:,6});
  nl = cellfun (@numel, Z(:,3));
  a = repelem (repelem ((1:rows (A))', cellfun (@rows, A(:,6))), nl);
  d = repelem (cell2mat (Z(:,1)), nl);
  P = repelem (cell2mat (Z(:,2)), nl);
  l = [Z{:,3}]';
  n = numel (l);

  T = sizes ();
  [~, k] = ismember (d, T(:,1));
  P(P == 0) = T(k(P == 0),2);
  point = A(a,3);
  [name, standard] = designate (d, P, l, point);
  tool = arrayfun (@(s) sprintf ("%g", s), T(k,3), 'UniformOutput', false);
  source = arrayfun (@(p) sprintf ("REYHER, The Catalogue, 2020.04, p. %d", ...
                                   p), [A{:,2}]', 'UniformOutput', false);

  F = [name, standard, num2cell([d, P, l]), point, ...
       repmat({'hexsocket'}, n, 1), tool, A(a,4:5), ...
       repmat({'REYHER'}, n, 1), A(a,1), source(a)]';
  E = cell2struct (F, {'designation', 'standard', 'd', 'P', 'l', 'point', ...
                       'drive', 'tool', 'class', 'finish', 'maker', ...
                       'article', 'source'}, 1)';
  [~, k] = sortrows ([d, P, l], [1, 2, 3]);
  E = E(k);

endfunction

function S = shape (d, P, L, point, detailed)

  T = sizes ();
  h = T(T(:,1) == d,:);
  if (isempty (h))
    error ("parts.screw.set: ISO 4026 to 4029 define no M%g set screw.", d);
  endif
  if (isnan (P))
    P = h(2);
  endif
  [name, ~, tname] = designate (d, P, L, point);
  R = lengths (point);
  short = L <= R(T(:,1) == d,1);

  ## The socket end, chamfered from the minor diameter
  df = d - 1.0825 * P;
  if (short)
    c = (d - df) / 2 / tand (60);
    t = h(4);
  else
    c = (d - df) / 2;
    t = h(5);
  endif

  ## The point, its profile from the thread down, and its length
  switch (point)
    case 'flat'
      e = (d - h(6)) / 2;
      Q = [d / 2, -L + e; h(6) / 2, -L; 0, -L];
    case 'cone'
      e = (d - h(7)) / 2 / tand (45 + 15 * short);
      Q = [d / 2, -L + e; h(7) / 2, -L; 0, -L];
    case 'dog'
      z = h(9 - short);
      e = z + (d - h(6)) / 2;
      Q = [d / 2, -L + e; h(6) / 2, -L + z; h(6) / 2, -L; 0, -L];
    case 'cup'
      e = (d - h(10)) / 2;
      u = h(10) / 2 / tand (60);
      Q = [d / 2, -L + e; h(10) / 2, -L; 0, -L + u];
  endswitch
  if (c + e > L)
    error ("parts.screw.set: M%g x %g is too short for its %s point.", ...
           d, L, point);
  endif

  R = geom.Region ([0, 0; df / 2, 0; d / 2, -c; Q]);
  R.UCS = geom.UCS ([0, -1, 0], [0, 0, 0]);
  S = solid.revolve (R);
  if (detailed)
    S = thread (S, [0, 0, 0], tname, L - e, 'Custom', true);
  endif
  S = parts.screw.__recess__ (S, 'hexsocket', [h(3), t], 0);
  S.Name = name;

endfunction

%!test  # the catalogue, every article in every size and length
%! C = parts.screw.set ('data');
%! assert_equal (numel (C), 1240);
%!test  # an article as REYHER lists it
%! C = parts.screw.set ('data', 'M6', 12, 'Point', 'cup');
%! E = C(strcmp ({C.article}, '04029.200'));
%! assert_equal ({E.designation, E.class, E.finish, E.tool}, ...
%!               {'Hexagon socket set screw ISO 4029 - M6 x 12', '45H', ...
%!                'plain', '3'});
%!test  # its size and source
%! C = parts.screw.set ('data', 'M6', 12, 'Point', 'cup');
%! E = C(strcmp ({C.article}, '04029.200'));
%! assert_equal ({E.d, E.P, E.l, E.source}, ...
%!               {6, 1, 12, 'REYHER, The Catalogue, 2020.04, p. 277'});
%!test  # every cup point article sold as M6 x 12
%! C = parts.screw.set ('data', 'M6', 12, 'Point', 'cup');
%! assert_equal ({C.article}, {'04029.200', '04029.210', '04029.910', ...
%!                             '04029.940'});
%!test  # without 'Point' every point comes
%! C = parts.screw.set ('data', 'M6', 12);
%! assert_equal (unique ({C.point}), {'cone', 'cup', 'dog', 'flat'});
%!test  # a fine pitch is custom and names its point
%! C = parts.screw.set ('data', 'M8x1', 20, 'Point', 'cup');
%! assert_equal ({C.designation, C.standard}, ...
%!               {'Hexagon socket set screw with cup point M8x1 x 20', ''});
%!test  # a length shorter than the standard's is custom
%! C = parts.screw.set ('data', 'M4', 3, 'Point', 'flat');
%! assert_equal (C.designation, ...
%!               'Hexagon socket set screw with flat point M4 x 3');
%!test  # stainless sold as either grade
%! C = parts.screw.set ('data', 'M6', 12, 'Point', 'cone');
%! assert_equal ({C.class}, {'A1/A2', 'A4'});
%!test  # 'Maker' in any case
%! C = parts.screw.set ('data', 'M6', 12, 'Maker', 'reyher');
%! assert_equal (numel (C), 10);
%!testif ; exist ('__occt__') == 3  # flat point, long: chamfers and socket
%! S = parts.screw.set ('solid', 'M6', 12);
%! fr = @(a, b, h) pi * h / 3 * (a ^ 2 + a * b + b ^ 2);
%! c = 1.0825 / 2;
%! V = (fr (3 - c, 3, c) + pi * 9 * (11 - c) + fr (3, 2, 1) ...
%!      - sqrt (3) / 2 * 9 * 3.5);
%! assert_equal (volume (S), V, 1e-6);
%!testif ; exist ('__occt__') == 3  # flat point, short: 120 degrees, socket t
%! S = parts.screw.set ('solid', 'M6', 6);
%! fr = @(a, b, h) pi * h / 3 * (a ^ 2 + a * b + b ^ 2);
%! c = 1.0825 / 2 / tand (60);
%! V = (fr (3 - 1.0825 / 2, 3, c) + pi * 9 * (5 - c) + fr (3, 2, 1) ...
%!      - sqrt (3) / 2 * 9 * 2);
%! assert_equal (volume (S), V, 1e-6);
%!testif ; exist ('__occt__') == 3  # cone point, 90 degrees to dt
%! S = parts.screw.set ('solid', 'M6', 12, 'Point', 'cone');
%! fr = @(a, b, h) pi * h / 3 * (a ^ 2 + a * b + b ^ 2);
%! c = 1.0825 / 2;
%! V = (fr (3 - c, 3, c) + pi * 9 * (12 - c - 2.25) + fr (3, 0.75, 2.25) ...
%!      - sqrt (3) / 2 * 9 * 3.5);
%! assert_equal (volume (S), V, 1e-6);
%!testif ; exist ('__occt__') == 3  # dog point, long: dp across, z long
%! S = parts.screw.set ('solid', 'M6', 12, 'Point', 'dog');
%! fr = @(a, b, h) pi * h / 3 * (a ^ 2 + a * b + b ^ 2);
%! c = 1.0825 / 2;
%! V = (fr (3 - c, 3, c) + pi * 9 * (12 - c - 4.25) + fr (3, 2, 1) ...
%!      + pi * 4 * 3.25 - sqrt (3) / 2 * 9 * 3.5);
%! assert_equal (volume (S), V, 1e-6);
%!testif ; exist ('__occt__') == 3  # cup point: dz across, a cup of 120
%! S = parts.screw.set ('solid', 'M6', 12, 'Point', 'cup');
%! fr = @(a, b, h) pi * h / 3 * (a ^ 2 + a * b + b ^ 2);
%! c = 1.0825 / 2;
%! V = (fr (3 - c, 3, c) + pi * 9 * (12 - c - 1.5) + fr (3, 1.5, 1.5) ...
%!      - pi * 2.25 * 1.5 / tand (60) / 3 - sqrt (3) / 2 * 9 * 3.5);
%! assert_equal (volume (S), V, 1e-6);
%!testif ; exist ('__occt__') == 3  # the socket end on the plane
%! S = parts.screw.set ('solid', 'M6', 12, 'Point', 'cone');
%! assert_equal (bbox (S), [-3, -3, -12, 3, 3, 0], 1e-6);
%!testif ; exist ('__occt__') == 3  # named by its designation
%! S = parts.screw.set ('solid', 'M8x1', 20, 'Point', 'dog');
%! assert_equal (S.Name, ...
%!               {'Hexagon socket set screw with dog point M8x1 x 20'});
%!testif ; exist ('__occt__') == 3  # detailed: threaded, valid
%! S = parts.screw.set ('solid', 'M3', 6, 'Detailed', true);
%! assert_equal (isvalid (S), true);

%!error<parts.screw.set: MODE must be 'data' or 'solid'.> parts.screw.set ()
%!error<parts.screw.set: a solid needs a NAME and a length L.> ...
%! parts.screw.set ('solid', 'M6')
%!error<parts.screw.set: L must be a positive length.> ...
%! parts.screw.set ('solid', 'M6', 0)
%!error<parts.screw.set: NAME must name a metric thread, such as 'M6' or 'M8x1'.> ...
%! parts.screw.set ('data', 'M6y')
%!error<parts.screw.set: Name/Value arguments must come in pairs.> ...
%! parts.screw.set ('data', 'M6', 'Point')
%!error<parts.screw.set: option names must be character vectors.> ...
%! parts.screw.set ('data', 6, 'Point')
%!error<parts.screw.set: unknown option 'Drive'.> ...
%! parts.screw.set ('data', 'Drive', 'torx')
%!error<parts.screw.set: 'Point' must be a character vector.> ...
%! parts.screw.set ('data', 'Point', 1)
%!error<parts.screw.set: unknown point 'oval'.> ...
%! parts.screw.set ('data', 'Point', 'oval')
%!error<parts.screw.set: 'Maker' applies to 'data' only.> ...
%! parts.screw.set ('solid', 'M6', 12, 'Maker', 'REYHER')
%!error<parts.screw.set: 'Maker' must be a character vector.> ...
%! parts.screw.set ('data', 'Maker', 1)
%!error<parts.screw.set: 'Detailed' applies to 'solid' only.> ...
%! parts.screw.set ('data', 'Detailed', true)
%!error<parts.screw.set: 'Detailed' must be true or false.> ...
%! parts.screw.set ('solid', 'M6', 12, 'Detailed', 'yes')
%!error<parts.screw.set: 'Detailed' must be true or false.> ...
%! parts.screw.set ('solid', 'M6', 12, 'Detailed', 1)
%!error<parts.screw.set: no M14 set screw in the catalogue.> ...
%! parts.screw.set ('data', 'M14')
%!error<parts.screw.set: no M6 x 12 set screw with a cone point by NSK in the catalogue.> ...
%! parts.screw.set ('data', 'M6', 12, 'Point', 'cone', 'Maker', 'NSK')
%!error<parts.screw.set: ISO 4026 to 4029 define no M14 set screw.> ...
%! parts.screw.set ('solid', 'M14', 20)
%!error<parts.screw.set: M2 x 1 is too short for its dog point.> ...
%! parts.screw.set ('solid', 'M2', 1, 'Point', 'dog')
