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
## @deftypefn  {parts} {@var{C} =} parts.screw.countersunk (@qcode{'data'})
## @deftypefnx {parts} {@var{C} =} parts.screw.countersunk (@qcode{'data'}, @var{NAME})
## @deftypefnx {parts} {@var{C} =} parts.screw.countersunk (@qcode{'data'}, @var{NAME}, @var{L})
## @deftypefnx {parts} {@var{S} =} parts.screw.countersunk (@qcode{'solid'}, @var{NAME}, @var{L})
## @deftypefnx {parts} {@dots{} =} parts.screw.countersunk (@dots{}, @var{Name}, @var{Value})
##
## Countersunk head screws, ISO 10642, 2009, 7046 and 14581.
##
## @code{@var{C} = parts.screw.countersunk (@qcode{'data'})} returns every
## countersunk head screw in the catalogue as a table, one row for each
## maker's article in each size and length, sorted by size and length.
## @code{@var{C} = parts.screw.countersunk (@qcode{'data'}, @var{NAME})}
## returns those of the thread @var{NAME}, such as @qcode{'M5'}, and
## @code{@var{C} = parts.screw.countersunk (@qcode{'data'}, @var{NAME},
## @var{L})} those of nominal length @var{L} too: every article sold as that
## screw, each with its drive, property class or material and finish.
## Nothing is built.
##
## @code{@var{S} = parts.screw.countersunk (@qcode{'solid'}, @var{NAME},
## @var{L})} builds the screw as a @code{solid.Shape} whether or not anyone
## sells it: any thread of a size its standard defines, any pitch, any
## length.  The top of the head lies on the @math{xy} plane, flush with the
## surface it is sunk into, and the screw runs down to @math{z} = -@var{L}:
## the nominal length of a countersunk screw includes its head.  A hexagon
## socket has two corners on the @math{x} axis, a hexalobular socket two
## lobes, a slot lies along it and a cross recess's wings on the @math{x}
## and @math{y} axes.  @code{@var{S}.Name} holds the screw's designation.
##
## Name/Value pairs:
##
## @table @asis
## @item @qcode{'Drive'}
## The drive, which selects the standard: @qcode{'hexsocket'} (alias
## @qcode{'allen'}), ISO 10642, the default; @qcode{'slot'}, ISO 2009;
## @qcode{'crossH'} (alias @qcode{'phillips'}) or @qcode{'crossZ'} (alias
## @qcode{'pozidriv'}), ISO 7046; @qcode{'hexalobular'} (alias
## @qcode{'torx'}), ISO 14581.  ISO 10642's head is larger than the one the
## other three share and its sizes run to M20, theirs to M10, so the drive
## changes more than the recess.  For @qcode{'data'} it keeps that drive's
## screws only; without it every drive comes.
##
## @item @qcode{'Class'}
## For @qcode{'solid'} with a cross recess: the property class or
## material, which selects the part of ISO 7046: @qcode{'4.8'}, the
## default, part 1; @qcode{'8.8'}, a stainless steel such as @qcode{'A2'},
## or a non-ferrous metal (@qcode{'CU2'}, @qcode{'CU3'}, @qcode{'brass'}),
## part 2.  Any other class makes the screw custom.  It changes the name
## only, the two parts sharing their heads.
##
## @item @qcode{'Maker'}
## For @qcode{'data'}: only that maker's articles, such as
## @qcode{'REYHER'}, in any case.
##
## @item @qcode{'ThreadLength'}
## For @qcode{'solid'}: the length of thread @var{b} from the end of the
## shank, from 0 to @var{L} - @var{k}, or @var{L} to thread it to the
## head.  Without it the screw follows its standard: threaded to the head
## up to the length its table gives, longer ones threaded @var{b}.
##
## @item @qcode{'Detailed'}
## For @qcode{'solid'}: @code{true} also builds the fillet of radius
## @var{r} between the cone and the shank, the true drive
## (@code{parts.screw.__recess__}) and the thread, cut by
## @code{solid.Shape.thread}; a screw threaded to the head is threaded to
## within @var{k} + @var{a} of the top, @var{a} being 3@var{P} for a
## hexagon socket and 2@var{P} for the rest.  By default (@code{false}) the
## shank is a plain cylinder of diameter @var{d} and the drive the simple
## one.  The end is left flat, as rolled.
## @end table
##
## The head is the 90 degree cone of its standard, which reaches the
## theoretical diameter @var{dkt} at the top, cut by a cylinder of the
## actual head diameter @var{dk}: the edge, which the standards let be flat
## or rounded, is that cylinder.
##
## The table has these variables, each with its unit and its description,
## which @code{summary (@var{C})} lists; lengths are in millimetres:
##
## @multitable @columnfractions 0.16 0.84
## @item @code{designation} @tab designation of ISO 8991, as in
## @qcode{'Hexagon socket countersunk head screw ISO 10642 - M5 x 20'},
## without the property class, a cross recess's type after the size
## @item @code{standard} @tab standard when its table defines the screw,
## else empty: such a screw is custom
## @item @code{d} @tab nominal diameter
## @item @code{P} @tab pitch, coarse
## @item @code{l} @tab nominal length, the head included
## @item @code{b} @tab length of thread from the end, @var{l} when threaded
## to the head
## @item @code{dk} @tab actual head diameter, largest
## @item @code{dkt} @tab theoretical head diameter, where the cone meets the
## top, @var{d} + 2@var{k}: the diameter a countersink is made to
## @item @code{k} @tab head height, largest
## @item @code{drive} @tab @qcode{'hexsocket'}, @qcode{'slot'},
## @qcode{'crossH'}, @qcode{'crossZ'} or @qcode{'hexalobular'}
## @item @code{tool} @tab key, bit or tip, as @qcode{'3'},
## @qcode{'PH2'}, @qcode{'T25'} or @qcode{'1.2 x 6.5'}
## @item @code{class} @tab property class or material, as REYHER prints it:
## @qcode{'08.8'} and @qcode{'010.9'} mark the reduced loadability of
## ISO 10642's head
## @item @code{finish} @tab finish as the maker names it
## @item @code{maker} @tab maker
## @item @code{article} @tab maker's article number
## @item @code{source} @tab catalogue and page the article was read from
## @end multitable
##
## A screw is designated by its standard's number when its table defines it:
## a length of the size's commercial range with the thread form the table
## gives it.  Every other screw is custom, its thread length written when
## shorter than @var{l}.  A cross recessed screw takes ISO 7046-1 or
## ISO 7046-2 by its class.
##
## @subheading The catalogue
##
## Articles from REYHER, @cite{The Catalogue}, edition 2020.04, English,
## pages 225 to 227, 328, 329, 389 to 394 and 403 (steel), 522, 523, 562 to
## 564 and 587 to 589 (stainless steel), 634 and 635 (brass, plastic): every
## article in sizes its standard defines.  Left out: the sizes M1 to M1.4,
## the slotted M12 to M20 (DIN 963's, not ISO 2009's), the hexagon socket
## M22 and M24 (DIN 7991's, which ISO 10642 replaced) and the hexalobular
## article 10642.814, whose socket ISO 10642 does not define.
##
## ISO 2009:1994, ISO 7046-1:1994 and ISO 7046-2:1990, heads, recesses,
## thread lengths and lengths, read in IS 1365:2005 and IS 7485 Parts 1 and
## 2:2005; ISO 7046-2's cross recess is its deep series, as part 1's, and
## its underhead shoulder is left out.  ISO 10642:2004, read in GOST R ISO
## 10642-2012, with the actual head diameters of Würth's, SFS's and
## Fabory's article pages.  ISO 14581:2013, read in GOST R ISO 14581-2021
## and in its official preview, whose heads and sockets agree with fasten.it
## and fasteners.eu; its thread form from the preview, the same as ISO 2009's.
## Cross recesses to ISO 4757 and hexalobular sockets to ISO 10664;
## screwdriver tips from Wera's assignment table to ISO 2380-1.
##
## @seealso{parts.screw.cap, parts.screw.pan}
## @end deftypefn

