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
## @deftypefn  {parts} {@var{C} =} parts.screw.cheese (@qcode{'data'})
## @deftypefnx {parts} {@var{C} =} parts.screw.cheese (@qcode{'data'}, @var{NAME})
## @deftypefnx {parts} {@var{C} =} parts.screw.cheese (@qcode{'data'}, @var{NAME}, @var{L})
## @deftypefnx {parts} {@var{S} =} parts.screw.cheese (@qcode{'solid'}, @var{NAME}, @var{L})
## @deftypefnx {parts} {@dots{} =} parts.screw.cheese (@dots{}, @var{Name}, @var{Value})
##
## Cheese head screws: slotted, ISO 1207, and hexalobular socket, ISO 14580.
##
## @code{@var{C} = parts.screw.cheese (@qcode{'data'})} returns every cheese
## head screw in the catalogue as a table, one row for each maker's article
## in each size and length, sorted by size and length.
## @code{@var{C} = parts.screw.cheese (@qcode{'data'}, @var{NAME})} returns
## those of the thread @var{NAME}, such as @qcode{'M5'}, and
## @code{@var{C} = parts.screw.cheese (@qcode{'data'}, @var{NAME}, @var{L})}
## those of nominal length @var{L} too: every article sold as that screw,
## each with its material or property class and finish.  Nothing is built.
## The catalogue holds slotted screws only.
##
## @code{@var{S} = parts.screw.cheese (@qcode{'solid'}, @var{NAME}, @var{L})}
## builds the screw as a @code{solid.Shape} whether or not anyone sells it:
## any thread of a size the standard defines, any pitch, any length.  The
## bearing face of the head lies on the @math{xy} plane, the head above it,
## the shank below it to @math{z} = -@var{L}, the slot along the @math{x}
## axis, a hexalobular socket with two lobes on it.  @code{@var{S}.Name}
## holds the screw's designation.
##
## Name/Value pairs:
##
## @table @asis
## @item @qcode{'Drive'}
## The drive: @qcode{'slot'}, ISO 1207, the default, or
## @qcode{'hexalobular'} (alias @qcode{'torx'}), ISO 14580, whose head is
## higher.  For @qcode{'data'} it keeps that drive's screws only; without it
## every screw comes.
##
## @item @qcode{'Maker'}
## For @qcode{'data'}: only that maker's articles, such as
## @qcode{'REYHER'}, in any case.
##
## @item @qcode{'ThreadLength'}
## For @qcode{'solid'}: the length of thread @var{b} from the end of the
## shank, from 0 to @var{L}; @var{L} threads it to the head.  Without it the
## screw follows ISO 1207 or ISO 14580, which agree: threaded to the head
## up to 30 long for M3 and smaller and 40 for the rest, and longer ones
## threaded @var{b} min, 25 and 38.
##
## @item @qcode{'Detailed'}
## For @qcode{'solid'}: @code{true} builds the head's side at the standard's
## largest taper, 5 degrees, @var{dk} across at the bearing face, the fillet
## of radius @var{r} under it, and the thread, cut by
## @code{solid.Shape.thread}; a screw threaded to the head is threaded to
## within @var{a} of it; the hexalobular socket takes its true outline.  By
## default (@code{false}) the head is a cylinder, the shank a plain cylinder
## of diameter @var{d} and the hexalobular socket a round hole of its
## diameter @var{A}.  Either way the slot is cut @var{n} wide, the socket or
## slot is cut @var{t} min deep, and the end is left flat, as rolled.
## @end table
##
## The table has these variables, each with its unit and its description,
## which @code{summary (@var{C})} lists; lengths are in millimetres:
##
## @multitable @columnfractions 0.16 0.84
## @item @code{designation} @tab designation of ISO 8991, as in
## @qcode{'Cheese head screw ISO 1207 - M5 x 20'}, without the property
## class
## @item @code{standard} @tab @qcode{'ISO 1207'} or @qcode{'ISO 14580'}
## when the standard's table defines the screw, else empty: such a screw is
## custom
## @item @code{d} @tab nominal diameter
## @item @code{P} @tab pitch, coarse
## @item @code{l} @tab nominal length
## @item @code{b} @tab length of thread from the end, @var{l} when threaded
## to the head
## @item @code{dk} @tab head diameter at the bearing face, largest
## @item @code{k} @tab head height, largest
## @item @code{drive} @tab @qcode{'slot'} or @qcode{'hexalobular'}
## @item @code{tool} @tab screwdriver tip of ISO 2380-1, thickness by
## width, as @qcode{'1.2 x 8'}; empty for M1.6 to M3, which the source does
## not assign
## @item @code{class} @tab property class or material, as @qcode{'4.8'},
## @qcode{'A2'}, @qcode{'brass'} or @qcode{'PA'}
## @item @code{finish} @tab finish as the maker names it
## @item @code{maker} @tab maker
## @item @code{article} @tab maker's article number
## @item @code{source} @tab catalogue and page the article was read from
## @end multitable
##
## A screw is designated by the standard's number when its table defines it:
## a length of the size's commercial range, with the thread form the table
## gives it.  Every other screw is custom, its thread length written when
## shorter than @var{l}, as @qcode{'Cheese head screw M4 x 60 x 38'}.
##
## @subheading The catalogue
##
## Articles from REYHER, @cite{The Catalogue}, edition 2020.04, English,
## pages 205 to 207 (steel), 513 and 514 (stainless steel) and 630 and 631
## (brass, plastic): every article in sizes ISO 1207 defines.  Left out:
## the sizes M1, M1.2 and M1.4.  REYHER notes that its stainless screws are
## partly threaded from 60 long; they are taken here as the standard threads
## them.
##
## Heads, slots, thread lengths and lengths from ISO 1207:1992, read in
## IS 1366:2002, and ISO 14580:2011, read in GOST R ISO 14580-2012;
## screwdriver tips from Wera's assignment table (catalogue page 53,
## edition 11/04) to ISO 2380-1.
##
## @seealso{parts.screw.pan, parts.screw.cap}
## @end deftypefn

