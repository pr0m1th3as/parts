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
## @deftypefn  {parts} {@var{C} =} parts.screw.raisedcountersunk (@qcode{'data'})
## @deftypefnx {parts} {@var{C} =} parts.screw.raisedcountersunk (@qcode{'data'}, @var{NAME})
## @deftypefnx {parts} {@var{C} =} parts.screw.raisedcountersunk (@qcode{'data'}, @var{NAME}, @var{L})
## @deftypefnx {parts} {@var{S} =} parts.screw.raisedcountersunk (@qcode{'solid'}, @var{NAME}, @var{L})
## @deftypefnx {parts} {@dots{} =} parts.screw.raisedcountersunk (@dots{}, @var{Name}, @var{Value})
##
## Raised countersunk head screws, ISO 2010, 7047 and 14584.
##
## @code{@var{C} = parts.screw.raisedcountersunk (@qcode{'data'})} returns
## every raised countersunk head screw in the catalogue as a struct array,
## one entry for each maker's article in each size and length, sorted by
## size and length.
## @code{@var{C} = parts.screw.raisedcountersunk (@qcode{'data'}, @var{NAME})}
## returns those of the thread @var{NAME}, such as @qcode{'M5'}, and
## @code{@var{C} = parts.screw.raisedcountersunk (@qcode{'data'}, @var{NAME},
## @var{L})} those of nominal length @var{L} too: every article sold as that
## screw, each with its drive, property class or material and finish.
## Nothing is built.  The catalogue holds slotted and cross recessed screws
## only.
##
## @code{@var{S} = parts.screw.raisedcountersunk (@qcode{'solid'}, @var{NAME},
## @var{L})} builds the screw as a @code{solid.Shape} whether or not anyone
## sells it: any thread of a size its standard defines, any pitch, any
## length.  The edge of the head, where the cone meets the dome, lies on the
## @math{xy} plane, flush with the surface it is sunk into; the dome rises
## @var{f} above it and the screw runs down to @math{z} = -@var{L}: the
## nominal length includes the cone, not the dome.  A hexalobular socket
## has two lobes on the @math{x} axis, a slot lies along it and a cross
## recess's wings on the @math{x} and @math{y} axes.  @code{@var{S}.Name}
## holds the screw's designation.
##
## Name/Value pairs:
##
## @table @asis
## @item @qcode{'Drive'}
## The drive, which selects the standard: @qcode{'hexalobular'} (alias
## @qcode{'torx'}), ISO 14584, the default; @qcode{'slot'}, ISO 2010;
## @qcode{'crossH'} (alias @qcode{'phillips'}) or @qcode{'crossZ'} (alias
## @qcode{'pozidriv'}), ISO 7047.  For @qcode{'data'} it keeps that drive's
## screws only; without it every drive comes.
##
## @item @qcode{'Maker'}
## For @qcode{'data'}: only that maker's articles, such as
## @qcode{'REYHER'}, in any case.
##
## @item @qcode{'ThreadLength'}
## For @qcode{'solid'}: the length of thread @var{b} from the end of the
## shank, from 0 to @var{L} - @var{k}, or @var{L} to thread it to the
## head.  Without it the screw follows its standard: threaded to the head
## up to 30 long for M3 and smaller and 45 for the rest, longer ones
## threaded @var{b} min, 25 and 38.
##
## @item @qcode{'Detailed'}
## For @qcode{'solid'}: @code{true} also builds the fillet of radius
## @var{r} between the cone and the shank, the true drive
## (@code{parts.screw.__recess__}) and the thread, cut by
## @code{solid.Shape.thread}; a screw threaded to the head is threaded to
## within @var{k} + 2@var{P} of the edge.  By default (@code{false}) the
## shank is a plain cylinder of diameter @var{d} and the drive the simple
## one.  The end is left flat, as rolled.
## @end table
##
## The head is the 90 degree cone of its standard, which reaches the
## theoretical diameter @var{dkt} at the edge, cut by a cylinder of the
## actual head diameter @var{dk}, with a dome on top that springs from
## @var{dk} and rises @var{f}; its radius, which the standards give as
## approximate, follows from the two.  Drives are cut from the top of the
## dome, from which their depths are measured.
##
## Each entry is a struct with these fields, lengths in millimetres:
##
## @multitable @columnfractions 0.16 0.84
## @item @code{designation} @tab the designation of ISO 8991, as in
## @qcode{'Countersunk raised head screw ISO 7047 - M5 x 20 - H'}, without
## the property class, a cross recess's type after the size
## @item @code{standard} @tab the standard when its table defines the screw,
## else empty: such a screw is custom
## @item @code{d} @tab nominal diameter
## @item @code{P} @tab pitch, coarse
## @item @code{l} @tab nominal length, from the edge of the head
## @item @code{b} @tab length of thread from the end, @var{l} when threaded
## to the head
## @item @code{dk} @tab actual head diameter, largest
## @item @code{dkt} @tab theoretical head diameter, where the cone meets the
## plane of the edge, @var{d} + 2@var{k}: the diameter a countersink is
## made to
## @item @code{k} @tab height of the cone, largest
## @item @code{f} @tab height of the dome above the edge, approximate
## @item @code{drive} @tab @qcode{'slot'}, @qcode{'crossH'},
## @qcode{'crossZ'} or @qcode{'hexalobular'}
## @item @code{tool} @tab the bit or tip, as @qcode{'PH2'}, @qcode{'T25'}
## or @qcode{'1.2 x 6.5'}
## @item @code{class} @tab property class or material
## @item @code{finish} @tab the finish as the maker names it
## @item @code{maker} @tab the maker
## @item @code{article} @tab the maker's article number
## @item @code{source} @tab the catalogue and page the article was read from
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
## pages 227, 329 and 330 (steel), 524, 525, 564 and 565 (stainless steel),
## 635 and 636 (brass): every article in sizes its standard defines.
##
## ISO 2010:1994 and ISO 7047:1994, heads, recesses, thread lengths and
## lengths, read in IS 8911:2005 and IS 7486:2005.  ISO 14584:2011, read in
## its official preview, whose sockets agree with GOST R ISO 14584-2012 and
## fasten.it's reproduction; its head is ISO 7047's.  Cross recesses to
## ISO 4757 and hexalobular sockets to ISO 10664; screwdriver tips from
## Wera's assignment table to ISO 2380-1.
##
## @seealso{parts.screw.countersunk, parts.screw.pan}
## @end deftypefn