function OUT = countersunk (MODE, varargin)

  if (nargin < 1 || ! ischar (MODE)
      || ! any (strcmp (MODE, {'data', 'solid'})))
    error ("parts.screw.countersunk: MODE must be 'data' or 'solid'.");
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
        error ("parts.screw.countersunk: L must be a positive length.");
      endif
    endif
  endif
  if (strcmp (MODE, 'solid') && isempty (L))
    error ("parts.screw.countersunk: a solid needs a NAME and a length L.");
  endif

  drive = 'hexsocket';
  bydrive = false;
  class = '';
  maker = '';
  detailed = false;
  B = [];
  if (mod (numel (args), 2) != 0)
    error (strcat ("parts.screw.countersunk: Name/Value arguments must", ...
                   " come in pairs."));
  endif
  for ii = 1:2:numel (args)
    name = args{ii};
    val = args{ii+1};
    if (! ischar (name) || ! isrow (name))
      error (strcat ("parts.screw.countersunk: option names must be", ...
                     " character vectors."));
    endif
    switch (lower (name))
      case 'drive'
        if (! ischar (val) || ! isrow (val))
          error (strcat ("parts.screw.countersunk: 'Drive' must be a", ...
                         " character vector."));
        endif
        switch (lower (val))
          case {'hexsocket', 'allen'}
            drive = 'hexsocket';
          case 'slot'
            drive = 'slot';
          case {'crossh', 'phillips'}
            drive = 'crossH';
          case {'crossz', 'pozidriv'}
            drive = 'crossZ';
          case {'hexalobular', 'torx'}
            drive = 'hexalobular';
          otherwise
            error ("parts.screw.countersunk: unknown drive '%s'.", val);
        endswitch
        bydrive = true;
      case 'class'
        if (strcmp (MODE, 'data'))
          error (strcat ("parts.screw.countersunk: 'Class' applies to", ...
                         " 'solid' only."));
        endif
        if (! ischar (val) || ! isrow (val))
          error (strcat ("parts.screw.countersunk: 'Class' must be a", ...
                         " character vector."));
        endif
        class = val;
      case 'maker'
        if (strcmp (MODE, 'solid'))
          error (strcat ("parts.screw.countersunk: 'Maker' applies to", ...
                         " 'data' only."));
        endif
        if (! ischar (val) || ! isrow (val))
          error (strcat ("parts.screw.countersunk: 'Maker' must be a", ...
                         " character vector."));
        endif
        maker = val;
      case 'detailed'
        if (strcmp (MODE, 'data'))
          error (strcat ("parts.screw.countersunk: 'Detailed' applies to", ...
                         " 'solid' only."));
        endif
        if (! islogical (val) || ! isscalar (val))
          error (strcat ("parts.screw.countersunk: 'Detailed' must be", ...
                         " true or false."));
        endif
        detailed = val;
      case 'threadlength'
        if (strcmp (MODE, 'data'))
          error (strcat ("parts.screw.countersunk: 'ThreadLength' applies", ...
                         " to 'solid' only."));
        endif
        B = val;
      otherwise
        error ("parts.screw.countersunk: unknown option '%s'.", name);
    endswitch
  endfor
  if (! isempty (class) && ! any (strcmp (drive, {'crossH', 'crossZ'})))
    error (strcat ("parts.screw.countersunk: 'Class' applies to a cross", ...
                   " recess only."));
  endif
  if (isempty (class))
    class = '4.8';
  endif

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
      error (strcat ("parts.screw.countersunk: NAME must name a metric", ...
                     " thread, such as 'M5' or 'M5x0.5'."));
    endif
    d = str2double (tok{1});
    if (! isempty (tok{2}))
      P = str2double (tok{2});
    endif
  endif

  if (strcmp (MODE, 'data'))
    OUT = catalogue (NAME, d, P, L, drive, bydrive, maker);
  else
    OUT = shape (d, P, L, B, drive, class, detailed);
  endif

endfunction

