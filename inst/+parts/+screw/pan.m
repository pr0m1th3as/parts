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
## @deftypefn  {parts} {@var{C} =} parts.screw.pan (@qcode{'data'})
## @deftypefnx {parts} {@var{C} =} parts.screw.pan (@qcode{'data'}, @var{NAME})
## @deftypefnx {parts} {@var{C} =} parts.screw.pan (@qcode{'data'}, @var{NAME}, @var{L})
## @deftypefnx {parts} {@var{S} =} parts.screw.pan (@qcode{'solid'}, @var{NAME}, @var{L})
## @deftypefnx {parts} {@dots{} =} parts.screw.pan (@dots{}, @var{Name}, @var{Value})
##
## Pan head screws, ISO 1580, 7045 and 14583.
##
## @code{@var{C} = parts.screw.pan (@qcode{'data'})} returns every pan head
## screw in the catalogue as a table, one row for each maker's article in
## each size and length, sorted by size and length.
## @code{@var{C} = parts.screw.pan (@qcode{'data'}, @var{NAME})} returns
## those of the thread @var{NAME}, such as @qcode{'M5'}, and
## @code{@var{C} = parts.screw.pan (@qcode{'data'}, @var{NAME}, @var{L})}
## those of nominal length @var{L} too: every article sold as that screw,
## each with its drive, property class or material and finish.  Nothing is
## built.
##
## @code{@var{S} = parts.screw.pan (@qcode{'solid'}, @var{NAME}, @var{L})}
## builds the screw as a @code{solid.Shape} whether or not anyone sells it:
## any thread of a size its standard defines, any pitch, any length.  The
## bearing face of the head lies on the @math{xy} plane, the head above it,
## the shank below it to @math{z} = -@var{L}; the slot lies along the
## @math{x} axis, a cross recess's wings on the @math{x} and @math{y} axes,
## a hexalobular socket's lobes with one on the @math{x} axis.
## @code{@var{S}.Name} holds the screw's designation.
##
## Name/Value pairs:
##
## @table @asis
## @item @qcode{'Drive'}
## The drive, which selects the standard: @qcode{'hexalobular'} (alias
## @qcode{'torx'}), ISO 14583, the default; @qcode{'slot'}, ISO 1580;
## @qcode{'crossH'} (alias @qcode{'phillips'}) or @qcode{'crossZ'} (alias
## @qcode{'pozidriv'}), ISO 7045.  For @qcode{'data'} it keeps that drive's
## screws only; without it every drive comes.
##
## @item @qcode{'Maker'}
## For @qcode{'data'}: only that maker's articles, such as
## @qcode{'REYHER'}, in any case.
##
## @item @qcode{'ThreadLength'}
## For @qcode{'solid'}: the length of thread @var{b} from the end of the
## shank, from 0 to @var{L}; @var{L} threads it to the head.  Without it the
## screw follows its standard: threaded to the head up to the length its
## table gives, and longer ones threaded @var{b} min.
##
## @item @qcode{'Detailed'}
## For @qcode{'solid'}: @code{true} also builds the fillet of radius
## @var{r} under the head, for ISO 1580 the side's taper of 5 degrees,
## @var{dk} across at the bearing face, and the radius @var{rf} round the
## top, the true drive (@code{parts.screw.__recess__}), and the thread, cut
## by @code{solid.Shape.thread}; a screw threaded to the head is threaded
## to within @var{a} of it.  By default (@code{false}) the shank is a plain
## cylinder of diameter @var{d} and the drive the simple one.  The end is
## left flat, as rolled.
## @end table
##
## The heads: ISO 1580's a flat top on a side @var{dk} across; ISO 7045's
## and ISO 14583's a dome of radius @var{rf} on a side @var{dk} across, the
## blend between them, which no standard dimensions, left sharp.  ISO 14583
## gives the same @var{dk}, @var{k} and @var{rf} as ISO 7045.
##
## The table has these variables, each with its unit and its description,
## which @code{summary (@var{C})} lists; lengths are in millimetres:
##
## @multitable @columnfractions 0.16 0.84
## @item @code{designation} @tab designation of ISO 8991, as in
## @qcode{'Pan head screw ISO 7045 - M5 x 20 - Z'}, without the property
## class, a cross recess's type after the size
## @item @code{standard} @tab standard when its table defines the screw,
## else empty: such a screw is custom
## @item @code{d} @tab nominal diameter
## @item @code{P} @tab pitch, coarse
## @item @code{l} @tab nominal length
## @item @code{b} @tab length of thread from the end, @var{l} when threaded
## to the head
## @item @code{dk} @tab head diameter, largest
## @item @code{k} @tab head height, largest
## @item @code{drive} @tab @qcode{'slot'}, @qcode{'crossH'},
## @qcode{'crossZ'} or @qcode{'hexalobular'}
## @item @code{tool} @tab bit or tip, as @qcode{'PH2'}, @qcode{'T25'} or
## @qcode{'1.2 x 8'}
## @item @code{class} @tab property class or material
## @item @code{finish} @tab finish as the maker names it
## @item @code{maker} @tab maker
## @item @code{article} @tab maker's article number
## @item @code{source} @tab catalogue and page the article was read from
## @end multitable
##
## A screw is designated by its standard's number when its table defines it:
## a length of the size's commercial range with the thread form the table
## gives it.  Every other screw is custom, its thread length written when
## shorter than @var{l}.
##
## @subheading The catalogue
##
## Articles from REYHER, @cite{The Catalogue}, edition 2020.04, English,
## pages 326, 327, 403 (steel) and 520, 560 to 562, 590 (stainless steel):
## every article in sizes its standard defines.
##
## ISO 1580:1994 and ISO 7045:1994, heads, recesses, thread lengths and
## lengths, read in IS 6101:2005 and IS 7483:2005; ISO 14583:2011, read in
## its official preview, which agrees with GOST R ISO 14583-2009 (identical
## to ISO 14583:2001) and with fasten.it and fasteners.eu; cross recesses
## to ISO 4757 and hexalobular sockets to ISO 10664; screwdriver tips from
## Wera's assignment table to ISO 2380-1.
##
## @seealso{parts.screw.cheese, parts.screw.cap}
## @end deftypefn