function OUT = raisedcountersunk (MODE, varargin)

  if (nargin < 1 || ! ischar (MODE)
      || ! any (strcmp (MODE, {'data', 'solid'})))
    error ("parts.screw.raisedcountersunk: MODE must be 'data' or 'solid'.");
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
        error ("parts.screw.raisedcountersunk: L must be a positive length.");
      endif
    endif
  endif
  if (strcmp (MODE, 'solid') && isempty (L))
    error (strcat ("parts.screw.raisedcountersunk: a solid needs a NAME", ...
                   " and a length L."));
  endif

  drive = 'hexalobular';
  bydrive = false;
  maker = '';
  detailed = false;
  B = [];
  if (mod (numel (args), 2) != 0)
    error (strcat ("parts.screw.raisedcountersunk: Name/Value arguments", ...
                   " must come in pairs."));
  endif
  for ii = 1:2:numel (args)
    name = args{ii};
    val = args{ii+1};
    if (! ischar (name) || ! isrow (name))
      error (strcat ("parts.screw.raisedcountersunk: option names must be", ...
                     " character vectors."));
    endif
    switch (lower (name))
      case 'drive'
        if (! ischar (val) || ! isrow (val))
          error (strcat ("parts.screw.raisedcountersunk: 'Drive' must be", ...
                         " a character vector."));
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
            error ("parts.screw.raisedcountersunk: unknown drive '%s'.", val);
        endswitch
        bydrive = true;
      case 'maker'
        if (strcmp (MODE, 'solid'))
          error (strcat ("parts.screw.raisedcountersunk: 'Maker' applies", ...
                         " to 'data' only."));
        endif
        if (! ischar (val) || ! isrow (val))
          error (strcat ("parts.screw.raisedcountersunk: 'Maker' must be", ...
                         " a character vector."));
        endif
        maker = val;
      case 'detailed'
        if (strcmp (MODE, 'data'))
          error (strcat ("parts.screw.raisedcountersunk: 'Detailed'", ...
                         " applies to 'solid' only."));
        endif
        if (! islogical (val) || ! isscalar (val))
          error (strcat ("parts.screw.raisedcountersunk: 'Detailed' must", ...
                         " be true or false."));
        endif
        detailed = val;
      case 'threadlength'
        if (strcmp (MODE, 'data'))
          error (strcat ("parts.screw.raisedcountersunk: 'ThreadLength'", ...
                         " applies to 'solid' only."));
        endif
        B = val;
      otherwise
        error ("parts.screw.raisedcountersunk: unknown option '%s'.", name);
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
      error (strcat ("parts.screw.raisedcountersunk: NAME must name a", ...
                     " metric thread, such as 'M5' or 'M5x0.5'."));
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