## The sizes of a drive's standard, a row for each: d, P, dk actual max,
## k max, the drive's size (socket s nom, slot n nom, recess number or
## hexalobular socket number), its depth (t min, or the recess's
## penetration min), the cross recess's m, r, a, b, the longest length
## threaded to the head, the shortest and longest commercial length, and
## the slot's screwdriver tip of ISO 2380-1 (thickness and width)
function T = sizes (drive)

  ## d and P of the sizes ISO 2009, 7046 and 14581 share
  C = [1.6, 0.35;
       2, 0.4;
       2.5, 0.45;
       3, 0.5;
       3.5, 0.6;
       4, 0.7;
       5, 0.8;
       6, 1;
       8, 1.25;
       10, 1.5];
  ## Their head, ISO 2009 and 7046: dk actual max, k max, r max, b min,
  ## full up to
  H = [3, 1, 0.4, 25, 30;
       3.8, 1.2, 0.5, 25, 30;
       4.7, 1.5, 0.6, 25, 30;
       5.5, 1.65, 0.8, 25, 30;
       7.3, 2.35, 0.9, 38, 45;
       8.4, 2.7, 1, 38, 45;
       9.3, 2.7, 1.3, 38, 45;
       11.3, 3.3, 1.5, 38, 45;
       15.8, 4.65, 2, 38, 45;
       18.3, 5, 2.5, 38, 45];
  switch (drive)
    case 'hexsocket'
      ## ISO 10642:2004: d, P, dk actual max, k max, s, t min, r min, b,
      ## full up to, range
      D = [3, 0.5, 5.81, 1.86, 2, 1.1, 0.1, 18, 25, 8, 30;
           4, 0.7, 7.96, 2.48, 2.5, 1.5, 0.2, 20, 25, 8, 40;
           5, 0.8, 10.07, 3.1, 3, 1.9, 0.2, 22, 30, 8, 50;
           6, 1, 12.16, 3.72, 4, 2.2, 0.25, 24, 35, 8, 60;
           8, 1.25, 16.43, 4.96, 5, 3, 0.4, 28, 45, 10, 80;
           10, 1.5, 20.69, 6.2, 6, 3.6, 0.4, 32, 50, 12, 100;
           12, 1.75, 24.81, 7.44, 8, 4.3, 0.6, 36, 60, 16, 100;
           14, 2, 28.31, 8.4, 10, 4.5, 0.6, 40, 65, 20, 100;
           16, 2, 30.61, 8.8, 10, 4.8, 0.6, 44, 70, 25, 100;
           20, 2.5, 36.75, 10.16, 12, 5.6, 0.8, 52, 90, 35, 100];
      T = [D(:,1:6), NaN(10,1), D(:,7), 3 * D(:,2), D(:,8:11), NaN(10,2)];
    case 'slot'
      ## ISO 2009:1994: n nom, t min, range, tip
      D = [0.4, 0.32, 2.5, 16, 0.4, 2.5;
           0.5, 0.4, 3, 20, 0.5, 3;
           0.6, 0.5, 4, 25, 0.6, 3.5;
           0.8, 0.6, 5, 30, 0.8, 4;
           1, 0.9, 6, 35, 1, 5.5;
           1.2, 1, 6, 40, 1.2, 6.5;
           1.2, 1.1, 8, 50, 1.2, 6.5;
           1.6, 1.2, 8, 60, 1.6, 8;
           2, 1.8, 10, 80, 2, 12;
           2.5, 2, 12, 80, 2.5, 14];
      T = [C(:,1:2), H(:,1:2), D(:,1:2), NaN(10,1), H(:,3), 2 * C(:,2), ...
           H(:,4:5), D(:,3:6)];
    case {'crossH', 'crossZ'}
      ## ISO 7046-1:1994, deep series: recess number, m and penetration min
      ## of H and of Z, range
      D = [0, 1.6, 0.6, 1.6, 0.7, 3, 16;
           0, 1.9, 0.9, 1.9, 0.95, 3, 20;
           1, 2.9, 1.4, 2.8, 1.48, 3, 25;
           1, 3.2, 1.7, 3, 1.76, 4, 30;
           2, 4.4, 1.9, 4.1, 1.75, 5, 35;
           2, 4.6, 2.1, 4.4, 2.06, 5, 40;
           2, 5.2, 2.7, 4.9, 2.6, 6, 50;
           3, 6.8, 3, 6.6, 3, 8, 60;
           4, 8.9, 4, 8.8, 4.15, 10, 60;
           4, 10, 5.1, 9.8, 5.19, 12, 60];
      z = 2 * strcmp (drive, 'crossZ');
      T = [C(:,1:2), H(:,1:2), D(:,1), D(:,3+z), D(:,2+z), H(:,3), ...
           2 * C(:,2), H(:,4:5), D(:,6:7), NaN(10,2)];
    case 'hexalobular'
      ## ISO 14581:2013: socket number, t min, range; the head and thread
      ## form are ISO 2009's
      D = [6, 0.51, 3, 20;
           8, 0.66, 3, 25;
           10, 0.7, 4, 30;
           15, 1.16, 5, 35;
           20, 1.14, 5, 40;
           25, 1.12, 6, 50;
           30, 1.39, 8, 60;
           45, 2.15, 10, 60;
           50, 2.41, 12, 60];
      k = 2:10;
      T = [C(k,1:2), H(k,1:2), D(:,1:2), NaN(9,1), H(k,3), 2 * C(k,2), ...
           H(k,4:5), D(:,3:4), NaN(9,2)];
  endswitch

endfunction

## The thread lengths of screws of size rows h and lengths l by their
## standard, a column
function b = tableform (h, l)

  b = l;
  part = l > h(:,11);
  b(part) = h(part,10);

endfunction

