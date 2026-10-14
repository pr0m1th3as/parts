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
## @deftypefn  {parts} {@var{C} =} parts.screw.cap (@qcode{'data'})
## @deftypefnx {parts} {@var{C} =} parts.screw.cap (@qcode{'data'}, @var{NAME})
## @deftypefnx {parts} {@var{C} =} parts.screw.cap (@qcode{'data'}, @var{NAME}, @var{L})
## @deftypefnx {parts} {@var{S} =} parts.screw.cap (@qcode{'solid'}, @var{NAME}, @var{L})
## @deftypefnx {parts} {@dots{} =} parts.screw.cap (@dots{}, @var{Name}, @var{Value})
##
## Socket head cap screws, ISO 4762 and ISO 14579.
##
## @code{@var{C} = parts.screw.cap (@qcode{'data'})} returns every cap screw
## in the catalogue as a struct array, one entry for each maker's article in
## each size and length, sorted by size and length.
## @code{@var{C} = parts.screw.cap (@qcode{'data'}, @var{NAME})} returns
## those of the thread @var{NAME}, such as @qcode{'M5'}, and
## @code{@var{C} = parts.screw.cap (@qcode{'data'}, @var{NAME}, @var{L})}
## those of nominal length @var{L} too: every article sold as that screw,
## each with its property class and finish.  Nothing is built.
##
## @code{@var{S} = parts.screw.cap (@qcode{'solid'}, @var{NAME}, @var{L})}
## builds the screw as a @code{solid.Shape} whether or not anyone sells it:
## any thread whose head the standard defines, any length.  @var{NAME} names
## a coarse thread by its diameter, @qcode{'M5'}, or any pitch, as
## @qcode{'M16x0.8'}.  The underside of the head lies on the @math{xy}
## plane, the head above it to @math{z} = @var{k}, the shank below it to
## @math{z} = -@var{L}, the socket sunk into the head with two of its
## corners or lobes on the @math{x} axis.  @code{@var{S}.Name} holds the
## screw's designation.
##
## Name/Value pairs:
##
## @table @asis
## @item @qcode{'Drive'}
## The socket: @qcode{'hexsocket'} (alias @qcode{'allen'}), ISO 4762, the
## default, or @qcode{'hexalobular'} (alias @qcode{'torx'}), ISO 14579.  For
## @qcode{'data'} it keeps that drive's screws only; without it both come.
##
## @item @qcode{'Maker'}
## For @qcode{'data'}: only that maker's articles, such as
## @qcode{'REYHER'}, in any case.
##
## @item @qcode{'ThreadLength'}
## For @qcode{'solid'}: the length of thread @var{b} from the end of the
## shank, from 0 to @var{L}; @var{L} threads it to the head.  Without it the
## thread follows Table 1 of ISO 4762 or ISO 14579, which agree: threaded
## to the head up to the longest length the table threads so, and @var{b}
## of the table from its first length with a plain shank.  A length between
## the two takes no default and needs @qcode{'ThreadLength'}.
##
## @item @qcode{'Detailed'}
## For @qcode{'solid'}: @code{true} builds the screw as its standard defines
## it, slower: the fillet of radius @var{r} under the head, the hexalobular
## socket's true outline, and the thread, cut by
## @code{solid.Shape.thread}.  A thread to the head runs to within
## @math{3P} of it, as Table 1 allows.  By default (@code{false}) the shank
## is a plain cylinder of diameter @var{d}, the edges are sharp and the
## hexalobular socket is a round hole of its diameter @var{A}.  Either way
## the socket is cut to its smallest depth @var{t}; the point is left
## flat, its chamfer not given by the sources.
## @end table
##
## Each entry is a struct with these fields, lengths in millimetres:
##
## @multitable @columnfractions 0.16 0.84
## @item @code{designation} @tab the designation of ISO 8991, as in
## @qcode{'Hexagon socket head cap screw ISO 4762 - M5 x 20'}, without the
## property class
## @item @code{standard} @tab @qcode{'ISO 4762'} or @qcode{'ISO 14579'}
## when the standard's table defines the screw, else empty: such a screw is
## custom
## @item @code{d} @tab nominal diameter
## @item @code{P} @tab pitch, coarse
## @item @code{l} @tab nominal length
## @item @code{b} @tab length of thread from the end, @var{l} when threaded
## to the head
## @item @code{dk} @tab head diameter, plain head, largest
## @item @code{k} @tab head height, largest
## @item @code{drive} @tab @qcode{'hexsocket'} or @qcode{'hexalobular'}
## @item @code{tool} @tab the key or bit, as @qcode{'4'} or @qcode{'T30'}
## @item @code{class} @tab property class or stainless steel grade, as
## @qcode{'12.9'} or @qcode{'A2-70'}; a grade alone, @qcode{'A2'}, where
## the maker's class depends on production
## @item @code{finish} @tab the finish as the maker names it, as
## @qcode{'plain'} or @qcode{'zinc plated'}
## @item @code{maker} @tab the maker
## @item @code{article} @tab the maker's article number
## @item @code{source} @tab the catalogue and page the article was read from
## @end multitable
##
## A screw is designated by its standard's number only when the standard's
## table defines it: the size, the length and, through the length, whether
## it is threaded to the head.  Every other screw is custom, its thread
## length written when shorter than @var{l}, as
## @qcode{'Hexagon socket head cap screw M5 x 60 x 22'}.
##
## @subheading The catalogue
##
## Articles from REYHER, @cite{The Catalogue}, edition 2020.04, English,
## pages 286 to 304 (steel), 547 to 551 (stainless steel), 402 and 121
## (hexalobular): every article of a plain screw in sizes ISO 4762 defines,
## M1.6 to M64, and in lengths ISO 4762 Table 1 gives a thread for.
## Left out: the sizes M1.4, M18, M22, M27, M33 and M39, whose socket depth
## and thread form the sources do not give; the lengths M3 x 22, M4 x 28,
## M6 x 32, M20 x 75 and M24 x 85, which fall between Table 1's threaded
## and plain shank lengths; and an M 25 x 50 printed in article 04762.810,
## a thread ISO 261 does not have.  The two articles of 8.8FT are threaded
## to the head at every length.  Article 00912.814, filed under DIN 912,
## is the ISO 14579 screw by REYHER's own note.
##
## Heads, sockets and thread lengths from ISO 4762:2004 Table 1, read in
## IS 2269:2006, which agrees with REYHER's @cite{Technical Information}
## (2019, TI-12).  Hexalobular heads and thread lengths from TI-12, socket
## numbers and depths from DIN EN ISO 14579:2011 as reproduced by fasten.it
## and fasteners.eu, which agree; its lengths and thread form from
## ISO 14579:2011, read in GOST R ISO 14579-2015, which agrees with
## GOST R ISO 14579-2009 and fasteners.eu.
##
## @seealso{parts.bearing.deepgroove, parts.dowel, parts.key}
## @end deftypefn