## The sizes of a drive's standard, a row for each: d, P, dk actual max,
## k max, the drive's size (slot n nom, recess number or hexalobular socket
## number), its depth from the top of the dome (t min, or the recess's
## penetration min), the cross recess's m, r max, a max, b min, the longest
## length threaded to the head, the shortest and longest commercial length,
## the slot's screwdriver tip of ISO 2380-1 (thickness and width), and f
function T = sizes (drive)

  ## d and P
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
  ## The head the three standards share: dk actual max, k max, r max, b
  ## min, full up to, f
  H = [3, 1, 0.4, 25, 30, 0.4;
       3.8, 1.2, 0.5, 25, 30, 0.5;
       4.7, 1.5, 0.6, 25, 30, 0.6;
       5.5, 1.65, 0.8, 25, 30, 0.7;
       7.3, 2.35, 0.9, 38, 45, 0.8;
       8.4, 2.7, 1, 38, 45, 1;
       9.3, 2.7, 1.3, 38, 45, 1.2;
       11.3, 3.3, 1.5, 38, 45, 1.4;
       15.8, 4.65, 2, 38, 45, 2;
       18.3, 5, 2.5, 38, 45, 2.3];
  switch (drive)
    case 'slot'
      ## ISO 2010:1994: n nom, t min, range, tip
      D = [0.4, 0.64, 2.5, 16, 0.4, 2.5;
           0.5, 0.8, 3, 20, 0.5, 3;
           0.6, 1, 4, 25, 0.6, 3.5;
           0.8, 1.2, 5, 30, 0.8, 4;
           1, 1.4, 6, 35, 1, 5.5;
           1.2, 1.6, 6, 40, 1.2, 6.5;
           1.2, 2, 8, 50, 1.2, 6.5;
           1.6, 2.4, 8, 60, 1.6, 8;
           2, 3.2, 10, 80, 2, 12;
           2.5, 3.8, 12, 80, 2.5, 14];
      T = [C(:,1:2), H(:,1:2), D(:,1:2), NaN(10,1), H(:,3), 2 * C(:,2), ...
           H(:,4:5), D(:,3:6), H(:,6)];
    case {'crossH', 'crossZ'}
      ## ISO 7047:1994: recess number, m and penetration min of H and of Z,
      ## range
      D = [0, 1.9, 0.9, 1.9, 0.95, 3, 16;
           0, 2, 1.2, 2.2, 1.15, 3, 20;
           1, 3, 1.5, 2.8, 1.5, 3, 25;
           1, 3.4, 1.8, 3.1, 1.83, 4, 30;
           2, 4.8, 2.25, 4.6, 2.25, 5, 35;
           2, 5.2, 2.7, 5, 2.65, 5, 40;
           2, 5.4, 2.9, 5.3, 2.9, 6, 50;
           3, 7.3, 3.5, 7.1, 3.4, 8, 60;
           4, 9.6, 4.75, 9.5, 4.75, 10, 60;
           4, 10.4, 5.5, 10.3, 5.6, 12, 60];
      z = 2 * strcmp (drive, 'crossZ');
      T = [C(:,1:2), H(:,1:2), D(:,1), D(:,3+z), D(:,2+z), H(:,3), ...
           2 * C(:,2), H(:,4:5), D(:,6:7), NaN(10,2), H(:,6)];
    case 'hexalobular'
      ## ISO 14584:2011: socket number, t min, range
      D = [6, 0.63, 3, 20;
           8, 0.91, 3, 25;
           10, 0.88, 4, 30;
           15, 1.27, 5, 35;
           20, 1.42, 5, 40;
           25, 1.65, 6, 50;
           30, 2.02, 8, 60;
           45, 2.92, 10, 60;
           50, 3.42, 12, 60];
      k = 2:10;
      T = [C(k,1:2), H(k,1:2), D(:,1:2), NaN(9,1), H(k,3), 2 * C(k,2), ...
           H(k,4:5), D(:,3:4), NaN(9,2), H(k,6)];
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
## pitches P, lengths l, thread lengths b and drives DRIVE, columns;
## character vectors for one
function [name, standard, thread] = designate (h, P, l, b, drive)

  series = [2.5, 3:6, 8, 10, 12, 14, 16, 20:5:80];
  n = numel (l);
  if (ischar (drive))
    drive = repmat ({drive}, n, 1);
  endif
  drive = drive(:);
  iso = (P == h(:,2) & ismember (l, series) & l >= h(:,12) & l <= h(:,13)
         & b == tableform (h, l));
  slot = strcmp (drive, 'slot');
  lobe = strcmp (drive, 'hexalobular');
  cross = ! slot & ! lobe;
  standard = repmat ({''}, n, 1);
  standard(iso & slot) = {'ISO 2010'};
  standard(iso & cross) = {'ISO 7047'};
  standard(iso & lobe) = {'ISO 14584'};
  denom = repmat ({'Countersunk raised head screw'}, n, 1);
  denom(lobe) = {'Hexalobular socket raised countersunk head screw'};
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

  keep = true (size (E));
  if (! isempty (d))
    T = sizes ('slot');
    if (isnan (P) && any (T(:,1) == d))
      P = T(T(:,1) == d,2);
    endif
    keep &= [E.d] == d & [E.P] == P;
  endif
  if (! isempty (L))
    keep &= [E.l] == L;
  endif
  if (bydrive)
    keep &= strcmp ({E.drive}, drive);
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
    if (bydrive)
      how = sprintf (" with a %s drive", drive);
    endif
    if (! isempty (maker))
      how = sprintf ("%s by %s", how, maker);
    endif
    error (strcat ("parts.screw.raisedcountersunk: no %sraised", ...
                   " countersunk head screw%s in the catalogue."), what, how);
  endif