## The designations, standards and threads of screws of size rows h,
## pitches P, lengths l, thread lengths b, drives DRIVE and classes CLASS,
## columns; character vectors for one
function [name, standard, thread] = designate (h, P, l, b, drive, class)

  n = numel (l);
  if (ischar (drive))
    drive = repmat ({drive}, n, 1);
  endif
  if (ischar (class))
    class = repmat ({class}, n, 1);
  endif
  drive = drive(:);
  class = class(:);
  hex = strcmp (drive, 'hexsocket');
  slot = strcmp (drive, 'slot');
  lobe = strcmp (drive, 'hexalobular');
  cross = ! (hex | slot | lobe);
  series = [2.5, 3:6, 8, 10, 12, 14, 16, 20:5:80];
  inseries = ismember (l, series);
  inseries(hex) = ismember (l(hex), [8, 10, 12, 16, 20:5:70, 80, 90, 100]);
  iso = (P == h(:,2) & inseries & l >= h(:,12) & l <= h(:,13)
         & b == tableform (h, l));
  part1 = strcmp (class, '4.8');
  part2 = (ismember (class, {'8.8', 'CU2', 'CU3', 'brass'})
           | ! cellfun (@isempty, regexp (class, '^A\d', 'once')));
  standard = repmat ({''}, n, 1);
  standard(iso & hex) = {'ISO 10642'};
  standard(iso & slot) = {'ISO 2009'};
  standard(iso & lobe) = {'ISO 14581'};
  standard(iso & cross & part1) = {'ISO 7046-1'};
  standard(iso & cross & part2 & h(:,1) >= 2) = {'ISO 7046-2'};
  denom = repmat ({'Countersunk flat head screw'}, n, 1);
  denom(hex) = {'Hexagon socket countersunk head screw'};
  denom(lobe) = {'Hexalobular socket countersunk flat head screw'};
  denom(strcmp (standard, 'ISO 7046-2')) = {'Countersunk head screw'};
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
    T = [sizes('slot')(:,1:2); sizes('hexsocket')(:,1:2)];
    if (isnan (P) && any (T(:,1) == d))
      P = T(find (T(:,1) == d, 1),2);
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
    error (strcat ("parts.screw.countersunk: no %scountersunk head", ...
                   " screw%s in the catalogue."), what, how);
  endif

endfunction