function OUT = cap (MODE, varargin)

  if (nargin < 1 || ! ischar (MODE)
      || ! any (strcmp (MODE, {'data', 'solid'})))
    error ("parts.screw.cap: MODE must be 'data' or 'solid'.");
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
        error ("parts.screw.cap: L must be a positive length.");
      endif
    endif
  endif
  if (strcmp (MODE, 'solid') && isempty (L))
    error ("parts.screw.cap: a solid needs a NAME and a length L.");
  endif

  drive = 'hexsocket';
  bydrive = false;
  maker = '';
  detailed = false;
  B = [];
  if (mod (numel (args), 2) != 0)
    error ("parts.screw.cap: Name/Value arguments must come in pairs.");
  endif
  for ii = 1:2:numel (args)
    name = args{ii};
    val = args{ii+1};
    if (! ischar (name) || ! isrow (name))
      error ("parts.screw.cap: option names must be character vectors.");
    endif
    switch (lower (name))
      case 'drive'
        if (! ischar (val) || ! isrow (val))
          error ("parts.screw.cap: 'Drive' must be a character vector.");
        endif
        switch (lower (val))
          case {'hexsocket', 'allen'}
            drive = 'hexsocket';
          case {'hexalobular', 'torx'}
            drive = 'hexalobular';
          otherwise
            error ("parts.screw.cap: unknown drive '%s'.", val);
        endswitch
        bydrive = true;
      case 'maker'
        if (strcmp (MODE, 'solid'))
          error ("parts.screw.cap: 'Maker' applies to 'data' only.");
        endif
        if (! ischar (val) || ! isrow (val))
          error ("parts.screw.cap: 'Maker' must be a character vector.");
        endif
        maker = val;
      case 'detailed'
        if (strcmp (MODE, 'data'))
          error ("parts.screw.cap: 'Detailed' applies to 'solid' only.");
        endif
        if (! islogical (val) || ! isscalar (val))
          error ("parts.screw.cap: 'Detailed' must be true or false.");
        endif
        detailed = val;
      case 'threadlength'
        if (strcmp (MODE, 'data'))
          error ("parts.screw.cap: 'ThreadLength' applies to 'solid' only.");
        endif
        B = val;
      otherwise
        error ("parts.screw.cap: unknown option '%s'.", name);
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
      error (strcat ("parts.screw.cap: NAME must name a metric thread,", ...
                     " such as 'M5' or 'M16x0.8'."));
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

## The heads, a row for each size: d, coarse pitch P, dk, k, the socket (s
## across flats, or the hexalobular socket number), its depth t min, the
## fillet r min under the head, thread length b, the longest length threaded
## to the head and the first with a plain shank, and the shortest and
## longest length of ISO 4762 Table 1
function H = heads (drive)

  if (strcmp (drive, 'hexsocket'))
    ## ISO 4762:2004 Table 1 (IS 2269:2006)
    H = [1.6, 0.35, 3, 1.6, 1.5, 0.7, 0.1, 15, 16, NaN, 2.5, 16;
         2, 0.4, 3.8, 2, 1.5, 1, 0.1, 16, 16, 20, 3, 20;
         2.5, 0.45, 4.5, 2.5, 2, 1.1, 0.1, 17, 20, 25, 4, 25;
         3, 0.5, 5.5, 3, 2.5, 1.3, 0.1, 18, 20, 25, 5, 30;
         4, 0.7, 7, 4, 3, 2, 0.2, 20, 25, 30, 6, 40;
         5, 0.8, 8.5, 5, 4, 2.5, 0.2, 22, 25, 30, 8, 50;
         6, 1, 10, 6, 5, 3, 0.25, 24, 30, 35, 10, 60;
         8, 1.25, 13, 8, 6, 4, 0.4, 28, 35, 40, 12, 80;
         10, 1.5, 16, 10, 8, 5, 0.4, 32, 40, 45, 16, 100;
         12, 1.75, 18, 12, 10, 6, 0.6, 36, 50, 55, 20, 120;
         14, 2, 21, 14, 12, 7, 0.6, 40, 55, 60, 25, 140;
         16, 2, 24, 16, 14, 8, 0.6, 44, 60, 65, 25, 160;
         20, 2.5, 30, 20, 17, 10, 0.8, 52, 70, 80, 30, 200;
         24, 3, 36, 24, 19, 12, 0.8, 60, 80, 90, 40, 200;
         30, 3.5, 45, 30, 22, 15.5, 1, 72, 100, 110, 45, 200;
         36, 4, 54, 36, 27, 19, 1, 84, 110, 120, 55, 200;
         42, 4.5, 63, 42, 32, 24, 1.2, 96, 130, 140, 60, 300;
         48, 5, 72, 48, 36, 28, 1.6, 108, 150, 160, 70, 300;
         56, 5.5, 84, 56, 41, 34, 2, 124, 160, 180, 80, 300;
         64, 6, 96, 64, 46, 38, 2, 140, 180, 200, 90, 300];
  else
    ## ISO 14579: heads and b from TI-12, sockets from DIN EN ISO 14579:2011,
    ## lengths and thread form from ISO 14579:2011, r from ISO 4762, none
    ## for M18
    H = [2, 0.4, 3.8, 2, 6, 0.71, 0.1, 16, 16, 20, 3, 20;
         2.5, 0.45, 4.5, 2.5, 8, 0.91, 0.1, 17, 20, 25, 4, 25;
         3, 0.5, 5.5, 3, 10, 1.01, 0.1, 18, 20, 25, 5, 30;
         4, 0.7, 7, 4, 20, 1.42, 0.2, 20, 25, 30, 6, 40;
         5, 0.8, 8.5, 5, 25, 1.65, 0.2, 22, 25, 30, 8, 50;
         6, 1, 10, 6, 30, 2.02, 0.25, 24, 30, 35, 10, 60;
         8, 1.25, 13, 8, 45, 2.92, 0.4, 28, 35, 40, 12, 80;
         10, 1.5, 16, 10, 50, 3.62, 0.4, 32, 40, 45, 16, 100;
         12, 1.75, 18, 12, 55, 4.82, 0.6, 36, 50, 55, 20, 120;
         14, 2, 21, 14, 60, 5.62, 0.6, 40, 55, 60, 25, 140;
         16, 2, 24, 16, 70, 6.62, 0.6, 44, 60, 65, 25, 160;
         18, 2.5, 27, 18, 80, 7.5, NaN, 48, 65, 70, 30, 180;
         20, 2.5, 30, 20, 90, 8.69, 0.8, 52, 70, 80, 30, 200];
  endif