endfunction

## Every entry of the catalogue, sorted by size, then length
function E = entries ()

  ## BEGIN generated by tools/reyher_tables.py raisedcountersunk
  ## REYHER article, printed page, drive, class, finish; then each
  ## size with its lengths
  A = {'02010.400', 227, 'slot', '4.8', 'plain', {
         2.5, [6, 8];
         4, [8, 10, 12, 16, 20];
         5, [25, 30, 35]};
       '02010.410', 227, 'slot', '4.8', 'zinc plated', {
         3, [5, 6, 8, 10, 12, 16, 20, 25, 30, 35, 40];
         4, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80];
         5, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60, 80];
         6, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80];
         8, [16, 20, 25, 30, 35, 40, 45, 50, 60];
         10, [20, 25, 30, 35, 40, 50]};
       '02010.920', 524, 'slot', 'A2', 'plain', {
         3, [5, 6, 8, 10, 12, 16, 20, 25];
         4, [6, 8, 10, 12, 16, 20, 25, 30, 35];
         5, [8, 10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80];
         6, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, ...
             100, 105, 110];
         8, [12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80];
         10, [20, 25, 30, 35, 40]};
       '02010.940', 524, 'slot', 'A4', 'plain', {
         2, [4, 5, 6, 8, 10, 12, 20];
         2.5, [6, 8, 10, 16, 20];
         3, [6, 8, 10, 12, 16, 20, 25, 30];
         4, [6, 8, 10, 12, 16, 18, 20, 25, 30, 35, 40, 45];
         5, [10, 12, 16, 20, 25, 30, 35, 40, 50, 60, 70, 80];
         6, [10, 12, 16, 20, 25, 30, 35, 40, 50, 60, 70, 80];
         8, [16, 20, 25, 30, 40, 50];
         10, [20, 25, 50]};
       '02010.700', 635, 'slot', 'brass', 'plain', {
         3, [5, 6, 8, 10, 12, 16, 20, 25, 30, 35, 40];
         4, [5, 6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60];
         5, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 100];
         6, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 100];
         8, [16, 20, 25, 30, 35, 40, 50, 60]};
       '02010.730', 635, 'slot', 'brass', 'nickel plated', {
         3, [8, 10, 12, 16, 20, 25];
         4, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60];
         5, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80];
         6, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80]};
       '02010.740', 636, 'slot', 'brass', 'chrome plated', {
         3, [8, 10, 12, 16, 20, 30];
         4, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60];
         5, [10, 12, 16, 20, 25, 30, 35, 40, 50, 60, 70];
         6, [10, 16, 20, 25, 30, 35, 40, 50, 60, 80];
         8, [20, 25]};
       '07047.414', 329, 'crossH', '4.8', 'zinc plated', {
         2.5, [5, 6, 8, 10];
         3, [5, 6, 8, 10, 12, 16, 20, 25, 30, 35, 40];
         4, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60];
         5, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80];
         6, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80];
         8, [16, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80]};
       '07047.924', 564, 'crossH', 'A2', 'plain', {
         2.5, [4, 5, 6, 8, 10, 12, 16, 20, 25];
         3, [4, 5, 6, 8, 10, 12, 16, 18, 20, 25, 30, 35, 45, 50];
         4, [5, 6, 8, 10, 12, 14, 16, 20, 25, 30, 35, 40, 45, 50];
         5, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80];
         6, [8, 10, 12, 16, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, ...
             80];
         8, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60]};
       '07047.944', 565, 'crossH', 'A4', 'plain', {
         2.5, [6, 8, 10, 12, 16, 20, 25];
         3, [4, 5, 6, 8, 10, 12, 16, 20, 25, 30];
         4, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40];
         5, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50];
         6, [8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60];
         8, [10, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60]};
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

  F = [name, standard, num2cell([d, h(:,2), l, b, h(:,3), d + 2 * h(:,4), ...
                                 h(:,4), h(:,16)]), drive, tool, A(a,4:5), ...
       repmat({'REYHER'}, n, 1), A(a,1), source(a)]';
  E = cell2struct (F, {'designation', 'standard', 'd', 'P', 'l', 'b', ...
                       'dk', 'dkt', 'k', 'f', 'drive', 'tool', 'class', ...
                       'finish', 'maker', 'article', 'source'}, 1)';
  [~, k] = sortrows ([d, l], [1, 2]);
  E = E(k);