## Every entry of the catalogue, sorted by size, then length
function E = entries ()

  ## BEGIN generated by tools/reyher_tables.py countersunk
  ## REYHER article, printed page, drive, class, finish; then each
  ## size with its lengths
  A = {'02009.004', 225, 'slot', 'steel', 'plain', {
         1.6, [3, 4, 5, 6, 8, 10, 12, 16]};
       '02009.400', 225, 'slot', '4.8', 'plain', {
         2, [4, 5, 6, 8, 10, 12, 16, 20];
         2.5, [4, 5, 6, 8, 10, 12, 16];
         3, [4, 5, 6, 8, 10, 12, 16, 20, 25, 30, 40];
         4, [5, 6, 8, 10, 12, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 60];
         5, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50];
         6, [10, 12, 16, 20, 25, 30, 35, 45, 50, 55, 60, 65, 70, 80, 100];
         8, [10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, ...
             100];
         10, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100]};
       '02009.410', 226, 'slot', '4.8', 'zinc plated', {
         2, [4, 5, 6, 8, 10, 12, 16, 20];
         2.5, [4, 5, 6, 8, 10, 12, 16, 20, 25, 30];
         3, [4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, ...
             55, 60];
         4, [5, 6, 8, 10, 12, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, ...
             60, 65, 70, 80, 90, 100];
         5, [6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, ...
             60, 70, 80, 90, 100];
         6, [8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             70, 80, 90, 100];
         8, [10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, ...
             90, 100];
         10, [16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100]};
       '02009.920', 522, 'slot', 'A2', 'plain', {
         1.6, [3, 4, 5, 6, 8, 10];
         2, [3, 4, 5, 6, 8, 10, 12, 16, 18];
         2.5, [4, 5, 6, 8, 10, 12, 14, 16, 20, 25];
         3, [4, 5, 6, 8, 10, 12, 14, 16, 20, 22, 25, 30, 35, 40, 45, 50, ...
             60];
         3.5, [8, 10, 12, 16];
         4, [8, 10, 12, 14, 16, 20, 25, 30, 35, 40, 50];
         5, [6, 8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, 60, 65, ...
             70, 80, 90, 100];
         6, [8, 10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, ...
             80, 90, 100, 110, 120, 130, 140, 160];
         8, [12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100, ...
             110];
         10, [16, 20, 25, 30, 35, 40, 50, 60, 70, 80, 90, 100, 120, 130, ...
             140]};
       '02009.940', 523, 'slot', 'A4', 'plain', {
         2, [3, 4, 5, 6, 8, 10, 12, 16, 20];
         2.5, [4, 5, 6, 8, 10, 12, 16, 20];
         3, [4, 5, 6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50];
         4, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60];
         5, [6, 8, 10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80, ...
             90, 100];
         6, [8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, ...
             70, 80, 90, 100, 110, 120];
         8, [12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100];
         10, [16, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90, 100, 110, ...
             120, 130, 140]};
       '02009.704', 634, 'slot', 'brass', 'plain', {
         1.6, [4, 6, 10]};
       '02009.700', 634, 'slot', 'brass', 'plain', {
         2, [4, 5, 6, 8, 10, 12, 16, 20];
         2.5, [4, 5, 6, 8, 10, 12, 16, 18, 20];
         3, [4, 5, 6, 8, 10, 12, 16, 18, 20, 25, 30, 35, 40];
         4, [5, 6, 8, 10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50];
         5, [8, 10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 60];
         6, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80];
         8, [12, 16, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80];
         10, [16, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80]};
       '02009.730', 635, 'slot', 'brass', 'nickel plated', {
         3, [10, 16, 20, 30];
         4, [10, 16, 20, 30];
         5, [10, 16, 20];
         6, [10, 16, 20]};
       '02009.600', 635, 'slot', 'PA', 'plain', {
         3, [6, 8, 10, 12, 16, 20];
         4, [10, 12, 16, 20, 25, 30];
         5, [10, 12, 16, 20, 25];
         6, [10, 12, 16, 20, 25, 30];
         8, [16, 20, 25, 30, 40]};
       '07046.404', 328, 'crossH', '4.8', 'plain', {
         2.5, [6, 8];
         3, [5, 6, 8, 10, 12, 16, 20, 25];
         4, [6, 8, 10, 12, 16, 20, 25, 30];
         5, [8, 10, 12, 16, 20, 25, 40];
         6, [10, 12, 16, 20, 25, 30, 35];
         8, [16, 20, 25, 30]};
       '07046.414', 328, 'crossH', '4.8', 'zinc plated', {
         2, [5, 6, 8, 10, 12, 16, 20];
         2.5, [4, 5, 6, 8, 10, 12, 16, 20];
         3, [4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, ...
             50];
         4, [5, 6, 8, 10, 12, 14, 16, 18, 20, 25, 28, 30, 35, 40, 45, 50, ...
             60, 70, 80, 90];
         5, [6, 8, 10, 12, 14, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, ...
             80, 90];
         6, [8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, ...
             80];
         8, [12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100];
         10, [16, 20, 25, 30, 40, 45, 50, 60]};
       '07046.415', 329, 'crossZ', '4.8', 'zinc plated', {
         2.5, [4, 5, 6, 8, 10, 12];
         3, [4, 5, 6, 8, 10, 12, 16, 20, 25];
         4, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50];
         5, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80];
         6, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60]};
       '07046.924', 562, 'crossH', 'A2', 'plain', {
         1.6, [3, 4, 5, 6, 8, 10, 12, 16];
         2, [3, 4, 5, 6, 8, 10, 12, 14, 16, 20];
         2.5, [3, 4, 5, 6, 8, 10, 12, 16, 20, 25];
         3, [4, 5, 6, 8, 10, 12, 16, 20, 22, 25, 30, 35, 40, 45, 50];
         4, [5, 6, 8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, 60];
         5, [6, 8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, ...
             70, 80, 90, 100];
         6, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, ...
             100, 110, 120];
         8, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80];
         10, [12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60]};
       '07046.927', 563, 'crossZ', 'A2', 'plain', {
         2, [3, 4, 5, 6, 10, 12, 14, 16, 20];
         2.5, [3, 4, 5, 6, 8, 10, 12, 16, 20, 25];
         3, [4, 5, 6, 8, 10, 12, 14, 16, 22, 25, 30, 40, 50];
         4, [5, 6, 8, 10, 12, 14, 16, 20, 22, 25, 30, 40, 45, 60];
         5, [8, 10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, ...
             90, 100];
         6, [8, 10, 12, 16, 20, 25, 30, 40, 50, 60, 70, 80, 90, 100, 110, ...
             120];
         8, [10, 12, 16, 20, 25, 30, 40, 45, 50, 55, 60, 70, 80];
         10, [16, 25, 35, 40]};
       '07046.945', 564, 'crossH', 'A4', 'plain', {
         1.6, [3, 4, 5, 10, 16];
         2, [3, 4, 5, 6, 8, 10, 12, 16, 20];
         2.5, [3, 4, 5, 6, 8, 10, 12, 14, 16, 20, 25];
         3, [4, 5, 6, 8, 10, 12, 14, 16, 20, 25, 30, 35, 40];
         4, [5, 6, 8, 10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60];
         5, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60];
         6, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90];
         8, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90];
         10, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80]};
       '10642.800', 389, 'hexsocket', '08.8', 'plain', {
         3, [6, 8, 10, 12, 16, 18, 20, 22, 25, 30];
         4, [6, 8, 10, 12, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50];
         5, [6, 8, 10, 12, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             70];
         6, [8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             70, 80];
         8, [10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             70, 80, 90, 100, 110, 120, 130, 140, 150, 160];
         10, [12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, ...
             100, 110, 120, 130, 140, 150, 160];
         12, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100, 110, ...
             120, 130, 140, 150, 160, 180, 200];
         14, [30, 35, 40, 45, 50, 55, 60, 70, 80];
         16, [20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100, 110, ...
             120, 130, 140, 150, 160, 180, 200];
         20, [40, 45, 50, 60, 65, 70, 80, 90, 100, 110, 120, 130, 140, ...
             180]};
       '10642.810', 391, 'hexsocket', '08.8', 'zinc plated', {
         3, [5, 6, 8, 10, 12, 16, 18, 20, 25, 30];
         4, [6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50];
         5, [6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, ...
             60, 70, 80];
         6, [8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             65, 70, 75, 80, 90, 100, 120];
         8, [10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             65, 70, 80, 90, 100, 110, 120, 130, 140, 150];
         10, [12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, ...
             100, 110, 120, 130, 140, 150, 160];
         12, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100, 110, ...
             120, 130, 140, 150, 160, 180, 200];
         14, [30, 35, 40, 45, 50, 55, 60];
         16, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100, 110, ...
             120, 130, 140, 150, 160, 180, 200];
         20, [35, 40, 45, 50, 55, 60, 70, 80, 90, 100, 110, 120, 130, 140, ...
             150, 160, 180, 200]};
       '10642.316', 392, 'hexsocket', '08.8', 'zinc plated 8 TLP', {
         4, [10, 12, 16];
         5, [10, 12, 16, 20];
         6, [10, 12, 16, 20, 25];
         8, [12, 16, 20, 25, 30, 35, 40];
         10, [12, 20, 25, 30, 35, 40];
         12, [20, 25, 30, 35, 40, 50]};
       '10642.100', 392, 'hexsocket', '010.9', 'plain', {
         3, [6, 8, 10, 12, 16, 20, 25, 30];
         4, [6, 8, 10, 12, 14, 16, 20, 25, 30, 35, 40];
         5, [8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50];
         6, [8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             70, 80];
         8, [10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             70, 80, 90, 100, 120, 130, 140, 160];
         10, [12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, ...
             100, 110, 120, 130, 140, 150];
         12, [20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100, 110, ...
             120, 130, 140, 160, 180, 200];
         14, [30, 35, 40, 45, 50, 55, 60, 80];
         16, [20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100, 110, ...
             120, 130, 140, 180];
         20, [30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100, 110, 120, 130, ...
             140, 150, 160, 170, 180, 200, 220, 240]};
       '10642.110', 393, 'hexsocket', '010.9', 'zinc plated', {
         3, [6, 8, 10, 12, 16, 20, 25, 30];
         4, [6, 8, 10, 12, 14, 16, 20, 25, 30, 35, 40];
         5, [8, 10, 12, 14, 16, 20, 25, 30, 35, 40, 45];
         6, [8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             70, 80];
         8, [10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80];
         10, [16, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90, 100, 110];
         12, [20, 25, 30, 35, 40, 45, 50, 60, 65, 70, 80, 90];
         16, [25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100, 110];
         20, [30, 35, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130]};
       '10642.397', 394, 'hexsocket', '010.9', 'flZn/TL480h', {
         6, [10];
         8, [20, 22, 25, 30, 35, 40, 45, 50, 60];
         10, [20, 25, 30, 35, 40, 45, 50, 60];
         12, [20, 25, 30, 35, 40, 45, 50, 60, 70, 80];
         16, [30, 35, 40, 45, 50, 60, 70, 80, 100]};
       '10642.920', 587, 'hexsocket', 'A2', 'plain', {
         3, [4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 25, 30, 35];
         4, [5, 6, 8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50];
         5, [6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 60, ...
             70];
         6, [8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, ...
             75, 80];
         8, [10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, ...
             80, 90, 100, 110, 120];
         10, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100, 110, ...
             120, 130];
         12, [20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100, 110, ...
             120, 130, 140];
         16, [25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100, 110, ...
             120, 130, 140, 150];
         20, [40, 45, 50, 55, 60, 70, 80, 90, 100, 110, 120, 130, 140, ...
             150]};
       '10642.940', 588, 'hexsocket', 'A4', 'plain', {
         3, [6, 8, 10, 12, 14, 16, 18, 20, 25, 30];
         4, [6, 8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50];
         5, [6, 8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60];
         6, [8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, ...
             80, 90, 100];
         8, [10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, ...
             80, 90, 100, 120];
         10, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100, 120];
         12, [20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100, 110, ...
             120];
         16, [25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100, 110, 120, ...
             130, 140, 150];
         20, [40, 45, 50, 55, 60, 70, 80, 90, 100, 110, 120, 130, 140, ...
             150]};
       '14581.410', 403, 'hexalobular', '04.8', 'zinc plated', {
         3, [4, 5, 6, 8, 10, 12, 16, 20, 25];
         4, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40];
         5, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50];
         6, [10, 12, 16, 20, 25, 30, 35, 40, 50, 60]};
       '14581.810', 403, 'hexalobular', '08.8', 'zinc plated', {
         4, [8, 10, 12, 16, 20, 25];
         5, [8, 10, 12, 16, 20, 25];
         6, [10, 12, 16, 20, 25, 30, 35];
         8, [16, 20, 25, 30]};
       '14581.920', 589, 'hexalobular', 'A2', 'plain', {
         2, [3, 4, 5, 6, 8];
         2.5, [4, 5, 6, 8];
         3, [4, 5, 6, 8];
         4, [5, 6, 8];
         5, [6, 8];
         6, [8]};
       '14581.940', 589, 'hexalobular', 'A4', 'plain', {
         3, [5, 6, 8, 10];
         4, [8, 10, 12, 16, 20];
         5, [10, 12, 16, 20, 25, 30];
         6, [10, 16, 20, 25, 30, 35, 40, 45, 50];
         8, [16, 20, 25, 30, 35, 40, 45, 50]};
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
  class = A(a,4);

  h = NaN (n, 15);
  for p = {'hexsocket', 'slot', 'crossH', 'crossZ', 'hexalobular'}
    T = sizes (p{1});
    is = strcmp (drive, p{1});
    [~, k] = ismember (d(is), T(:,1));
    h(is,:) = T(k,:);
  endfor
  b = tableform (h, l);
  [name, standard] = designate (h, h(:,2), l, b, drive, class);
  dkt = h(:,1) + 2 * h(:,4);
  tool = cell (n, 1);
  is = strcmp (drive, 'hexsocket');
  tool(is) = arrayfun (@(x) sprintf ("%g", x), h(is,5), ...
                       'UniformOutput', false);
  is = strcmp (drive, 'slot');
  tool(is) = arrayfun (@(x, y) sprintf ("%g x %g", x, y), h(is,14), ...
                       h(is,15), 'UniformOutput', false);
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
  E = table (name, standard, d, h(:,2), l, b, h(:,3), dkt, h(:,4), drive, ...
             tool, class, A(a,5), maker, A(a,1), source(a));
  E.Properties.VariableNames = {'designation', 'standard', 'd', 'P', 'l', ...
                                'b', 'dk', 'dkt', 'k', 'drive', 'tool', ...
                                'class', 'finish', 'maker', 'article', ...
                                'source'};
  E.Properties.VariableUnits = {'', '', 'mm', 'mm', 'mm', 'mm', 'mm', 'mm', ...
                                'mm', '', '', '', '', '', '', ''};
  E.Properties.VariableDescriptions = {...
    'designation of ISO 8991, without the property class', ...
    'standard when its table defines the screw', ...
    'nominal diameter', ...
    'pitch, coarse', ...
    'nominal length, the head included', ...
    'length of thread from the end', ...
    'actual head diameter, largest', ...
    ['theoretical head diameter, where the cone meets', ' the top'], ...
    'head height, largest', ...
    'hexsocket, slot, crossH, crossZ or hexalobular', ...
    'key, bit or tip', ...
    'property class or material, as REYHER prints it', ...
    'finish as the maker names it', ...
    'maker', ...
    "maker's article number", ...
    'catalogue and page the article was read from'};
  E.Properties.Description = ['Countersunk head screws, ISO 10642, 2009,', ...
                              ' 7046 and 14581'];
  E = sortrows (E, {'d', 'l'});