endfunction

## The thread lengths by ISO 4762 Table 1 of screws of head rows h and
## lengths l, a column: l up to the longest length threaded to the head, the
## table's b from the first with a plain shank, NaN between them
function b = tableform (h, l)

  b = NaN (size (l));
  full = l <= h(:,9);
  b(full) = l(full);
  part = l >= h(:,10);
  b(part) = h(part,8);

endfunction

## The designations, standards and threads of screws of head rows h,
## pitches P, lengths l, thread lengths b and drives DRIVE, columns; character
## vectors for one screw
function [name, standard, thread] = designate (h, P, l, b, drive)

  series = [2.5, 3, 4, 5, 6, 8, 10, 12, 16, 20, 25:5:70, 80:10:160, ...
            180:20:300];
  n = numel (l);
  if (ischar (drive))
    drive = repmat ({drive}, n, 1);
  endif
  hex = strcmp (drive(:), 'hexsocket');
  iso = (P == h(:,2) & ismember (l, series) & l >= h(:,11) & l <= h(:,12)
         & b == tableform (h, l));
  standard = repmat ({''}, n, 1);
  standard(iso & hex) = {'ISO 4762'};
  standard(iso & ! hex) = {'ISO 14579'};
  denom = repmat ({'Hexalobular socket head cap screw'}, n, 1);
  denom(hex) = {'Hexagon socket head cap screw'};
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

  keep = true (size (E));
  if (! isempty (d))
    keep &= [E.d] == d & (isnan (P) | [E.P] == P);
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
    error ("parts.screw.cap: no %scap screw%s in the catalogue.", what, how);
  endif

endfunction