endfunction

function S = shape (d, P, L, B, drive, detailed)

  T = sizes (drive);
  h = T(T(:,1) == d,:);
  if (isempty (h))
    std = struct ('slot', 'ISO 2010', 'crossH', 'ISO 7047', ...
                  'crossZ', 'ISO 7047', 'hexalobular', 'ISO 14584');
    error ("parts.screw.raisedcountersunk: %s defines no M%g head.", ...
           std.(drive), d);
  endif
  dk = h(3);
  k = h(4);
  f = h(16);
  if (isnan (P))
    P = h(2);
  endif
  if (isempty (B))
    B = tableform (h, L);
  elseif (! isnumeric (B) || ! isreal (B) || ! isscalar (B) || B <= 0
          || (B > L - k && B != L))
    error (strcat ("parts.screw.raisedcountersunk: 'ThreadLength' must be", ...
                   " a length from 0 to L - k, or L."));
  endif
  [name, ~, tname] = designate (h, P, L, B, drive);

  ## The 90 degree cone from the shank at z = -k, cut by the cylinder dk,
  ## and the dome from its edge to f above it
  zl = (dk - d) / 2 - k;
  ro = dk / 2;
  w = asin (2 * ro * f / (ro ^ 2 + f ^ 2));
  if (detailed)
    q = h(8) * tand (22.5);
    x = d / 2 + q * sind (45);
    z = -k + q * cosd (45);
    U = [0, -L, 0; d / 2, -L, 0; d / 2, -k - q, -tand(11.25); x, z, 0];
  else
    U = [0, -L, 0; d / 2, -L, 0; d / 2, -k, 0];
  endif
  R = geom.Region ([U; ro, zl, 0; ro, 0, tan(w/4); 0, f, 0]);
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
    case 'slot'
      S = parts.screw.__recess__ (S, 'slot', [h(5), dk, h(6)], f);
    case {'crossH', 'crossZ'}
      S = parts.screw.__recess__ (S, drive, h([5, 7, 6]), f, detailed);
    case 'hexalobular'
      S = parts.screw.__recess__ (S, drive, h(5:6), f, detailed);
  endswitch
  S.Name = name;