endfunction

function S = shape (d, P, L, B, drive, class, detailed)

  T = sizes (drive);
  h = T(T(:,1) == d,:);
  if (isempty (h))
    std = struct ('hexsocket', 'ISO 10642', 'slot', 'ISO 2009', ...
                  'crossH', 'ISO 7046', 'crossZ', 'ISO 7046', ...
                  'hexalobular', 'ISO 14581');
    error ("parts.screw.countersunk: %s defines no M%g head.", ...
           std.(drive), d);
  endif
  dk = h(3);
  k = h(4);
  if (isnan (P))
    P = h(2);
  endif
  if (isempty (B))
    B = tableform (h, L);
  elseif (! isnumeric (B) || ! isreal (B) || ! isscalar (B) || B <= 0
          || (B > L - k && B != L))
    error (strcat ("parts.screw.countersunk: 'ThreadLength' must be a", ...
                   " length from 0 to L - k, or L."));
  endif
  [name, ~, tname] = designate (h, P, L, B, drive, class);

  ## The 90 degree cone from the shank at z = -k to the theoretical
  ## diameter at the top, cut by the cylinder dk
  zl = (dk - d) / 2 - k;
  if (detailed)
    q = h(8) * tand (22.5);
    x = d / 2 + q * sind (45);
    z = -k + q * cosd (45);
    U = [0, -L, 0; d / 2, -L, 0; d / 2, -k - q, -tand(11.25); x, z, 0];
  else
    U = [0, -L, 0; d / 2, -L, 0; d / 2, -k, 0];
  endif
  R = geom.Region ([U; dk / 2, zl, 0; dk / 2, 0, 0; 0, 0, 0]);
  R.UCS = geom.UCS ([0, -1, 0], [0, 0, 0]);
  S = solid.revolve (R);
  if (detailed)
    if (B == L)
      B = L - k - h(9);
    endif
    S = thread (S, [0, 0, -L], tname, B, 'Direction', [0, 0, 1], ...
                'Custom', true);
  endif
  switch (drive)
    case 'hexsocket'
      S = parts.screw.__recess__ (S, drive, h(5:6), 0, detailed);
    case 'slot'
      S = parts.screw.__recess__ (S, 'slot', [h(5), dk, h(6)], 0);
    case {'crossH', 'crossZ'}
      S = parts.screw.__recess__ (S, drive, h([5, 7, 6]), 0, detailed);
    case 'hexalobular'
      S = parts.screw.__recess__ (S, drive, h(5:6), 0, detailed);
  endswitch
  S.Name = name;