function OUT = cheese (MODE, varargin)

  if (nargin < 1 || ! ischar (MODE)
      || ! any (strcmp (MODE, {'data', 'solid'})))
    error ("parts.screw.cheese: MODE must be 'data' or 'solid'.");
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
        error ("parts.screw.cheese: L must be a positive length.");
      endif
    endif
  endif
  if (strcmp (MODE, 'solid') && isempty (L))
    error ("parts.screw.cheese: a solid needs a NAME and a length L.");
  endif

  drive = 'slot';
  bydrive = false;
  maker = '';
  detailed = false;
  B = [];
  if (mod (numel (args), 2) != 0)
    error ("parts.screw.cheese: Name/Value arguments must come in pairs.");
  endif
  for ii = 1:2:numel (args)
    name = args{ii};
    val = args{ii+1};
    if (! ischar (name) || ! isrow (name))
      error ("parts.screw.cheese: option names must be character vectors.");
    endif
    switch (lower (name))
      case 'drive'
        if (! ischar (val) || ! isrow (val))
          error ("parts.screw.cheese: 'Drive' must be a character vector.");
        endif
        switch (lower (val))
          case 'slot'
            drive = 'slot';
          case {'hexalobular', 'torx'}
            drive = 'hexalobular';
          otherwise
            error ("parts.screw.cheese: unknown drive '%s'.", val);
        endswitch
        bydrive = true;
      case 'maker'
        if (strcmp (MODE, 'solid'))
          error ("parts.screw.cheese: 'Maker' applies to 'data' only.");
        endif
        if (! ischar (val) || ! isrow (val))
          error ("parts.screw.cheese: 'Maker' must be a character vector.");
        endif
        maker = val;
      case 'detailed'
        if (strcmp (MODE, 'data'))
          error ("parts.screw.cheese: 'Detailed' applies to 'solid' only.");
        endif
        if (! islogical (val) || ! isscalar (val))
          error ("parts.screw.cheese: 'Detailed' must be true or false.");
        endif
        detailed = val;
      case 'threadlength'
        if (strcmp (MODE, 'data'))
          error (strcat ("parts.screw.cheese: 'ThreadLength' applies to", ...
                         " 'solid' only."));
        endif
        B = val;
      otherwise
        error ("parts.screw.cheese: unknown option '%s'.", name);
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
      error (strcat ("parts.screw.cheese: NAME must name a metric thread,", ...
                     " such as 'M5' or 'M5x0.5'."));
    endif
    d = str2double (tok{1});
    if (! isempty (tok{2}))
      P = str2double (tok{2});
    endif
  endif

  if (strcmp (MODE, 'data'))
    OUT = catalogue (NAME, d, P, L, drive, bydrive, maker);
  else
    OUT = shape (d, P, L, B, drive, detailed);
  endif