function OUT = pan (MODE, varargin)

  if (nargin < 1 || ! ischar (MODE)
      || ! any (strcmp (MODE, {'data', 'solid'})))
    error ("parts.screw.pan: MODE must be 'data' or 'solid'.");
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
        error ("parts.screw.pan: L must be a positive length.");
      endif
    endif
  endif
  if (strcmp (MODE, 'solid') && isempty (L))
    error ("parts.screw.pan: a solid needs a NAME and a length L.");
  endif

  drive = 'hexalobular';
  bydrive = false;
  maker = '';
  detailed = false;
  B = [];
  if (mod (numel (args), 2) != 0)
    error ("parts.screw.pan: Name/Value arguments must come in pairs.");
  endif
  for ii = 1:2:numel (args)
    name = args{ii};
    val = args{ii+1};
    if (! ischar (name) || ! isrow (name))
      error ("parts.screw.pan: option names must be character vectors.");
    endif
    switch (lower (name))
      case 'drive'
        if (! ischar (val) || ! isrow (val))
          error ("parts.screw.pan: 'Drive' must be a character vector.");
        endif
        switch (lower (val))
          case {'hexalobular', 'torx'}
            drive = 'hexalobular';
          case 'slot'
            drive = 'slot';
          case {'crossh', 'phillips'}
            drive = 'crossH';
          case {'crossz', 'pozidriv'}
            drive = 'crossZ';
          otherwise
            error ("parts.screw.pan: unknown drive '%s'.", val);
        endswitch
        bydrive = true;
      case 'maker'
        if (strcmp (MODE, 'solid'))
          error ("parts.screw.pan: 'Maker' applies to 'data' only.");
        endif
        if (! ischar (val) || ! isrow (val))
          error ("parts.screw.pan: 'Maker' must be a character vector.");
        endif
        maker = val;
      case 'detailed'
        if (strcmp (MODE, 'data'))
          error ("parts.screw.pan: 'Detailed' applies to 'solid' only.");
        endif
        if (! islogical (val) || ! isscalar (val))
          error ("parts.screw.pan: 'Detailed' must be true or false.");
        endif
        detailed = val;
      case 'threadlength'
        if (strcmp (MODE, 'data'))
          error ("parts.screw.pan: 'ThreadLength' applies to 'solid' only.");
        endif
        B = val;
      otherwise
        error ("parts.screw.pan: unknown option '%s'.", name);
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
      error (strcat ("parts.screw.pan: NAME must name a metric thread,", ...
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

## The sizes of a drive's standard, a row for each: d, P, dk max, k max, the
## drive's size (slot n nom, recess number or hexalobular socket number),
## its depth (slot t min, recess penetration min, socket t min), the
## recess's m, rf (ref., or approx. for a dome), r min, a max, b min, the
## longest length threaded to the head, the shortest and longest commercial
## length, and the slot's screwdriver tip of ISO 2380-1 (thickness and
## width)
function T = sizes (drive)

  ## d, P, r min, a max and b min, common to all
  C = [1.6, 0.35, 0.1, 0.7, 25;
       2, 0.4, 0.1, 0.8, 25;
       2.5, 0.45, 0.1, 0.9, 25;
       3, 0.5, 0.1, 1, 25;
       3.5, 0.6, 0.1, 1.2, 38;
       4, 0.7, 0.2, 1.4, 38;
       5, 0.8, 0.2, 1.6, 38;
       6, 1, 0.25, 2, 38;
       8, 1.25, 0.4, 2.5, 38;
       10, 1.5, 0.4, 3, 38];
  dk = [3.2, 4, 5, 5.6, 7, 8, 9.5, 12, 16, 20]';
  switch (drive)
    case 'slot'
      ## ISO 1580:1994: k, n, t, rf, full up to, range, tip
      D = [1, 0.4, 0.35, 0.5, 30, 2, 16, 0.4, 2.5;
           1.3, 0.5, 0.5, 0.6, 30, 2.5, 20, 0.5, 3;
           1.5, 0.6, 0.6, 0.8, 30, 3, 25, 0.6, 3.5;
           1.8, 0.8, 0.7, 0.9, 30, 4, 30, 0.8, 5.5;
           2.1, 1, 0.8, 1, 40, 5, 35, 1, 5.5;
           2.4, 1.2, 1, 1.2, 40, 5, 40, 1.2, 8;
           3, 1.2, 1.2, 1.5, 40, 6, 50, 1.2, 8;
           3.6, 1.6, 1.4, 1.8, 40, 8, 60, 1.6, 10;
           4.8, 2, 1.9, 2.4, 40, 10, 80, 2, 12;
           6, 2.5, 2.4, 3, 40, 12, 80, 2.5, 14];
      T = [C(:,1:2), dk, D(:,1:3), NaN(10,1), D(:,4), C(:,3:5), D(:,5:9)];
    case {'crossH', 'crossZ'}
      ## ISO 7045:1994: k, recess number, m and penetration min of H and of
      ## Z, rf approx., full up to, range
      D = [1.3, 0, 1.7, 0.7, 1.6, 0.65, 2.5, 25, 3, 16;
           1.6, 0, 1.9, 0.9, 2.1, 1.17, 3.2, 25, 3, 20;
           2.1, 1, 2.7, 1.15, 2.6, 1.25, 4, 25, 3, 25;
           2.4, 1, 3, 1.4, 2.8, 1.5, 5, 25, 4, 30;
           2.6, 2, 3.9, 1.4, 3.9, 1.48, 6, 40, 5, 35;
           3.1, 2, 4.4, 1.9, 4.3, 1.89, 6.5, 40, 5, 40;
           3.7, 2, 4.9, 2.4, 4.7, 2.29, 8, 40, 6, 45;
           4.6, 3, 6.9, 3.1, 6.7, 3.03, 10, 40, 8, 60;
           6, 4, 9, 4, 8.8, 4.05, 13, 40, 10, 60;
           7.5, 4, 10.1, 5.2, 9.9, 5.24, 16, 40, 12, 60];
      z = 2 * strcmp (drive, 'crossZ');
      T = [C(:,1:2), dk, D(:,1:2), D(:,4+z), D(:,3+z), D(:,7), C(:,3:5), ...
           D(:,8:10), NaN(10,2)];
    case 'hexalobular'
      ## ISO 14583: k, socket number, t min, rf, full up to, range
      D = [1.6, 6, 0.63, 3.2, 30, 3, 20;
           2.1, 8, 0.91, 4, 30, 3, 25;
           2.4, 10, 1.01, 5, 30, 4, 30;
           2.6, 15, 1.07, 6, 40, 5, 35;
           3.1, 20, 1.27, 6.5, 40, 5, 40;
           3.7, 25, 1.52, 8, 40, 6, 50;
           4.6, 30, 2.02, 10, 40, 8, 60;
           6, 45, 2.79, 13, 40, 10, 60;
           7.5, 50, 3.62, 16, 40, 12, 60];
      T = [C(2:end,1:2), dk(2:end), D(:,1:3), NaN(9,1), D(:,4), ...
           C(2:end,3:5), D(:,5:7), NaN(9,2)];
  endswitch

endfunction

## The thread lengths of screws of size rows h and lengths l by their
## standard, a column
function b = tableform (h, l)

  b = l;
  part = l > h(:,12);
  b(part) = h(part,11);

endfunction

## The designations, standards and threads of screws of size rows h,
## pitches P, lengths l, thread lengths b and drives DRIVE, columns;
## character vectors for one
function [name, standard, thread] = designate (h, P, l, b, drive)

  series = [2, 2.5, 3:6, 8, 10, 12, 14, 16, 20:5:80];
  n = numel (l);
  if (ischar (drive))
    drive = repmat ({drive}, n, 1);
  endif
  drive = drive(:);
  iso = (P == h(:,2) & ismember (l, series) & l >= h(:,13) & l <= h(:,14)
         & b == tableform (h, l));
  standard = repmat ({''}, n, 1);
  slot = strcmp (drive, 'slot');
  lobe = strcmp (drive, 'hexalobular');
  cross = ! slot & ! lobe;
  standard(iso & slot) = {'ISO 1580'};
  standard(iso & cross) = {'ISO 7045'};
  standard(iso & lobe) = {'ISO 14583'};
  denom = repmat ({'Pan head screw'}, n, 1);
  denom(lobe) = {'Hexalobular socket pan head screw'};
  [name, thread] = parts.__designation__ (denom, standard, h(:,1), P, l, b);
  name(cross) = strcat (name(cross), {' - '}, ...
                        cellfun (@(s) s(end), drive(cross), ...
                                 'UniformOutput', false));
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
    error ("parts.screw.pan: no %span head screw%s in the catalogue.", ...
           what, how);
  endif

endfunction

## Every entry of the catalogue, sorted by size, then length
function E = entries ()

  ## BEGIN generated by tools/reyher_tables.py pan
  ## REYHER article, printed page, drive, class, finish; then each
  ## size with its lengths
  A = {'01580.920', 520, 'slot', 'A2', 'plain', {
         3, [4, 5, 6, 8, 10, 12, 14, 16, 20, 25, 30, 35];
         4, [5, 6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 50, 60];
         5, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80];
         6, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80]};
       '01580.940', 520, 'slot', 'A4', 'plain', {
         2, [3, 4, 5, 6, 8, 10, 12, 16, 20, 25, 30];
         2.5, [3, 4, 5, 6, 8, 10, 12, 16, 20, 25, 30];
         3, [5, 6, 8, 10, 12, 16, 20, 25, 30];
         4, [5, 6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50];
         5, [8, 10, 12, 16, 20, 25, 30, 40, 50];
         6, [8, 10, 12, 16, 20, 25, 30, 35, 40, 50];
         8, [10, 12, 16, 20, 25]};
       '07045.404', 326, 'crossH', '4.8', 'plain', {
         3, [5, 6, 8, 10, 12, 16, 20];
         4, [6, 8, 10, 12, 16, 20, 25, 30];
         5, [8, 10, 12, 16, 20, 25];
         6, [10, 12, 16, 20, 25, 40];
         8, [16, 25]};
       '07045.414', 326, 'crossH', '4.8', 'zinc plated', {
         2, [4, 5, 6, 8, 10, 12, 16, 20];
         2.5, [4, 5, 6, 8, 10, 12, 14, 16, 20, 25, 30];
         3, [3, 4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 28, 30, 35, 40, ...
             45, 50, 55];
         3.5, [5, 6];
         4, [4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, ...
             50, 55, 60, 65, 70, 80, 85, 90, 100];
         5, [6, 8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, 60, 70, ...
             80, 90, 100];
         6, [8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, ...
             75, 80, 90, 100];
         8, [12, 16, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90];
         10, [25]};
       '07045.416', 327, 'crossZ', '4.8', 'zinc plated', {
         2.5, [4, 5, 6, 8, 10, 12, 16];
         3, [4, 5, 6, 8, 10, 12, 16, 20, 25, 30, 35, 40];
         4, [5, 6, 8, 10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 60, 70];
         5, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80];
         6, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60]};
       '07045.435', 327, 'crossH', '4.8', 'zinc plated 8 TLP', {
         3, [6, 8, 12, 16];
         4, [8, 10, 12, 16, 20, 25, 30];
         5, [8, 10, 12, 16, 20];
         6, [10, 12, 25]};
       '07045.925', 560, 'crossH', 'A2', 'plain', {
         1.6, [2, 3, 4, 5, 6, 8, 10, 12, 16];
         2, [2, 3, 4, 5, 6, 8, 10, 12, 14, 16, 18, 20];
         2.5, [3, 4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 25, 30];
         3, [4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, ...
             50];
         4, [4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, ...
             50, 55, 60, 70];
         5, [6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, ...
             60, 70, 80, 90];
         6, [8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, ...
             80, 90];
         8, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60];
         10, [12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60]};
       '07045.926', 561, 'crossZ', 'A2', 'plain', {
         1.6, [3, 4, 5, 6, 8, 12, 16];
         2, [3, 5, 6, 8, 10, 12, 16];
         2.5, [4, 6, 8, 10, 12, 16, 18, 20, 25, 30];
         3, [4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 25, 30, 35];
         4, [5, 6, 8, 10, 12, 14, 16, 18, 20, 30, 35, 40, 45, 50, 60, 70];
         5, [6, 8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50];
         6, [8, 10, 12, 16, 20, 25, 30, 40, 45, 50, 55, 60];
         8, [10, 12, 16, 20, 25, 30, 50];
         10, [30]};
       '07045.944', 562, 'crossH', 'A4', 'plain', {
         1.6, [3, 4, 5, 6, 8, 10];
         2, [4, 6, 8, 10, 12, 16, 20];
         2.5, [4, 5, 6, 8, 10, 12, 14, 16, 20, 30];
         3, [4, 5, 6, 8, 10, 12, 14, 16, 20, 25, 30, 35, 40, 50];
         4, [5, 6, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50];
         5, [6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 60];
         6, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60]};
       '14583.410', 403, 'hexalobular', '4.8', 'zinc plated', {
         2, [4, 6, 8, 10, 12, 16];
         2.5, [4, 5, 6, 8, 10, 12, 16];
         3, [4, 5, 6, 8, 10, 12, 16, 20, 25, 30, 40];
         4, [5, 6, 8, 10, 12, 16, 20, 25, 30, 32, 35];
         5, [6, 8, 10, 12, 16, 18, 20, 25, 30];
         6, [10, 12, 16, 20, 25, 30]};
       '14583.920', 590, 'hexalobular', 'A2', 'plain', {
         2, [2, 3, 4, 5, 6, 8, 10, 12, 16, 20];
         2.5, [3, 4, 5, 6, 8, 10, 12, 16, 20, 25];
         3, [4, 5, 6, 8, 10, 12, 16, 20, 25, 30];
         4, [5, 6, 8, 10, 12, 16, 20, 25, 30, 35, 40];
         5, [6, 8, 10, 12, 20, 25, 30, 35, 40, 45, 50];
         6, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60];
         8, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60];
         10, [12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60]};
      };
  ## END generated

  ## One row for each article, size and length
  Z = vertcat (A{:,6});
  nl = cellfun (@numel, Z(:,2));
  a = repelem (repelem ((1:rows (A))', cellfun (@rows, A(:,6))), nl);
  d = repelem (cell2mat (Z(:,1)), nl);
  l = [Z{:,2}]';
  n = numel (l);
  drive = A(a,3);

  h = NaN (n, 16);
  for p = {'slot', 'crossH', 'crossZ', 'hexalobular'}
    T = sizes (p{1});
    is = strcmp (drive, p{1});
    [~, k] = ismember (d(is), T(:,1));
    h(is,:) = T(k,:);
  endfor
  b = tableform (h, l);
  [name, standard] = designate (h, h(:,2), l, b, drive);
  tool = cell (n, 1);
  is = strcmp (drive, 'slot');
  tool(is) = arrayfun (@(x, y) sprintf ("%g x %g", x, y), h(is,15), ...
                       h(is,16), 'UniformOutput', false);
  is = strcmp (drive, 'crossH');
  tool(is) = arrayfun (@(x) sprintf ("PH%d", x), h(is,5), ...
                       'UniformOutput', false);
  is = strcmp (drive, 'crossZ');
  tool(is) = arrayfun (@(x) sprintf ("PZ%d", x), h(is,5), ...
                       'UniformOutput', false);
  is = strcmp (drive, 'hexalobular');
  tool(is) = arrayfun (@(x) sprintf ("T%d", x), h(is,5), ...
                       'UniformOutput', false);
  source = arrayfun (@(p) sprintf ("REYHER, The Catalogue, 2020.04, p. %d", ...
                                   p), [A{:,2}]', 'UniformOutput', false);

  maker = repmat ({'REYHER'}, n, 1);
  E = table (name, standard, d, h(:,2), l, b, h(:,3), h(:,4), drive, tool, ...
             A(a,4), A(a,5), maker, A(a,1), source(a));
  E.Properties.VariableNames = {'designation', 'standard', 'd', 'P', 'l', ...
                                'b', 'dk', 'k', 'drive', 'tool', 'class', ...
                                'finish', 'maker', 'article', 'source'};
  E.Properties.VariableUnits = {'', '', 'mm', 'mm', 'mm', 'mm', 'mm', 'mm', ...
                                '', '', '', '', '', '', ''};
  E.Properties.VariableDescriptions = {...
    'designation of ISO 8991, without the property class', ...
    'standard when its table defines the screw', ...
    'nominal diameter', ...
    'pitch, coarse', ...
    'nominal length', ...
    'length of thread from the end', ...
    'head diameter, largest', ...
    'head height, largest', ...
    'slot, crossH, crossZ or hexalobular', ...
    'bit or tip', ...
    'property class or material', ...
    'finish as the maker names it', ...
    'maker', ...
    "maker's article number", ...
    'catalogue and page the article was read from'};
  E.Properties.Description = 'Pan head screws, ISO 1580, 7045 and 14583';
  E = sortrows (E, {'d', 'l'});

endfunction

function S = shape (d, P, L, B, drive, detailed)

  T = sizes (drive);
  h = T(T(:,1) == d,:);
  if (isempty (h))
    std = struct ('slot', 'ISO 1580', 'crossH', 'ISO 7045', ...
                  'crossZ', 'ISO 7045', 'hexalobular', 'ISO 14583');
    error ("parts.screw.pan: %s defines no M%g head.", std.(drive), d);
  endif
  if (isnan (P))
    P = h(2);
  endif
  if (isempty (B))
    B = tableform (h, L);
  elseif (! isnumeric (B) || ! isreal (B) || ! isscalar (B) || B <= 0
          || B > L)
    error ("parts.screw.pan: 'ThreadLength' must be a length from 0 to L.");
  endif
  [name, ~, tname] = designate (h, P, L, B, drive);

  dk = h(3);
  k = h(4);
  rf = h(8);
  if (detailed)
    r = h(9);
    U = [0, -L, 0; d / 2, -L, 0; d / 2, -r, -tan(pi/8); d / 2 + r, 0, 0];
  else
    U = [0, -L, 0; d / 2, -L, 0; d / 2, 0, 0];
  endif
  if (strcmp (drive, 'slot'))
    if (detailed)
      ## The side at 5 degrees, a radius rf round the top: the corner turns
      ## through 85 degrees
      c = dk / 2 - k * tand (5);
      q = rf * tand (85 / 2);
      x = c + q * sind (5);
      z = k - q * cosd (5);
      f = tand (85 / 4);
      V = [dk / 2, 0, 0; x, z, f; c - q, k, 0; 0, k, 0];
    else
      V = [dk / 2, 0, 0; dk / 2, k, 0; 0, k, 0];
    endif
  else
    ## The dome of radius rf on a side dk across
    zs = k - rf + sqrt (rf ^ 2 - dk ^ 2 / 4);
    w = asin (dk / 2 / rf);
    V = [dk / 2, 0, 0; dk / 2, zs, tan(w/4); 0, k, 0];
  endif
  R = geom.Region ([U; V]);
  R.UCS = geom.UCS ([0, -1, 0], [0, 0, 0]);
  S = solid.revolve (R);
  if (detailed)
    if (B == L)
      B = L - h(10);
    endif
    S = thread (S, [0, 0, -L], tname, B, 'Direction', [0, 0, 1], ...
                'Custom', true);
  endif
  switch (drive)
    case 'slot'
      S = parts.screw.__recess__ (S, 'slot', [h(5), dk, h(6)], k);
    case {'crossH', 'crossZ'}
      S = parts.screw.__recess__ (S, drive, [h(5), h(7), h(6)], k, detailed);
    case 'hexalobular'
      S = parts.screw.__recess__ (S, drive, h(5:6), k, detailed);
  endswitch
  S.Name = name;

endfunction

%!test  # the catalogue, every article in every size and length
%! C = parts.screw.pan ('data');
%! assert_equal (height (C), 787);
%!test  # an article as REYHER lists it
%! C = parts.screw.pan ('data', 'M5', 20);
%! E = C(strcmp (C.article, '07045.404'),:);
%! assert_equal ([E.designation, E.class, E.finish, E.tool, E.drive], ...
%!               {'Pan head screw ISO 7045 - M5 x 20 - H', '4.8', ...
%!                'plain', 'PH2', 'crossH'});
%!test  # its sizes
%! C = parts.screw.pan ('data', 'M5', 20);
%! E = C(strcmp (C.article, '07045.404'),:);
%! assert_equal ([E.d, E.P, E.l, E.b, E.dk, E.k], [5, 0.8, 20, 20, 9.5, 3.7]);
%!test  # each variable carries its unit and description
%! C = parts.screw.pan ('data', 'M5', 20);
%! assert_equal (C.Properties.VariableUnits([3, 7]), {'mm', 'mm'});
%! assert_equal (C.Properties.VariableDescriptions{7}, ...
%!               'head diameter, largest');
%!test  # without 'Drive' every drive comes
%! C = parts.screw.pan ('data', 'M5', 20);
%! assert_equal (unique (C.drive)', ...
%!               {'crossH', 'crossZ', 'hexalobular', 'slot'});
%!test  # 'Drive' keeps one, by its alias
%! C = parts.screw.pan ('data', 'M5', 20, 'Drive', 'Pozidriv');
%! assert_equal (unique ([C.designation; C.tool])', ...
%!               {'PZ2', 'Pan head screw ISO 7045 - M5 x 20 - Z'});
%!test  # a slotted screw, ISO 1580
%! C = parts.screw.pan ('data', 'M5', 20, 'Drive', 'slot');
%! assert_equal ([C.designation(1), C.tool(1)], ...
%!               {'Pan head screw ISO 1580 - M5 x 20', '1.2 x 8'});
%!test  # a hexalobular screw, ISO 14583
%! C = parts.screw.pan ('data', 'M5', 20, 'Drive', 'torx');
%! assert_equal ([C.designation(1), C.tool(1)], ...
%!               {['Hexalobular socket pan head screw ISO 14583', ...
%!                 ' - M5 x 20'], 'T25'});
%!test  # ISO 7045 threads M3 x 30 b min, ISO 14583 to the head
%! C = parts.screw.pan ('data', 'M3', 30);
%! assert_equal (unique ([C.b(strcmp (C.drive, 'crossH')); ...
%!                        C.b(strcmp (C.drive, 'hexalobular'))])', [25, 30]);
%!test  # a length past the table is custom
%! C = parts.screw.pan ('data', 'M4', 50, 'Drive', 'phillips');
%! assert_equal (unique (C.designation), ...
%!               {'Pan head screw M4 x 50 x 38 - H'});
%!testif ; exist ('__occt__') == 3  # hexalobular by default: dome, round hole
%! S = parts.screw.pan ('solid', 'M5', 20);
%! zs = 3.7 - 8 + sqrt (64 - 9.5 ^ 2 / 4);
%! h = 3.7 - zs;
%! a = 2.25;
%! V = pi * (9.5 ^ 2 / 4 * zs + h ^ 2 * (24 - h) / 3 + 2.5 ^ 2 * 20) ...
%!     - pi * a ^ 2 * (1.52 - 8) - 2 * pi / 3 * (512 - (64 - a ^ 2) ^ 1.5);
%! assert_equal (volume (S), V, 1e-6);
%!testif ; exist ('__occt__') == 3  # slotted: flat head, slot
%! S = parts.screw.pan ('solid', 'M5', 20, 'Drive', 'slot');
%! A = 2 * (0.6 * sqrt (4.75 ^ 2 - 0.36) + 4.75 ^ 2 * asin (0.6 / 4.75));
%! V = pi * (4.75 ^ 2 * 3 + 2.5 ^ 2 * 20) - A * 1.2;
%! assert_equal (volume (S), V, 1e-6);
%!testif ; exist ('__occt__') == 3  # the bearing face on the plane
%! S = parts.screw.pan ('solid', 'M5', 20, 'Drive', 'slot');
%! assert_equal (bbox (S), [-4.75, -4.75, -20, 4.75, 4.75, 3], 1e-6);
%!testif ; exist ('__occt__') == 3  # named by its designation
%! S = parts.screw.pan ('solid', 'M5', 20, 'Drive', 'crossZ');
%! assert_equal (S.Name, {'Pan head screw ISO 7045 - M5 x 20 - Z'});
%!testif ; exist ('__occt__') == 3  # custom by its thread length
%! S = parts.screw.pan ('solid', 'M5', 50, 'Drive', 'slot', ...
%!                      'ThreadLength', 50);
%! assert_equal (S.Name, {'Pan head screw M5 x 50'});
%!testif ; exist ('__occt__') == 3  # detailed slotted: taper, rf, thread
%! S = parts.screw.pan ('solid', 'M5', 20, 'Drive', 'slot', 'Detailed', true);
%! assert_equal (isvalid (S), true);
%!testif ; exist ('__occt__') == 3  # detailed cross recess H
%! S = parts.screw.pan ('solid', 'M5', 20, 'Drive', 'crossH', ...
%!                      'Detailed', true);
%! assert_equal (isvalid (S), true);
%!testif ; exist ('__occt__') == 3  # detailed cross recess Z
%! S = parts.screw.pan ('solid', 'M5', 20, 'Drive', 'crossZ', ...
%!                      'Detailed', true);
%! assert_equal (isvalid (S), true);
%!testif ; exist ('__occt__') == 3  # detailed hexalobular
%! S = parts.screw.pan ('solid', 'M5', 20, 'Detailed', true);
%! assert_equal (isvalid (S), true);

%!error<parts.screw.pan: MODE must be 'data' or 'solid'.> ...
%! parts.screw.pan ()
%!error<parts.screw.pan: a solid needs a NAME and a length L.> ...
%! parts.screw.pan ('solid', 'M5')
%!error<parts.screw.pan: L must be a positive length.> ...
%! parts.screw.pan ('solid', 'M5', 0)
%!error<parts.screw.pan: NAME must name a metric thread, such as 'M5' or 'M5x0.5'.> ...
%! parts.screw.pan ('data', 'M5y')
%!error<parts.screw.pan: Name/Value arguments must come in pairs.> ...
%! parts.screw.pan ('data', 'M5', 'Maker')
%!error<parts.screw.pan: option names must be character vectors.> ...
%! parts.screw.pan ('data', 5, 'Maker')
%!error<parts.screw.pan: unknown option 'Point'.> ...
%! parts.screw.pan ('data', 'Point', 'flat')
%!error<parts.screw.pan: 'Drive' must be a character vector.> ...
%! parts.screw.pan ('data', 'Drive', 1)
%!error<parts.screw.pan: unknown drive 'hexsocket'.> ...
%! parts.screw.pan ('data', 'Drive', 'hexsocket')
%!error<parts.screw.pan: 'Maker' applies to 'data' only.> ...
%! parts.screw.pan ('solid', 'M5', 20, 'Maker', 'REYHER')
%!error<parts.screw.pan: 'Maker' must be a character vector.> ...
%! parts.screw.pan ('data', 'Maker', 1)
%!error<parts.screw.pan: 'Detailed' applies to 'solid' only.> ...
%! parts.screw.pan ('data', 'Detailed', true)
%!error<parts.screw.pan: 'Detailed' must be true or false.> ...
%! parts.screw.pan ('solid', 'M5', 20, 'Detailed', 'yes')
%!error<parts.screw.pan: 'Detailed' must be true or false.> ...
%! parts.screw.pan ('solid', 'M5', 20, 'Detailed', 1)
%!error<parts.screw.pan: 'ThreadLength' applies to 'solid' only.> ...
%! parts.screw.pan ('data', 'ThreadLength', 10)
%!error<parts.screw.pan: 'ThreadLength' must be a length from 0 to L.> ...
%! parts.screw.pan ('solid', 'M5', 20, 'ThreadLength', 30)
%!error<parts.screw.pan: ISO 14583 defines no M1.6 head.> ...
%! parts.screw.pan ('solid', 'M1.6', 5)
%!error<parts.screw.pan: ISO 1580 defines no M7 head.> ...
%! parts.screw.pan ('solid', 'M7', 20, 'Drive', 'slot')
%!error<parts.screw.pan: no M1.4 pan head screw in the catalogue.> ...
%! parts.screw.pan ('data', 'M1.4')
%!error<parts.screw.pan: no M5 x 21 pan head screw with a slot drive by NSK in the catalogue.> ...
%! parts.screw.pan ('data', 'M5', 21, 'Drive', 'slot', 'Maker', 'NSK')