endfunction

%!test  # the catalogue, every article in every size and length
%! C = parts.screw.countersunk ('data');
%! assert_equal (height (C), 2254);
%!test  # sorted by size, then length
%! C = parts.screw.countersunk ('data');
%! assert_equal (issorted ([C.d, C.l], 'rows'), true);
%!test  # an article as REYHER lists it
%! C = parts.screw.countersunk ('data', 'M5', 20);
%! E = C(strcmp (C.article, '10642.800'),:);
%! assert_equal ([E.designation, E.class, E.finish, E.tool, E.drive], ...
%!               {['Hexagon socket countersunk head screw', ...
%!                 ' ISO 10642 - M5 x 20'], '08.8', 'plain', '3', ...
%!                'hexsocket'});
%!test  # its sizes
%! C = parts.screw.countersunk ('data', 'M5', 20);
%! E = C(strcmp (C.article, '10642.800'),:);
%! assert_equal ([E.d, E.P, E.l, E.b, E.dk, E.dkt, E.k], ...
%!               [5, 0.8, 20, 20, 10.07, 11.2, 3.1], 1e-12);
%!test  # each variable carries its unit and description
%! C = parts.screw.countersunk ('data', 'M5', 20);
%! assert_equal (C.Properties.VariableUnits([3, 8]), {'mm', 'mm'});
%! assert_equal (C.Properties.VariableDescriptions{7}, ...
%!               'actual head diameter, largest');
%!test  # without 'Drive' every drive comes
%! C = parts.screw.countersunk ('data', 'M5', 20);
%! assert_equal (unique (C.drive)', ...
%!               {'crossH', 'crossZ', 'hexalobular', 'hexsocket', ...
%!                'slot'});
%!test  # a slotted screw, ISO 2009
%! C = parts.screw.countersunk ('data', 'M5', 20, 'Drive', 'slot');
%! assert_equal ([C.designation(1), C.tool(1)], ...
%!               {'Countersunk flat head screw ISO 2009 - M5 x 20', ...
%!                '1.2 x 6.5'});
%! assert_equal ([C.dk(1), C.dkt(1)], [9.3, 10.4], 1e-12);
%!test  # a cross recess takes its part of ISO 7046 by its class
%! C = parts.screw.countersunk ('data', 'M5', 20, 'Drive', 'phillips');
%! assert_equal (unique (C.designation)', ...
%!               {['Countersunk flat head screw ISO 7046-1', ...
%!                 ' - M5 x 20 - H'], ...
%!                'Countersunk head screw ISO 7046-2 - M5 x 20 - H'});
%!test  # a hexalobular screw, ISO 14581
%! C = parts.screw.countersunk ('data', 'M5', 20, 'Drive', 'torx');
%! assert_equal ([C.designation(1), C.tool(1)], ...
%!               {['Hexalobular socket countersunk flat head screw', ...
%!                 ' ISO 14581 - M5 x 20'], 'T25'});
%!test  # ISO 10642 threads M14 x 70 b
%! C = parts.screw.countersunk ('data', 'M14', 70);
%! assert_equal (unique (C.b), 40);
%!test  # ISO 10642 M14 head diameter
%! C = parts.screw.countersunk ('data', 'M14', 30);
%! assert_equal (unique (C.dk), 28.31);
%!test  # a length past the table is custom
%! C = parts.screw.countersunk ('data', 'M8', 90, 'Drive', 'allen');
%! assert_equal (unique (C.designation), ...
%!               {'Hexagon socket countersunk head screw M8 x 90 x 28'});
%!testif ; exist ('__occt__') == 3  # cone, edge, shank and socket
%! S = parts.screw.countersunk ('solid', 'M5', 20);
%! zl = -0.565;
%! h = zl + 3.1;
%! V = pi * (6.25 * 16.9 + h / 3 * (6.25 + 2.5 * 5.035 + 5.035 ^ 2) ...
%!           - 5.035 ^ 2 * zl) - sqrt (3) / 2 * 9 * 1.9;
%! assert_equal (volume (S), V, 1e-6);
%!testif ; exist ('__occt__') == 3  # the top of the head on the plane
%! S = parts.screw.countersunk ('solid', 'M5', 20);
%! assert_equal (bbox (S), [-5.035, -5.035, -20, 5.035, 5.035, 0], 1e-6);
%!testif ; exist ('__occt__') == 3  # ISO 10642 M14 head
%! S = parts.screw.countersunk ('solid', 'M14', 30);
%! assert_equal (bbox (S), [-14.155, -14.155, -30, 14.155, 14.155, 0], ...
%!               1e-6);
%!testif ; exist ('__occt__') == 3  # ISO 7046-1 by default
%! S = parts.screw.countersunk ('solid', 'M5', 20, 'Drive', 'crossZ');
%! assert_equal (S.Name, ...
%!               {'Countersunk flat head screw ISO 7046-1 - M5 x 20 - Z'});
%!testif ; exist ('__occt__') == 3  # ISO 7046-2 by 'Class'
%! S = parts.screw.countersunk ('solid', 'M5', 20, 'Drive', 'crossZ', ...
%!                              'Class', 'A2');
%! assert_equal (S.Name, {'Countersunk head screw ISO 7046-2 - M5 x 20 - Z'});
%!testif ; exist ('__occt__') == 3  # a class of neither part is custom
%! S = parts.screw.countersunk ('solid', 'M5', 20, 'Drive', 'crossH', ...
%!                              'Class', '10.9');
%! assert_equal (S.Name, {'Countersunk flat head screw M5 x 20 - H'});
%!testif ; exist ('__occt__') == 3  # custom by its thread length
%! S = parts.screw.countersunk ('solid', 'M5', 20, 'ThreadLength', 10);
%! assert_equal (S.Name, ...
%!               {'Hexagon socket countersunk head screw M5 x 20 x 10'});
%!testif ; exist ('__occt__') == 3  # detailed: fillet, socket, thread
%! S = parts.screw.countersunk ('solid', 'M5', 20, 'Detailed', true);
%! assert_equal (isvalid (S), true);
%!testif ; exist ('__occt__') == 3  # detailed cross recess
%! S = parts.screw.countersunk ('solid', 'M5', 20, 'Drive', 'crossH', ...
%!                              'Detailed', true);
%! assert_equal (isvalid (S), true);