endfunction

## ISO 1207:1992, a row for each size: d, P, dk max, k max, n nom, t min,
## r min, a max, b min, the longest length threaded to the head, the
## shortest and longest commercial length, the screwdriver tip of
## ISO 2380-1 (thickness and width, NaN where Wera assigns none).  For the
## hexalobular DRIVE, ISO 14580:2011, which differs only in k max and has
## no M1.6: n and the tip give way to the socket number and its t min.
function T = sizes (drive)

  T = [1.6, 0.35, 3, 1.1, 0.4, 0.45, 0.1, 0.7, 25, 30, 2, 16, NaN, NaN;
       2, 0.4, 3.8, 1.4, 0.5, 0.6, 0.1, 0.8, 25, 30, 3, 20, NaN, NaN;
       2.5, 0.45, 4.5, 1.8, 0.6, 0.7, 0.1, 0.9, 25, 30, 3, 25, NaN, NaN;
       3, 0.5, 5.5, 2, 0.8, 0.85, 0.1, 1, 25, 30, 4, 30, NaN, NaN;
       3.5, 0.6, 6, 2.4, 1, 1, 0.1, 1.2, 38, 40, 5, 35, 1, 5.5;
       4, 0.7, 7, 2.6, 1.2, 1.1, 0.2, 1.4, 38, 40, 5, 40, 1.2, 6.5;
       5, 0.8, 8.5, 3.3, 1.2, 1.3, 0.2, 1.6, 38, 40, 6, 50, 1.2, 8;
       6, 1, 10, 3.9, 1.6, 1.6, 0.25, 2, 38, 40, 8, 60, 1.6, 10;
       8, 1.25, 13, 5, 2, 2, 0.4, 2.5, 38, 40, 10, 80, 2, 12;
       10, 1.5, 16, 6, 2.5, 2.4, 0.4, 3, 38, 40, 12, 80, 2.5, 14];
  if (strcmp (drive, 'hexalobular'))
    T(1,:) = [];
    T(:,4:6) = [1.55, 6, 0.71; 1.85, 8, 0.78; 2.4, 10, 1.01; 2.6, 15, 1.07;
                3.1, 20, 1.27; 3.65, 25, 1.52; 4.4, 30, 1.9; 5.8, 45, 2.66;
                6.9, 50, 3.04];
    T(:,13:14) = NaN;
  endif

endfunction

## The thread lengths of screws of size rows h and lengths l by ISO 1207,
## a column
function b = tableform (h, l)

  b = l;
  part = l > h(:,10);
  b(part) = h(part,9);

endfunction