## Every entry of the catalogue, sorted by size, then length
function E = entries ()

  ## BEGIN generated by tools/reyher_tables.py cap
  ## REYHER article, printed page, drive, class, finish, threaded to
  ## the head whatever the length; then each size with its lengths
  A = {'04762.800', 286, 'hexsocket', '8.8', 'plain', false, {
         3, [4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50];
         4, [4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, ...
             50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 110, 120];
         5, [5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, ...
             55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 105, 110, 115, 120, ...
             125, 130, 135, 140, 145, 150, 155, 160, 165, 170, 175, 180, ...
             185, 190, 195, 200, 210, 220];
         6, [6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 28, 30, 35, 40, 45, 50, ...
             55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 105, 110, 115, 120, ...
             125, 130, 135, 140, 145, 150, 155, 160, 165, 170, 175, 180, ...
             185, 190, 195, 200, 210, 220, 230, 240, 250, 280, 300];
         8, [8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             65, 70, 75, 80, 85, 90, 95, 100, 105, 110, 115, 120, 125, 130, ...
             135, 140, 145, 150, 155, 160, 165, 170, 180, 190, 200, 210, ...
             220, 230, 240, 250, 260, 270, 280, 300];
         10, [10, 12, 14, 16, 18, 20, 22, 25, 28, 30, 35, 40, 45, 50, 55, ...
             60, 65, 70, 75, 80, 85, 90, 95, 100, 105, 110, 115, 120, 125, ...
             130, 135, 140, 150, 155, 160, 170, 180, 185, 190, 200, 210, ...
             220, 230, 240, 250, 260, 270, 280, 290, 300, 320, 340];
         12, [14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, ...
             75, 80, 85, 90, 95, 100, 105, 110, 115, 120, 125, 130, 135, ...
             140, 145, 150, 155, 160, 165, 170, 180, 190, 200, 210, 220, ...
             230, 240, 250, 260, 270, 280, 290, 300, 310, 320, 340, 360, ...
             380, 400];
         14, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, ...
             95, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, ...
             210, 220, 230, 240, 250, 260, 270, 280, 290, 300];
         16, [16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, ...
             85, 90, 95, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, ...
             200, 210, 220, 230, 240, 250, 260, 270, 280, 290, 300, 310, ...
             320, 330, 340, 350, 360, 370, 380, 390, 400, 410, 420, 440, ...
             460, 480, 500, 520, 540, 560, 580, 600];
         20, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 85, 90, 95, ...
             100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, ...
             220, 230, 240, 250, 260, 270, 280, 290, 300, 310, 320, 330, ...
             340, 350, 360, 370, 380, 390, 400, 410, 420, 440, 450, 460, ...
             480, 500, 520, 540, 560, 580, 600];
         24, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 95, 100, 105, ...
             110, 120, 125, 130, 140, 150, 160, 170, 180, 190, 200, 210, ...
             220, 230, 240, 250, 260, 270, 280, 290, 300, 310, 320, 330, ...
             340, 350, 360, 370, 380, 390, 400, 410, 420, 430, 440, 450, ...
             460, 470, 480, 490, 500, 520, 530, 540, 560, 580, 600];
         30, [35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 110, ...
             120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, ...
             240, 250, 260, 270, 280, 290, 300, 310, 320, 330, 340, 350, ...
             360, 370, 380, 390, 400, 420, 430, 440, 450, 460, 470, 480, ...
             490, 500, 540, 700];
         36, [50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 110, 120, 130, ...
             140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, ...
             260, 270, 280, 290, 300, 310, 320, 330, 340, 350, 360, 370, ...
             380, 390, 400, 420, 430, 440, 500, 560, 600];
         42, [70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, ...
             200, 210, 220, 240, 260, 270, 280, 300, 350, 400, 500, 560];
         48, [80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, ...
             200, 210, 220, 240, 260, 270, 280, 300];
         56, [120, 130, 140, 150, 160, 180, 200, 210, 220, 230, 260, 280, ...
             300]};
       '04762.810', 290, 'hexsocket', '8.8', 'zinc plated', false, {
         3, [4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50];
         4, [4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, ...
             50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 110, 120];
         5, [5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, ...
             55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 110, 115, 120, 125, ...
             130, 140, 150, 160, 170, 180, 200];
         6, [6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 28, 30, 35, 40, 45, 50, ...
             55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 105, 110, 115, 120, ...
             125, 130, 140, 145, 150, 160, 170, 180, 200, 210, 220, 230, ...
             280, 300];
         8, [8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             65, 70, 75, 80, 85, 90, 95, 100, 105, 110, 115, 120, 125, 130, ...
             135, 140, 145, 150, 160, 170, 180, 190, 200, 210, 220, 230, ...
             240, 250, 260, 270, 280];
         10, [10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             65, 70, 75, 80, 85, 90, 95, 100, 110, 115, 120, 125, 130, 135, ...
             140, 150, 155, 160, 170, 180, 190, 200, 210, 220, 230, 240, ...
             250, 260, 270, 280, 300];
         12, [14, 16, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, ...
             80, 85, 90, 95, 100, 110, 115, 120, 125, 130, 135, 140, 145, ...
             150, 155, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, ...
             260, 270, 290, 300];
         14, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, ...
             110, 120, 130, 140, 150, 160, 200];
         16, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, ...
             95, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, ...
             210, 220, 230, 240, 250, 260, 270, 280, 300, 320, 340, 360];
         20, [25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 85, 90, 100, 110, ...
             120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, ...
             240, 250, 260, 270, 280, 300, 310, 320];
         24, [30, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, ...
             130, 140, 150, 160, 170, 180, 200, 210, 220, 230, 240, 250, ...
             260, 280, 300];
         30, [35, 40, 50, 55, 60, 65, 70, 80, 85, 90, 100, 110, 120, 130, ...
             140, 150, 160, 170, 180, 190, 200, 210, 220, 240, 250, 260, ...
             280, 300];
         36, [50, 60, 65, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, ...
             180, 200, 220, 230, 260, 310, 320];
         42, [70, 80, 90, 100]};
       '04762.317', 292, 'hexsocket', '8.8', 'zinc plated 8 TLP', false, {
         3, [6, 8, 10, 12, 16, 20];
         4, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40];
         5, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50];
         6, [8, 10, 12, 16, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, ...
             75, 80, 100];
         8, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, ...
             90, 100];
         10, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100];
         12, [20, 25, 30, 35, 40, 45, 50, 60, 65, 70, 75, 80, 90];
         16, [25, 30, 35, 40, 50, 55, 60, 65, 70, 80, 90, 100, 120]};
       '04762.428', 293, 'hexsocket', '8.8', 'zinc plated 8 TLP + SL', false, {
         3, [6, 8, 10, 12, 16, 20];
         4, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 45, 50];
         5, [6, 8, 10, 12, 14, 16, 20, 22, 25, 30, 35, 40, 45, 50, 55];
         6, [8, 10, 12, 16, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, ...
             75, 80, 85, 100, 105, 110, 130];
         8, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, ...
             85, 90, 100, 110, 200];
         10, [12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, ...
             100, 110, 120, 135];
         12, [20, 25, 30, 35, 40, 45, 50, 60, 65, 70, 75, 80, 90, 100, 110, ...
             120];
         14, [30];
         16, [25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 100, ...
             120, 130, 140, 150, 180, 300];
         20, [35, 50, 55, 60, 65, 70, 100, 120, 150, 180]};
       '04762.353', 293, 'hexsocket', '8.8', 'flZn/TL480h', false, {
         6, [12, 14, 16, 18, 20, 22, 25, 28, 30, 35, 40, 45, 50, 55, 60, ...
             65, 70, 75, 80];
         8, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90];
         10, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90];
         12, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100];
         16, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, ...
             120];
         20, [65, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180];
         24, [75, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180]};
       '04762.388', 294, 'hexsocket', '8.8', 'plain', true, {
         5, [40, 50, 60, 70, 80];
         6, [40, 50, 60, 70, 80, 90, 100];
         8, [50, 60, 70, 80, 90, 100];
         10, [50, 60, 70, 80, 90, 100];
         12, [70, 80, 90, 100];
         16, [70, 80, 90, 100, 120]};
       '04762.329', 294, 'hexsocket', '8.8', 'zinc plated', true, {
         4, [30];
         5, [40, 45, 50, 60, 70, 80];
         6, [40, 50, 60, 70, 75, 80, 90, 100];
         8, [45, 50, 60, 70, 75, 80, 90, 100];
         10, [50, 60, 80, 90, 100];
         12, [60, 80, 100]};
       '04762.100', 295, 'hexsocket', '10.9', 'plain', false, {
         3, [6, 8, 10, 12, 14, 16, 20, 25, 30];
         4, [6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, ...
             60, 65, 70];
         5, [6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, ...
             60, 65, 70, 75, 80, 85, 90, 95, 100, 110, 120, 130, 135, 140, ...
             150, 160, 170, 180, 190, 200];
         6, [8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             65, 70, 75, 80, 85, 90, 95, 100, 110, 120, 130, 135, 140, 145, ...
             150, 160, 170, 180, 190, 200, 210, 220, 230, 240];
         8, [10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             65, 70, 75, 80, 85, 90, 95, 100, 110, 120, 125, 130, 135, 140, ...
             150, 160, 170, 180, 190, 200, 220, 240, 250, 260, 270, 280, ...
             300];
         10, [10, 12, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, 65, ...
             70, 75, 80, 85, 90, 95, 100, 110, 115, 120, 125, 130, 135, ...
             140, 145, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, ...
             250, 260, 270, 280, 290, 300, 310, 320, 340, 350, 400];
         12, [12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, ...
             75, 80, 85, 90, 95, 100, 110, 120, 125, 130, 135, 140, 150, ...
             160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 260, 270, ...
             280, 290, 300, 310, 320, 330, 340, 360, 380, 400];
         14, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, ...
             110, 120, 125, 130, 140, 150, 160, 170, 180, 190, 200];
         16, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, ...
             100, 110, 120, 125, 130, 140, 150, 160, 170, 180, 190, 200, ...
             210, 220, 230, 240, 250, 260, 270, 280, 290, 300, 320, 330, ...
             340, 350, 360, 380, 400];
         20, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 85, 90, 95, ...
             100, 110, 120, 125, 130, 135, 140, 145, 150, 160, 170, 180, ...
             190, 200, 210, 220, 230, 240, 250, 260, 270, 280, 290, 300, ...
             310, 320, 330, 340, 350, 360, 380, 400];
         24, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 95, 100, 110, ...
             120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, ...
             240, 250, 260, 270, 280, 290, 300, 310, 320, 330, 340, 350, ...
             360, 380, 400, 420, 440, 450, 460, 480, 500, 520];
         30, [40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 110, ...
             120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, ...
             240, 250, 260, 270, 280, 290, 300, 310, 320, 330, 340, 350, ...
             360, 380, 400, 420, 440, 450, 460, 480, 500, 520];
         36, [50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, 140, 150, ...
             160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 260, 270, ...
             280, 290, 300, 310, 320, 330, 340, 350, 360, 380, 400, 420, ...
             440, 450, 460, 480, 500];
         42, [80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, ...
             200, 220, 240, 260, 280, 300, 320, 400, 420];
         48, [110, 160, 200, 400]};
       '04762.110', 298, 'hexsocket', '10.9', 'zinc plated, baked', false, {
         3, [6, 8, 10, 12, 16, 20, 25, 30];
         4, [6, 8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, 60, 65];
         5, [6, 8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, ...
             65, 70, 75, 80, 85, 90, 95, 100, 110, 120, 130, 140, 150, 160];
         6, [8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             65, 70, 75, 80, 85, 90, 100, 110, 120, 125, 130, 140, 150, ...
             160];
         8, [10, 12, 14, 16, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, 65, ...
             70, 75, 80, 90, 100, 120, 125, 130, 140, 150, 160, 170, 180, ...
             200];
         10, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, ...
             80, 85, 90, 95, 100, 110, 120, 130, 140, 160, 170, 180, 210, ...
             220];
         12, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, ...
             95, 100, 110, 120, 125, 130, 135, 140, 150, 160, 170, 180, ...
             190, 200, 210, 220, 230, 240, 250, 260, 270, 280, 290, 300, ...
             310, 320, 330, 340, 360, 380];
         14, [30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100, 110, 120, ...
             130];
         16, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, ...
             100, 110, 120, 125, 130, 140, 150, 160, 170, 180, 200, 210, ...
             230, 240, 250, 270];
         20, [20, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100, 110, ...
             120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, ...
             240, 260];
         24, [40, 45, 50, 60, 65, 70, 80, 90, 100, 110, 120, 130, 140, 150, ...
             160, 170, 180, 190, 200, 210, 220, 230, 240, 260, 280, 300, ...
             320, 330];
         30, [40, 50, 60, 65, 70, 80, 90, 100, 110, 120, 130, 150, 160, ...
             170, 180, 200, 220, 230, 240, 250, 260, 280, 300, 320, 340, ...
             350];
         36, [50, 60, 70, 80, 90, 100, 110, 130, 140, 150, 160, 170, 180, ...
             200, 220]};
       '04762.354', 299, 'hexsocket', '10.9', 'flZn/TL480h', false, {
         6, [12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, 65, ...
             70, 75, 80];
         8, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90];
         10, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90];
         12, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100];
         16, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, ...
             120];
         20, [65, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180];
         24, [80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180]};
       '04762.133', 300, 'hexsocket', '10.9', 'flZnL480h', false, {
         4, [35];
         5, [30, 35, 40, 45];
         6, [12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, 65, ...
             70, 75, 80];
         8, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90];
         10, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100];
         12, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, ...
             110, 140];
         14, [60, 70];
         16, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, ...
             120, 180, 200];
         20, [45, 55, 60, 65, 70, 80, 90, 100, 110, 120, 130, 140, 150, ...
             160, 170, 180];
         24, [80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 300]};
       '04762.200', 301, 'hexsocket', '12.9', 'plain', false, {
         1.6, [3, 4, 5, 6];
         2, [3, 4, 5, 6, 8, 10, 12];
         2.5, [4, 5, 6, 8, 10, 12, 16, 20];
         3, [4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50];
         4, [5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, ...
             55, 60, 65, 70, 75, 80, 90, 100, 110, 120];
         5, [6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, ...
             60, 65, 70, 75, 80, 85, 90, 95, 100, 105, 110, 115, 120, 125, ...
             130, 135, 140, 145, 150, 155, 160, 165, 170, 175, 180, 190, ...
             200, 210, 220, 230, 240];
         6, [6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, ...
             60, 65, 70, 75, 80, 85, 90, 95, 100, 105, 110, 115, 120, 125, ...
             130, 135, 140, 145, 150, 155, 160, 165, 170, 175, 180, 185, ...
             190, 200, 210, 220, 230, 240, 250, 260, 270, 280, 290, 300];
         8, [8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             65, 70, 75, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, ...
             180, 190, 200, 210, 220, 230, 240, 250, 260, 270, 280, 290, ...
             300, 310];
         10, [10, 12, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, 65, ...
             70, 75, 80, 85, 90, 100, 110, 120, 130, 140, 150, 160, 170, ...
             180, 190, 200, 210, 220, 230, 240, 250, 260, 270, 280, 290, ...
             300];
         12, [12, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, ...
             75, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, ...
             200, 220, 230, 240, 250, 260, 280, 300, 310, 320, 340, 360, ...
             380, 400];
         14, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, ...
             110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 220, 240, ...
             260, 280, 300];
         16, [20, 22, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, ...
             90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, ...
             210, 220, 230, 240, 250, 260, 270, 280, 290, 300, 310, 320, ...
             330, 340, 350, 360, 370, 380, 390, 400, 420];
         20, [30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100, 110, 120, ...
             130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, ...
             250, 260, 270, 280, 290, 300, 310, 320, 330, 340, 350, 360, ...
             380, 400, 420, 440, 460, 480, 500];
         24, [40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, ...
             140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, ...
             260, 270, 280, 290, 300, 310, 320, 330, 340, 350, 360, 380, ...
             400, 420, 440, 450, 460, 480, 500];
         30, [45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, 140, ...
             150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 260, ...
             270, 280, 290, 300, 320, 340, 360, 380, 400, 420, 440, 460];
         36, [60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, ...
             200, 220, 240, 260, 280, 300, 320, 340, 360, 380, 400, 420];
         42, [120, 130, 140, 150, 160, 170, 180, 190, 200, 220, 240, 260, ...
             280, 300];
         48, [120, 130, 140, 150, 160, 180, 200, 220, 240, 260, 280, 300]};
       '04762.280', 304, 'hexsocket', '12.9', 'flZn/TL480h', false, {
         6, [12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, 65, ...
             70, 75, 80];
         8, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90];
         10, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90];
         12, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100];
         16, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, ...
             120];
         20, [65, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180];
         24, [80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180]};
       '04762.920', 547, 'hexsocket', 'A2-70', 'plain', false, {
         5, [10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             65, 70, 75, 80, 90, 100];
         6, [10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             65, 70, 75, 80, 85, 90, 95, 100, 110, 120, 130, 140, 150];
         8, [10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             65, 70, 75, 80, 85, 90, 100, 110, 120, 130, 140, 150];
         10, [12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, ...
             80, 90, 100, 110, 120, 130, 140, 150];
         12, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, ...
             90, 100, 110, 120, 130, 140, 150, 160];
         14, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100, 110, ...
             120, 130, 140, 150];
         16, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, ...
             110, 120, 130, 140, 150, 160];
         20, [30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100, 110, 120, ...
             130, 140, 150];
         24, [40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, ...
             140, 150]};
       '04762.920', 547, 'hexsocket', 'A2', 'plain', false, {
         1.6, [4, 5, 6, 8];
         2, [3, 4, 5, 6, 8, 10, 12, 16, 20];
         2.5, [4, 5, 6, 8, 10, 12, 14, 16, 20, 25];
         3, [4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50];
         4, [5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, ...
             55, 60, 70, 80];
         5, [6, 8];
         6, [6, 8];
         8, [8, 160, 170, 180];
         10, [160, 170, 180];
         12, [170, 180];
         16, [170, 180, 190, 200];
         20, [160, 170, 180, 190, 200];
         24, [160, 170, 180, 200];
         30, [50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150]};
       '04762.940', 548, 'hexsocket', 'A4-70', 'plain', false, {
         5, [10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             70, 80, 90, 100];
         6, [10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             65, 70, 75, 80, 90, 100, 110, 120, 130, 140, 150];
         8, [10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             65, 70, 75, 80, 90, 100, 110, 120, 130, 140, 150];
         10, [12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, ...
             80, 90, 100, 110, 120, 130, 140, 150];
         12, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, ...
             100, 110, 120, 130, 140, 150, 160];
         14, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100, 110, ...
             120, 130, 140, 150];
         16, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, ...
             110, 120, 130, 140, 150, 160];
         20, [30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100, 110, 120, ...
             130, 140, 150];
         24, [40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, ...
             140, 150]};
       '04762.940', 548, 'hexsocket', 'A4', 'plain', false, {
         2, [3, 4, 5, 6, 8, 10, 12, 16];
         2.5, [4, 5, 6, 8, 10, 12, 14, 16, 20];
         3, [4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50];
         4, [5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, ...
             55, 60, 70];
         5, [6, 8];
         6, [8];
         8, [160, 170, 180];
         10, [10, 160, 170, 180];
         12, [170, 180];
         16, [170, 180, 190, 200, 220, 240, 250, 260, 280, 300];
         20, [160, 170, 180, 190, 200];
         24, [160, 180, 190, 200, 210, 220, 230, 240];
         30, [50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, ...
             180, 200]};
       '04762.948', 550, 'hexsocket', 'A4-80', 'plain', false, {
         6, [8, 10, 12, 14, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70];
         8, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, ...
             100];
         10, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100];
         12, [20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100];
         16, [20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100];
         20, [30, 35, 40, 45, 50, 60, 70, 80, 90, 100]};
       '04762.941', 551, 'hexsocket', 'BUMAX88', 'plain', false, {
         3, [6, 8, 10, 12, 16, 20, 25];
         4, [6, 8, 10, 12, 16, 20, 25, 30];
         5, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50];
         6, [12, 16, 20, 25, 30, 35, 40, 45, 50, 60, 70];
         8, [16, 20, 25, 30, 35, 40, 45, 50, 60];
         10, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90];
         12, [20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90, 100, 120];
         16, [35, 40, 45, 50, 55, 60, 80, 90, 100];
         20, [40, 45, 50, 60, 70, 80, 90, 100];
         24, [50, 60, 70, 80, 90, 100]};
       '04762.942', 551, 'hexsocket', 'BUMAX109', 'plain', false, {
         4, [12, 20];
         6, [20, 30, 40, 50, 60];
         8, [20, 30, 40, 50, 60, 70, 80, 90];
         10, [20, 30, 40, 50, 60, 70, 80];
         12, [30, 40, 50, 60, 70, 80, 90, 100, 120];
         16, [40, 50, 60, 80, 90, 100]};
       '14579.810', 402, 'hexalobular', '8.8', 'zinc plated', false, {
         6, [16, 20];
         8, [20, 25, 30, 35]};
       '00912.814', 121, 'hexalobular', '8.8', 'zinc plated', false, {
         6, [16, 20];
         8, [20, 25, 30, 35]};
      };
  ## END generated

  ## One row for each article, size and length
  Z = vertcat (A{:,7});
  nl = cellfun (@numel, Z(:,2));
  a = repelem (repelem ((1:rows (A))', cellfun (@rows, A(:,7))), nl);
  d = repelem (cell2mat (Z(:,1)), nl);
  l = [Z{:,2}]';
  n = numel (l);

  ## Their heads, thread lengths, designations and tools
  drive = A(a,3);
  hex = strcmp (drive, 'hexsocket');
  H = heads ('hexsocket');
  [~, k] = ismember (d(hex), H(:,1));
  h = zeros (n, columns (H));
  h(hex,:) = H(k,:);
  H = heads ('hexalobular');
  [~, k] = ismember (d(! hex), H(:,1));
  h(! hex,:) = H(k,:);
  b = tableform (h, l);
  ft = [A{a,6}]';
  b(ft) = l(ft);
  [name, standard] = designate (h, h(:,2), l, b, drive);
  tool = cell (n, 1);
  tool(hex) = arrayfun (@(s) sprintf ("%g", s), h(hex,5), ...
                       'UniformOutput', false);
  tool(! hex) = arrayfun (@(s) sprintf ("T%d", s), h(! hex,5), ...
                         'UniformOutput', false);
  source = arrayfun (@(p) sprintf ("REYHER, The Catalogue, 2020.04, p. %d", ...
                                   p), [A{:,2}]', 'UniformOutput', false);

  F = [name, standard, num2cell([d, h(:,2), l, b, h(:,3:4)]), drive, ...
       tool, A(a,4:5), repmat({'REYHER'}, n, 1), A(a,1), source(a)]';
  E = cell2struct (F, {'designation', 'standard', 'd', 'P', 'l', 'b', ...
                       'dk', 'k', 'drive', 'tool', 'class', 'finish', ...
                       'maker', 'article', 'source'}, 1)';
  [~, k] = sortrows ([d, l], [1, 2]);
  E = E(k);

endfunction

function S = shape (d, P, L, B, drive, detailed)

  H = heads (drive);
  h = H(H(:,1) == d,:);
  if (isempty (h))
    if (strcmp (drive, 'hexsocket'))
      error ("parts.screw.cap: ISO 4762 defines no M%g head.", d);
    else
      error ("parts.screw.cap: ISO 14579 defines no M%g head.", d);
    endif
  endif
  if (isnan (P))
    P = h(2);
  endif
  if (isempty (B))
    B = tableform (h, L);
    if (isnan (B))
      error (strcat ("parts.screw.cap: ISO 4762 Table 1 gives M%g x %g", ...
                     " no thread form; give 'ThreadLength'."), d, L);
    endif
  elseif (! isnumeric (B) || ! isreal (B) || ! isscalar (B) || B <= 0
          || B > L)
    error (strcat ("parts.screw.cap: 'ThreadLength' must be a length", ...
                   " from 0 to L."));
  endif
  [name, ~, tname] = designate (h, P, L, B, drive);

  dk = h(3);
  k = h(4);
  if (detailed)
    r = h(7);
    if (isnan (r))
      error (strcat ("parts.screw.cap: the sources give no fillet under", ...
                     " the head of M%g; build it without 'Detailed'."), d);
    endif
    R = geom.Region ([0, -L, 0; d/2, -L, 0; d/2, -r, -tan(pi/8);
                      d/2 + r, 0, 0; dk/2, 0, 0; dk/2, k, 0; 0, k, 0]);
  else
    R = geom.Region ([0, -L; d/2, -L; d/2, 0; dk/2, 0; dk/2, k; 0, k]);
  endif
  R.UCS = geom.UCS ([0, -1, 0], [0, 0, 0]);
  S = solid.revolve (R);
  S = parts.screw.__recess__ (S, drive, h(5:6), k, detailed);
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
%! C = parts.screw.cap ('data');
%! assert_equal (numel (C), 4064);
%!test  # sorted by size, then length
%! C = parts.screw.cap ('data');
%! assert_equal (issorted ([C.d]), true);
%!test  # an article as REYHER lists it: its designation
%! C = parts.screw.cap ('data', 'M5', 20);
%! E = C(strcmp ({C.article}, '04762.800'));
%! assert_equal (E.designation, ...
%!               'Hexagon socket head cap screw ISO 4762 - M5 x 20');
%!test  # its size, threaded to the head, and its head
%! C = parts.screw.cap ('data', 'M5', 20);
%! E = C(strcmp ({C.article}, '04762.800'));
%! assert_equal ([E.d, E.P, E.l, E.b, E.dk, E.k], [5, 0.8, 20, 20, 8.5, 5]);
%!test  # its drive, class and finish
%! C = parts.screw.cap ('data', 'M5', 20);
%! E = C(strcmp ({C.article}, '04762.800'));
%! assert_equal ({E.drive, E.tool, E.class, E.finish}, ...
%!               {'hexsocket', '4', '8.8', 'plain'});
%!test  # its maker and page
%! C = parts.screw.cap ('data', 'M5', 20);
%! E = C(strcmp ({C.article}, '04762.800'));
%! assert_equal ({E.maker, E.source}, ...
%!               {'REYHER', 'REYHER, The Catalogue, 2020.04, p. 286'});
%!test  # every article sold as M5 x 20
%! C = parts.screw.cap ('data', 'M5', 20);
%! assert_equal ({C.article}, {'04762.800', '04762.810', '04762.317', ...
%!                             '04762.428', '04762.100', '04762.110', ...
%!                             '04762.200', '04762.920', '04762.940', ...
%!                             '04762.941'});
%!test  # a length of Table 1 with a plain shank
%! C = parts.screw.cap ('data', 'M5', 40);
%! assert_equal ({C(1).standard, C(1).b}, {'ISO 4762', 22});
%!test  # a length beyond Table 1 is custom, its thread length written
%! C = parts.screw.cap ('data', 'M5', 60);
%! assert_equal ({C(1).designation, C(1).standard, C(1).b}, ...
%!               {'Hexagon socket head cap screw M5 x 60 x 22', '', 22});
%!test  # a full thread Table 1 does not give is custom
%! C = parts.screw.cap ('data', 'M8', 60);
%! E = C(strcmp ({C.article}, '04762.388'));
%! assert_equal ({E.designation, E.b}, ...
%!               {'Hexagon socket head cap screw M8 x 60', 60});
%!test  # a length below Table 1's, page 286
%! C = parts.screw.cap ('data', 'M4', 4);
%! assert_equal (any (strcmp ({C.article}, '04762.800')), true);
%!test  # a stainless size whose class depends on production
%! C = parts.screw.cap ('data', 'M1.6', 4);
%! assert_equal ({C.article; C.class}, {'04762.200', '04762.920'; ...
%!                                      '12.9', 'A2'});
%!test  # the hexalobular articles
%! C = parts.screw.cap ('data', 'M6', 16, 'Drive', 'torx');
%! assert_equal ({C.article}, {'14579.810', '00912.814'});
%!test  # ISO 14579 screws by their standard
%! C = parts.screw.cap ('data', 'M6', 16, 'Drive', 'hexalobular');
%! assert_equal ({C(1).designation, C(1).tool}, ...
%!               {'Hexalobular socket head cap screw ISO 14579 - M6 x 16', ...
%!                'T30'});
%!test  # without 'Drive' both drives come
%! C = parts.screw.cap ('data', 'M6', 16);
%! assert_equal (numel (C), 17);
%!test  # 'Drive' in any case
%! C = parts.screw.cap ('data', 'M6', 16, 'Drive', 'TORX');
%! assert_equal (numel (C), 2);
%!test  # 'Drive' keeps one
%! C = parts.screw.cap ('data', 'M6', 16, 'Drive', 'allen');
%! assert_equal (numel (C), 15);
%!test  # 'Maker' in any case
%! C = parts.screw.cap ('data', 'M6', 16, 'Maker', 'reyher');
%! assert_equal (numel (C), 17);
%!testif ; exist ('__occt__') == 3  # the head above the plane, the shank below
%! S = parts.screw.cap ('solid', 'M5', 20);
%! assert_equal (bbox (S), [-4.25, -4.25, -20, 4.25, 4.25, 5], 1e-6);
%!testif ; exist ('__occt__') == 3  # the hexagon socket, s across, t deep
%! S = parts.screw.cap ('solid', 'M5', 20);
%! V = pi * (2.5 ^ 2 * 20 + 4.25 ^ 2 * 5) - sqrt (3) / 2 * 4 ^ 2 * 2.5;
%! assert_equal (volume (S), V, 1e-6);
%!testif ; exist ('__occt__') == 3  # the hexalobular socket, a hole of A
%! S = parts.screw.cap ('solid', 'M5', 20, 'Drive', 'torx');
%! V = pi * (2.5 ^ 2 * 20 + 4.25 ^ 2 * 5) - pi * 2.25 ^ 2 * 1.65;
%! assert_equal (volume (S), V, 1e-6);
%!testif ; exist ('__occt__') == 3  # named by its designation
%! S = parts.screw.cap ('solid', 'M5', 20);
%! assert_equal (S.Name, {'Hexagon socket head cap screw ISO 4762 - M5 x 20'});
%!testif ; exist ('__occt__') == 3  # a custom screw
%! S = parts.screw.cap ('solid', 'M16x0.8', 80, 'ThreadLength', 25);
%! assert_equal (S.Name, {'Hexagon socket head cap screw M16x0.8 x 80 x 25'});
%!testif ; exist ('__occt__') == 3  # the thread of Table 1 named as ISO 4762
%! S = parts.screw.cap ('solid', 'M5', 40, 'ThreadLength', 22);
%! assert_equal (S.Name, {'Hexagon socket head cap screw ISO 4762 - M5 x 40'});
%!testif ; exist ('__occt__') == 3  # another thread length is custom
%! S = parts.screw.cap ('solid', 'M5', 40, 'ThreadLength', 40);
%! assert_equal (S.Name, {'Hexagon socket head cap screw M5 x 40'});
%!testif ; exist ('__occt__') == 3  # detailed: fillet, thread, valid
%! S = parts.screw.cap ('solid', 'M3', 10, 'Detailed', true);
%! assert_equal (isvalid (S), true);
%!testif ; exist ('__occt__') == 3  # detailed: the same envelope
%! S = parts.screw.cap ('solid', 'M3', 10, 'Detailed', true);
%! assert_equal (bbox (S), [-2.75, -2.75, -10, 2.75, 2.75, 3], 1e-6);

%!error<parts.screw.cap: MODE must be 'data' or 'solid'.> parts.screw.cap ()
%!error<parts.screw.cap: MODE must be 'data' or 'solid'.> ...
%! parts.screw.cap ('box')
%!error<parts.screw.cap: a solid needs a NAME and a length L.> ...
%! parts.screw.cap ('solid', 'M5')
%!error<parts.screw.cap: L must be a positive length.> ...
%! parts.screw.cap ('solid', 'M5', -1)
%!error<parts.screw.cap: L must be a positive length.> ...
%! parts.screw.cap ('data', 'M5', [20, 25])
%!error<parts.screw.cap: NAME must name a metric thread, such as 'M5' or 'M16x0.8'.> ...
%! parts.screw.cap ('data', 'M5y')
%!error<parts.screw.cap: NAME must name a metric thread, such as 'M5' or 'M16x0.8'.> ...
%! parts.screw.cap ('solid', 'M5x0', 20)
%!error<parts.screw.cap: Name/Value arguments must come in pairs.> ...
%! parts.screw.cap ('data', 'M5', 'Drive')
%!error<parts.screw.cap: option names must be character vectors.> ...
%! parts.screw.cap ('data', 20, 'Drive')
%!error<parts.screw.cap: unknown option 'Colour'.> ...
%! parts.screw.cap ('data', 'Colour', 'red')
%!error<parts.screw.cap: 'Drive' must be a character vector.> ...
%! parts.screw.cap ('data', 'Drive', 1)
%!error<parts.screw.cap: unknown drive 'cross'.> ...
%! parts.screw.cap ('data', 'Drive', 'cross')
%!error<parts.screw.cap: unknown drive 'slot'.> ...
%! parts.screw.cap ('data', 'Drive', 'slot')
%!error<parts.screw.cap: 'Maker' applies to 'data' only.> ...
%! parts.screw.cap ('solid', 'M5', 20, 'Maker', 'REYHER')
%!error<parts.screw.cap: 'Maker' must be a character vector.> ...
%! parts.screw.cap ('data', 'Maker', 1)
%!error<parts.screw.cap: 'Detailed' applies to 'solid' only.> ...
%! parts.screw.cap ('data', 'Detailed', true)
%!error<parts.screw.cap: 'Detailed' must be true or false.> ...
%! parts.screw.cap ('solid', 'M5', 20, 'Detailed', 'yes')
%!error<parts.screw.cap: 'Detailed' must be true or false.> ...
%! parts.screw.cap ('solid', 'M5', 20, 'Detailed', 1)
%!error<parts.screw.cap: 'ThreadLength' applies to 'solid' only.> ...
%! parts.screw.cap ('data', 'ThreadLength', 10)
%!error<parts.screw.cap: 'ThreadLength' must be a length from 0 to L.> ...
%! parts.screw.cap ('solid', 'M5', 20, 'ThreadLength', 25)
%!error<parts.screw.cap: no M4 x 28 cap screw in the catalogue.> ...
%! parts.screw.cap ('data', 'M4', 28)
%!error<parts.screw.cap: no M18 cap screw in the catalogue.> ...
%! parts.screw.cap ('data', 'M18')
%!error<parts.screw.cap: no M5x0.5 cap screw in the catalogue.> ...
%! parts.screw.cap ('data', 'M5x0.5')
%!error<parts.screw.cap: no M2 x 3 cap screw with a hexalobular drive in the catalogue.> ...
%! parts.screw.cap ('data', 'M2', 3, 'Drive', 'hexalobular')
%!error<parts.screw.cap: no cap screw by NSK in the catalogue.> ...
%! parts.screw.cap ('data', 'Maker', 'NSK')
%!error<parts.screw.cap: ISO 4762 defines no M7 head.> ...
%! parts.screw.cap ('solid', 'M7', 20)
%!error<parts.screw.cap: ISO 14579 defines no M64 head.> ...
%! parts.screw.cap ('solid', 'M64', 200, 'Drive', 'torx')
%!error<parts.screw.cap: ISO 4762 Table 1 gives M4 x 28 no thread form; give 'ThreadLength'.> ...
%! parts.screw.cap ('solid', 'M4', 28)
%!error<parts.screw.cap: the sources give no fillet under the head of M18; build it without 'Detailed'.> ...
%! parts.screw.cap ('solid', 'M18', 60, 'Drive', 'torx', 'ThreadLength', 48, ...
%!                  'Detailed', true)