%!error<parts.screw.countersunk: MODE must be 'data' or 'solid'.> ...
%! parts.screw.countersunk ()
%!error<parts.screw.countersunk: a solid needs a NAME and a length L.> ...
%! parts.screw.countersunk ('solid', 'M5')
%!error<parts.screw.countersunk: L must be a positive length.> ...
%! parts.screw.countersunk ('solid', 'M5', 0)
%!error<parts.screw.countersunk: NAME must name a metric thread, such as 'M5' or 'M5x0.5'.> ...
%! parts.screw.countersunk ('data', 'M5y')
%!error<parts.screw.countersunk: Name/Value arguments must come in pairs.> ...
%! parts.screw.countersunk ('data', 'M5', 'Maker')
%!error<parts.screw.countersunk: option names must be character vectors.> ...
%! parts.screw.countersunk ('data', 5, 'Maker')
%!error<parts.screw.countersunk: unknown option 'Point'.> ...
%! parts.screw.countersunk ('data', 'Point', 'flat')
%!error<parts.screw.countersunk: 'Drive' must be a character vector.> ...
%! parts.screw.countersunk ('data', 'Drive', 1)
%!error<parts.screw.countersunk: unknown drive 'cross'.> ...
%! parts.screw.countersunk ('data', 'Drive', 'cross')
%!error<parts.screw.countersunk: 'Class' applies to 'solid' only.> ...
%! parts.screw.countersunk ('data', 'Class', '4.8')
%!error<parts.screw.countersunk: 'Class' must be a character vector.> ...
%! parts.screw.countersunk ('solid', 'M5', 20, 'Class', 4.8)
%!error<parts.screw.countersunk: 'Class' applies to a cross recess only.> ...
%! parts.screw.countersunk ('solid', 'M5', 20, 'Class', '8.8')
%!error<parts.screw.countersunk: 'Maker' applies to 'data' only.> ...
%! parts.screw.countersunk ('solid', 'M5', 20, 'Maker', 'REYHER')
%!error<parts.screw.countersunk: 'Maker' must be a character vector.> ...
%! parts.screw.countersunk ('data', 'Maker', 1)
%!error<parts.screw.countersunk: 'Detailed' applies to 'solid' only.> ...
%! parts.screw.countersunk ('data', 'Detailed', true)
%!error<parts.screw.countersunk: 'Detailed' must be true or false.> ...
%! parts.screw.countersunk ('solid', 'M5', 20, 'Detailed', 'yes')
%!error<parts.screw.countersunk: 'Detailed' must be true or false.> ...
%! parts.screw.countersunk ('solid', 'M5', 20, 'Detailed', 1)
%!error<parts.screw.countersunk: 'ThreadLength' applies to 'solid' only.> ...
%! parts.screw.countersunk ('data', 'ThreadLength', 10)
%!error<parts.screw.countersunk: 'ThreadLength' must be a length from 0 to L - k, or L.> ...
%! parts.screw.countersunk ('solid', 'M5', 20, 'ThreadLength', 18)
%!error<parts.screw.countersunk: ISO 10642 defines no M2 head.> ...
%! parts.screw.countersunk ('solid', 'M2', 10)
%!error<parts.screw.countersunk: ISO 10642 defines no M24 head.> ...
%! parts.screw.countersunk ('solid', 'M24', 60)
%!error<parts.screw.countersunk: ISO 2009 defines no M12 head.> ...
%! parts.screw.countersunk ('solid', 'M12', 30, 'Drive', 'slot')
%!error<parts.screw.countersunk: no M1.4 countersunk head screw in the catalogue.> ...
%! parts.screw.countersunk ('data', 'M1.4')
%!error<parts.screw.countersunk: no M5 x 21 countersunk head screw with a slot drive by NSK in the catalogue.> ...
%! parts.screw.countersunk ('data', 'M5', 21, 'Drive', 'slot', 'Maker', 'NSK')