## The designations, standards and threads of screws of size rows h, pitches
## P, lengths l and thread lengths b, columns, with the drive DRIVE;
## character vectors for one
function [name, standard, thread] = designate (h, P, l, b, drive)

  series = [2:6, 8, 10, 12, 14, 16, 20:5:80];
  n = numel (l);
  iso = (P == h(:,2) & ismember (l, series) & l >= h(:,11) & l <= h(:,12)
         & b == tableform (h, l));
  standard = repmat ({''}, n, 1);
  if (strcmp (drive, 'slot'))
    standard(iso) = {'ISO 1207'};
    denom = 'Cheese head screw';
  else
    standard(iso) = {'ISO 14580'};
    denom = 'Hexalobular socket cheese head screw';
  endif
  [name, thread] = parts.__designation__ (denom, standard, h(:,1), P, l, b);
  if (n == 1)
    name = name{1};
    standard = standard{1};
    thread = thread{1};
  endif

endfunction

function C = catalogue (NAME, d, P, L, drive, bydrive, maker)

  ## Built on the first call, kept for the session
  persistent E;
  if (isempty (E))
    E = entries ();
  endif

  keep = true (height (E), 1);
  if (! isempty (d))
    T = sizes ('slot');
    if (isnan (P) && any (T(:,1) == d))
      P = T(T(:,1) == d,2);
    endif
    keep &= E.d == d & E.P == P;
  endif
  if (! isempty (L))
    keep &= E.l == L;
  endif
  if (bydrive)
    keep &= strcmp (E.drive, drive);
  endif
  if (! isempty (maker))
    keep &= strcmpi (E.maker, maker);
  endif
  C = E(keep,:);

  if (height (C) == 0)
    what = '';
    if (! isempty (NAME))
      what = [NAME, ' '];
      if (! isempty (L))
        what = sprintf ("%s x %g ", NAME, L);
      endif
    endif
    how = '';
    if (bydrive)
      how = sprintf (" with a %s drive", drive);
    endif
    if (! isempty (maker))
      how = sprintf ("%s by %s", how, maker);
    endif
    error ("parts.screw.cheese: no %scheese head screw%s in the catalogue.", ...
           what, how);
  endif

endfunction