endfunction

%!test  # the catalogue, every article in every size and length
%! C = parts.screw.raisedcountersunk ('data');
%! assert_equal (numel (C), 570);
%!test  # an article as REYHER lists it
%! C = parts.screw.raisedcountersunk ('data', 'M5', 20);
%! E = C(strcmp ({C.article}, '07047.414'));
%! assert_equal ({E.designation, E.class, E.finish, E.tool, E.drive}, ...
%!               {'Countersunk raised head screw ISO 7047 - M5 x 20 - H', ...
%!                '4.8', 'zinc plated', 'PH2', 'crossH'});
%!test  # its sizes
%! C = parts.screw.raisedcountersunk ('data', 'M5', 20);
%! E = C(strcmp ({C.article}, '07047.414'));
%! assert_equal ([E.d, E.P, E.l, E.b, E.dk, E.dkt, E.k, E.f], ...
%!               [5, 0.8, 20, 20, 9.3, 10.4, 2.7, 1.2], 1e-12);
%!test  # a slotted screw, ISO 2010
%! C = parts.screw.raisedcountersunk ('data', 'M5', 20, 'Drive', 'slot');
%! assert_equal ({C(1).designation, C(1).tool}, ...
%!               {'Countersunk raised head screw ISO 2010 - M5 x 20', ...
%!                '1.2 x 6.5'});
%!test  # without 'Drive' every drive sold comes
%! C = parts.screw.raisedcountersunk ('data', 'M5', 20);
%! assert_equal (unique ({C.drive}), {'crossH', 'slot'});
%!test  # a length past the table is custom
%! C = parts.screw.raisedcountersunk ('data', 'M4', 50, 'Drive', 'slot');
%! assert_equal (unique ({C.designation}), ...
%!               {'Countersunk raised head screw M4 x 50 x 38'});
%!testif ; exist ('__occt__') == 3  # hexalobular by default: dome, round hole
%! S = parts.screw.raisedcountersunk ('solid', 'M5', 20);
%! R = (4.65 ^ 2 + 1.44) / 2.4;
%! V = pi * (6.25 * 17.3 + 2.15 / 3 * (6.25 + 2.5 * 4.65 + 4.65 ^ 2) ...
%!           + 4.65 ^ 2 * 0.55 + 1.2 * (3 * 4.65 ^ 2 + 1.44) / 6) ...
%!     - pi * 2.25 ^ 2 * (1.65 - R) ...
%!     - 2 * pi / 3 * (R ^ 3 - (R ^ 2 - 2.25 ^ 2) ^ 1.5);
%! assert_equal (volume (S), V, 1e-6);
%!testif ; exist ('__occt__') == 3  # the edge on the plane, the dome above
%! S = parts.screw.raisedcountersunk ('solid', 'M5', 20, 'Drive', 'slot');
%! R = (4.65 ^ 2 + 1.44) / 2.4;
%! B = bbox (S);
%! assert_equal (B([3, 6]), [-20, 1.2 - R + sqrt(R ^ 2 - 0.36)], 1e-6);
%!testif ; exist ('__occt__') == 3  # named by its designation
%! S = parts.screw.raisedcountersunk ('solid', 'M5', 20, 'Drive', 'crossZ');
%! assert_equal (S.Name, ...
%!               {'Countersunk raised head screw ISO 7047 - M5 x 20 - Z'});
%!testif ; exist ('__occt__') == 3  # hexalobular, ISO 14584
%! S = parts.screw.raisedcountersunk ('solid', 'M5', 20, 'Drive', 'torx');
%! assert_equal (S.Name, ...
%!               {['Hexalobular socket raised countersunk head screw', ...
%!                 ' ISO 14584 - M5 x 20']});
%!testif ; exist ('__occt__') == 3  # custom by its thread length
%! S = parts.screw.raisedcountersunk ('solid', 'M5', 20, 'Drive', 'slot', ...
%!                                    'ThreadLength', 10);
%! assert_equal (S.Name, {'Countersunk raised head screw M5 x 20 x 10'});
%!testif ; exist ('__occt__') == 3  # detailed: fillet, socket, thread
%! S = parts.screw.raisedcountersunk ('solid', 'M5', 20, 'Detailed', true);
%! assert_equal (isvalid (S), true);
%!testif ; exist ('__occt__') == 3  # detailed cross recess
%! S = parts.screw.raisedcountersunk ('solid', 'M5', 20, 'Drive', 'crossH', ...
%!                                    'Detailed', true);
%! assert_equal (isvalid (S), true);