## Every entry of the catalogue, sorted by size, then length
function E = entries ()

  ## BEGIN generated by tools/reyher_tables.py cheese
  ## REYHER article, printed page, drive, class, finish; then each
  ## size with its lengths
  A = {'01207.004', 205, 'slot', 'steel', 'plain', {
         1.6, [3, 4, 5, 6, 8, 10, 16]};
       '01207.400', 205, 'slot', '4.8', 'plain', {
         2, [3, 4, 5, 6, 8, 10, 12, 16, 20];
         2.5, [4, 5, 6, 8, 10, 12, 16, 18, 20, 25, 30];
         3, [3, 4, 5, 6, 8, 10, 12, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50];
         4, [4, 5, 6, 8, 10, 12, 16, 20, 22, 25, 30, 35, 40, 45, 50, 55, ...
             60, 65, 70];
         5, [6, 8, 10, 12, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             70, 75, 80];
         6, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, ...
             80, 100];
         8, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70];
         10, [12, 16, 20, 25, 30, 40, 45]};
       '01207.410', 206, 'slot', '4.8', 'zinc plated', {
         2, [3, 4, 5, 6, 8, 10, 12, 16, 18, 20, 30];
         2.5, [3, 4, 5, 6, 8, 10, 12, 16, 18, 20, 25, 30];
         3, [3, 4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 28, 30, 35, 40, ...
             45, 50, 55, 60];
         3.5, [5, 6, 8, 10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50];
         4, [4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 28, 30, 35, 40, ...
             45, 50, 55, 60, 65, 70, 80, 90, 100];
         5, [6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, ...
             60, 65, 70, 80, 90, 100];
         6, [6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, ...
             60, 65, 70, 80, 90, 100];
         8, [10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, ...
             90, 100];
         10, [12, 16, 20, 25, 30, 35, 40, 50, 60, 70, 80, 100]};
       '01207.430', 207, 'slot', '4.8', 'nickel plated', {
         3, [6, 8, 10, 12, 16];
         4, [8, 10, 12, 16];
         5, [8, 10, 12, 16]};
       '01207.914', 513, 'slot', 'A1', 'plain', {
         1.6, [3, 4, 5, 6, 8, 10, 12]};
       '01207.920', 513, 'slot', 'A2', 'plain', {
         1.6, [2, 3, 4, 5, 6, 8, 10, 12, 16];
         2, [3, 4, 5, 6, 8, 10, 12, 16, 20];
         2.5, [3, 4, 5, 6, 8, 10, 12, 16, 18, 20, 22, 25, 30, 35, 40];
         3, [3, 4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, ...
             50, 55];
         3.5, [6, 8, 10, 12, 16, 20, 25];
         4, [4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, ...
             50, 55, 60, 70, 80, 90, 100];
         5, [6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, ...
             60, 70, 80, 90, 100];
         6, [8, 10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 60, 70, 75, 80, ...
             90, 100];
         8, [10, 12, 16, 20, 25, 30, 35, 40, 50, 60, 70, 80, 90, 100];
         10, [12, 16, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90, 100]};
       '01207.940', 514, 'slot', 'A4', 'plain', {
         2, [3, 4, 5, 6, 8, 10, 12, 16, 20, 25];
         2.5, [3, 4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 25];
         3, [3, 4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 50, ...
             55, 60];
         3.5, [6, 8, 10, 20];
         4, [4, 5, 6, 8, 10, 12, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, ...
             55, 60, 70, 80];
         5, [6, 8, 10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80, ...
             100];
         6, [8, 10, 12, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 60, 70, 75, ...
             80];
         8, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70];
         10, [16, 20, 25, 30, 35, 40, 50, 60, 65, 70]};
       '01207.705', 630, 'slot', 'brass', 'plain', {
         1.6, [4, 5, 6, 8, 10, 12, 16]};
       '01207.700', 630, 'slot', 'brass', 'plain', {
         2, [4, 5, 6, 8, 10, 12, 16, 20];
         2.5, [3, 4, 5, 6, 8, 10, 12, 16, 20];
         3, [4, 5, 6, 8, 10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50];
         3.5, [8, 10, 12, 16, 20];
         4, [5, 6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60];
         5, [6, 8, 10, 12, 16, 20, 22, 25, 30, 35, 40, 45, 50, 60, 70];
         6, [8, 10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80];
         8, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60];
         10, [16, 20, 25, 30, 35, 40, 45, 50]};
       '01207.730', 631, 'slot', 'brass', 'nickel plated', {
         2.5, [6, 8, 10, 16];
         3, [6, 8, 10, 12, 16, 20, 25, 30];
         4, [6, 8, 10, 12, 16, 20, 25, 30, 40];
         5, [10, 16, 20, 30];
         6, [10, 16, 20]};
       '01207.600', 631, 'slot', 'PA', 'plain', {
         2.5, [6, 10, 16];
         3, [4, 5, 6, 8, 10, 12, 16, 20, 25, 30];
         4, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40];
         5, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 50];
         6, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60, 70];
         8, [16, 20, 25, 30, 40, 50]};
      };
  ## END generated

  ## One row for each article, size and length
  Z = vertcat (A{:,6});
  nl = cellfun (@numel, Z(:,2));
  a = repelem (repelem ((1:rows (A))', cellfun (@rows, A(:,6))), nl);
  d = repelem (cell2mat (Z(:,1)), nl);
  l = [Z{:,2}]';
  n = numel (l);

  T = sizes ('slot');
  [~, k] = ismember (d, T(:,1));
  h = T(k,:);
  b = tableform (h, l);
  [name, standard] = designate (h, h(:,2), l, b, 'slot');
  tool = repmat ({''}, n, 1);
  w = ! isnan (h(:,13));
  tool(w) = arrayfun (@(x, y) sprintf ("%g x %g", x, y), h(w,13), h(w,14), ...
                      'UniformOutput', false);
  source = arrayfun (@(p) sprintf ("REYHER, The Catalogue, 2020.04, p. %d", ...
                                   p), [A{:,2}]', 'UniformOutput', false);

  maker = repmat ({'REYHER'}, n, 1);
  E = table (name, standard, d, h(:,2), l, b, h(:,3), h(:,4), A(a,3), tool, ...
             A(a,4), A(a,5), maker, A(a,1), source(a));
  E.Properties.VariableNames = {'designation', 'standard', 'd', 'P', 'l', ...
                                'b', 'dk', 'k', 'drive', 'tool', 'class', ...
                                'finish', 'maker', 'article', 'source'};
  E.Properties.VariableUnits = {'', '', 'mm', 'mm', 'mm', 'mm', 'mm', 'mm', ...
                                '', '', '', '', '', '', ''};
  E.Properties.VariableDescriptions = {...
    'designation of ISO 8991, without the property class', ...
    'ISO 1207 or ISO 14580 when its table defines the screw', ...
    'nominal diameter', ...
    'pitch, coarse', ...
    'nominal length', ...
    'length of thread from the end', ...
    'head diameter at the bearing face, largest', ...
    'head height, largest', ...
    'slot or hexalobular', ...
    'screwdriver tip of ISO 2380-1, thickness by width', ...
    'property class or material', ...
    'finish as the maker names it', ...
    'maker', ...
    "maker's article number", ...
    'catalogue and page the article was read from'};
  E.Properties.Description = ['Cheese head screws: slotted, ISO 1207,', ...
                              ' and hexalobular socket, ISO 14580'];
  E = sortrows (E, {'d', 'l'});

endfunction

function S = shape (d, P, L, B, drive, detailed)

  T = sizes (drive);
  h = T(T(:,1) == d,:);
  if (isempty (h))
    if (strcmp (drive, 'slot'))
      error ("parts.screw.cheese: ISO 1207 defines no M%g head.", d);
    else
      error ("parts.screw.cheese: ISO 14580 defines no M%g head.", d);
    endif
  endif
  if (isnan (P))
    P = h(2);
  endif
  if (isempty (B))
    B = tableform (h, L);
  elseif (! isnumeric (B) || ! isreal (B) || ! isscalar (B) || B <= 0
          || B > L)
    error (strcat ("parts.screw.cheese: 'ThreadLength' must be a length", ...
                   " from 0 to L."));
  endif
  [name, ~, tname] = designate (h, P, L, B, drive);

  dk = h(3);
  k = h(4);
  if (detailed)
    r = h(7);
    top = dk / 2 - k * tand (5);
    R = geom.Region ([0, -L, 0; d / 2, -L, 0; d / 2, -r, -tan(pi/8);
                      d / 2 + r, 0, 0; dk / 2, 0, 0; top, k, 0; 0, k, 0]);
  else
    R = geom.Region ([0, -L; d / 2, -L; d / 2, 0; dk / 2, 0; dk / 2, k;
                      0, k]);
  endif
  R.UCS = geom.UCS ([0, -1, 0], [0, 0, 0]);
  S = solid.revolve (R);
  if (detailed)
    if (B == L)
      B = L - h(8);
    endif
    S = thread (S, [0, 0, -L], tname, B, 'Direction', [0, 0, 1], ...
                'Custom', true);
  endif
  if (strcmp (drive, 'slot'))
    S = parts.screw.__recess__ (S, 'slot', [h(5), dk, h(6)], k);
  else
    S = parts.screw.__recess__ (S, 'hexalobular', h(5:6), k, detailed);
  endif
  S.Name = name;

endfunction

%!test  # the catalogue, every article in every size and length
%! C = parts.screw.cheese ('data');
%! assert_equal (height (C), 756);
%!test  # an article as REYHER lists it
%! C = parts.screw.cheese ('data', 'M5', 20);
%! E = C(strcmp (C.article, '01207.400'),:);
%! assert_equal ([E.designation, E.class, E.finish, E.tool, E.drive], ...
%!               {'Cheese head screw ISO 1207 - M5 x 20', '4.8', ...
%!                'plain', '1.2 x 8', 'slot'});
%!test  # its sizes
%! C = parts.screw.cheese ('data', 'M5', 20);
%! E = C(strcmp (C.article, '01207.400'),:);
%! assert_equal ([E.d, E.P, E.l, E.b, E.dk, E.k], [5, 0.8, 20, 20, 8.5, 3.3]);
%!test  # each variable carries its unit and description
%! C = parts.screw.cheese ('data', 'M5', 20);
%! assert_equal (C.Properties.VariableUnits([3, 7]), {'mm', 'mm'});
%! assert_equal (C.Properties.VariableDescriptions{7}, ...
%!               'head diameter at the bearing face, largest');
%!test  # brass and plastic
%! C = parts.screw.cheese ('data', 'M5', 20);
%! assert_equal (all (ismember ({'brass', 'PA'}, C.class)), true);
%!test  # a length of the table past 40 has b min
%! C = parts.screw.cheese ('data', 'M5', 50);
%! assert_equal (C.designation(1), ...
%!               {'Cheese head screw ISO 1207 - M5 x 50'});
%! assert_equal (C.b(1), 38);
%!test  # a length past the table is custom
%! C = parts.screw.cheese ('data', 'M4', 60);
%! assert_equal (unique (C.designation), ...
%!               {'Cheese head screw M4 x 60 x 38'});
%!test  # no tip assigned to the smallest sizes
%! C = parts.screw.cheese ('data', 'M3', 10);
%! assert_equal (unique (C.tool), {''});
%!test  # 'Drive' keeps the slotted screws
%! C = parts.screw.cheese ('data', 'Drive', 'Slot');
%! assert_equal (height (C), 756);
%!testif ; exist ('__occt__') == 3  # head, shank and slot
%! S = parts.screw.cheese ('solid', 'M5', 20);
%! A = 2 * (0.6 * sqrt (4.25 ^ 2 - 0.36) + 4.25 ^ 2 * asin (0.6 / 4.25));
%! V = pi * (4.25 ^ 2 * 3.3 + 2.5 ^ 2 * 20) - A * 1.3;
%! assert_equal (volume (S), V, 1e-6);
%!testif ; exist ('__occt__') == 3  # the bearing face on the plane
%! S = parts.screw.cheese ('solid', 'M5', 20);
%! assert_equal (bbox (S), [-4.25, -4.25, -20, 4.25, 4.25, 3.3], 1e-6);
%!testif ; exist ('__occt__') == 3  # named by its designation
%! S = parts.screw.cheese ('solid', 'M5', 50, 'ThreadLength', 50);
%! assert_equal (S.Name, {'Cheese head screw M5 x 50'});
%!testif ; exist ('__occt__') == 3  # detailed: taper, fillet, thread
%! S = parts.screw.cheese ('solid', 'M3', 8, 'Detailed', true);
%! assert_equal (isvalid (S), true);
%!testif ; exist ('__occt__') == 3  # hexalobular: higher head, round hole
%! S = parts.screw.cheese ('solid', 'M5', 20, 'Drive', 'torx');
%! V = pi * (4.25 ^ 2 * 3.65 + 2.5 ^ 2 * 20 - 2.25 ^ 2 * 1.52);
%! assert_equal (volume (S), V, 1e-6);
%!testif ; exist ('__occt__') == 3  # hexalobular, named by ISO 14580
%! S = parts.screw.cheese ('solid', 'M5', 20, 'Drive', 'hexalobular');
%! assert_equal (S.Name, ...
%!               {'Hexalobular socket cheese head screw ISO 14580 - M5 x 20'});
%!testif ; exist ('__occt__') == 3  # hexalobular, past the table
%! S = parts.screw.cheese ('solid', 'M10', 90, 'Drive', 'torx');
%! assert_equal (S.Name, ...
%!               {'Hexalobular socket cheese head screw M10 x 90 x 38'});
%!testif ; exist ('__occt__') == 3  # hexalobular, detailed
%! S = parts.screw.cheese ('solid', 'M4', 10, 'Drive', 'torx', ...
%!                         'Detailed', true);
%! assert_equal (isvalid (S), true);

%!error<parts.screw.cheese: MODE must be 'data' or 'solid'.> ...
%! parts.screw.cheese ()
%!error<parts.screw.cheese: a solid needs a NAME and a length L.> ...
%! parts.screw.cheese ('solid', 'M5')
%!error<parts.screw.cheese: L must be a positive length.> ...
%! parts.screw.cheese ('solid', 'M5', 0)
%!error<parts.screw.cheese: NAME must name a metric thread, such as 'M5' or 'M5x0.5'.> ...
%! parts.screw.cheese ('data', 'M5y')
%!error<parts.screw.cheese: Name/Value arguments must come in pairs.> ...
%! parts.screw.cheese ('data', 'M5', 'Maker')
%!error<parts.screw.cheese: option names must be character vectors.> ...
%! parts.screw.cheese ('data', 5, 'Maker')
%!error<parts.screw.cheese: unknown option 'Point'.> ...
%! parts.screw.cheese ('data', 'Point', 'flat')
%!error<parts.screw.cheese: 'Drive' must be a character vector.> ...
%! parts.screw.cheese ('data', 'Drive', 1)
%!error<parts.screw.cheese: unknown drive 'cross'.> ...
%! parts.screw.cheese ('data', 'Drive', 'cross')
%!error<parts.screw.cheese: 'Maker' applies to 'data' only.> ...
%! parts.screw.cheese ('solid', 'M5', 20, 'Maker', 'REYHER')
%!error<parts.screw.cheese: 'Maker' must be a character vector.> ...
%! parts.screw.cheese ('data', 'Maker', 1)
%!error<parts.screw.cheese: 'Detailed' applies to 'solid' only.> ...
%! parts.screw.cheese ('data', 'Detailed', true)
%!error<parts.screw.cheese: 'Detailed' must be true or false.> ...
%! parts.screw.cheese ('solid', 'M5', 20, 'Detailed', 'yes')
%!error<parts.screw.cheese: 'Detailed' must be true or false.> ...
%! parts.screw.cheese ('solid', 'M5', 20, 'Detailed', 1)
%!error<parts.screw.cheese: 'ThreadLength' applies to 'solid' only.> ...
%! parts.screw.cheese ('data', 'ThreadLength', 10)
%!error<parts.screw.cheese: 'ThreadLength' must be a length from 0 to L.> ...
%! parts.screw.cheese ('solid', 'M5', 20, 'ThreadLength', 30)
%!error<parts.screw.cheese: ISO 1207 defines no M7 head.> ...
%! parts.screw.cheese ('solid', 'M7', 20)
%!error<parts.screw.cheese: ISO 14580 defines no M1.6 head.> ...
%! parts.screw.cheese ('solid', 'M1.6', 5, 'Drive', 'torx')
%!error<parts.screw.cheese: no cheese head screw with a hexalobular drive in the catalogue.> ...
%! parts.screw.cheese ('data', 'Drive', 'torx')
%!error<parts.screw.cheese: no M1.4 cheese head screw in the catalogue.> ...
%! parts.screw.cheese ('data', 'M1.4')
%!error<parts.screw.cheese: no M5 x 21 cheese head screw by NSK in the catalogue.> ...
%! parts.screw.cheese ('data', 'M5', 21, 'Maker', 'NSK')