%!error<parts.screw.raisedcountersunk: MODE must be 'data' or 'solid'.> ...
%! parts.screw.raisedcountersunk ()
%!error<parts.screw.raisedcountersunk: a solid needs a NAME and a length L.> ...
%! parts.screw.raisedcountersunk ('solid', 'M5')
%!error<parts.screw.raisedcountersunk: L must be a positive length.> ...
%! parts.screw.raisedcountersunk ('solid', 'M5', 0)
%!error<parts.screw.raisedcountersunk: NAME must name a metric thread, such as 'M5' or 'M5x0.5'.> ...
%! parts.screw.raisedcountersunk ('data', 'M5y')
%!error<parts.screw.raisedcountersunk: Name/Value arguments must come in pairs.> ...
%! parts.screw.raisedcountersunk ('data', 'M5', 'Maker')
%!error<parts.screw.raisedcountersunk: option names must be character vectors.> ...
%! parts.screw.raisedcountersunk ('data', 5, 'Maker')
%!error<parts.screw.raisedcountersunk: unknown option 'Class'.> ...
%! parts.screw.raisedcountersunk ('data', 'Class', '4.8')
%!error<parts.screw.raisedcountersunk: 'Drive' must be a character vector.> ...
%! parts.screw.raisedcountersunk ('data', 'Drive', 1)
%!error<parts.screw.raisedcountersunk: unknown drive 'hexsocket'.> ...
%! parts.screw.raisedcountersunk ('data', 'Drive', 'hexsocket')
%!error<parts.screw.raisedcountersunk: 'Maker' applies to 'data' only.> ...
%! parts.screw.raisedcountersunk ('solid', 'M5', 20, 'Maker', 'REYHER')
%!error<parts.screw.raisedcountersunk: 'Maker' must be a character vector.> ...
%! parts.screw.raisedcountersunk ('data', 'Maker', 1)
%!error<parts.screw.raisedcountersunk: 'Detailed' applies to 'solid' only.> ...
%! parts.screw.raisedcountersunk ('data', 'Detailed', true)
%!error<parts.screw.raisedcountersunk: 'Detailed' must be true or false.> ...
%! parts.screw.raisedcountersunk ('solid', 'M5', 20, 'Detailed', 'yes')
%!error<parts.screw.raisedcountersunk: 'Detailed' must be true or false.> ...
%! parts.screw.raisedcountersunk ('solid', 'M5', 20, 'Detailed', 1)
%!error<parts.screw.raisedcountersunk: 'ThreadLength' applies to 'solid' only.> ...
%! parts.screw.raisedcountersunk ('data', 'ThreadLength', 10)
%!error<parts.screw.raisedcountersunk: 'ThreadLength' must be a length from 0 to L - k, or L.> ...
%! parts.screw.raisedcountersunk ('solid', 'M5', 20, 'ThreadLength', 18)
%!error<parts.screw.raisedcountersunk: ISO 14584 defines no M1.6 head.> ...
%! parts.screw.raisedcountersunk ('solid', 'M1.6', 5)
%!error<parts.screw.raisedcountersunk: ISO 2010 defines no M12 head.> ...
%! parts.screw.raisedcountersunk ('solid', 'M12', 30, 'Drive', 'slot')
%!error<parts.screw.raisedcountersunk: no M1.4 raised countersunk head screw in the catalogue.> ...
%! parts.screw.raisedcountersunk ('data', 'M1.4')
%!error<parts.screw.raisedcountersunk: no M5 x 20 raised countersunk head screw with a hexalobular drive in the catalogue.> ...
%! parts.screw.raisedcountersunk ('data', 'M5', 20, 'Drive', 'torx')
