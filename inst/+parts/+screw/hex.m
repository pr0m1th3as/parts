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
## @deftypefn  {parts} {@var{C} =} parts.screw.hex (@qcode{'data'})
## @deftypefnx {parts} {@var{C} =} parts.screw.hex (@qcode{'data'}, @var{NAME})
## @deftypefnx {parts} {@var{C} =} parts.screw.hex (@qcode{'data'}, @var{NAME}, @var{L})
## @deftypefnx {parts} {@var{S} =} parts.screw.hex (@qcode{'solid'}, @var{NAME}, @var{L})
## @deftypefnx {parts} {@dots{} =} parts.screw.hex (@dots{}, @var{Name}, @var{Value})
##
## Hexagon head bolts and screws, ISO 4014, 4017, 8765 and 8676, and hexagon
## flange bolts, ISO 4162.
##
## A bolt has a plain shank and a thread of length @var{b} (ISO 4014; with a
## fine thread, ISO 8765); a screw is threaded to the head (ISO 4017; with a
## fine thread, ISO 8676).
##
## @code{@var{C} = parts.screw.hex (@qcode{'data'})} returns every hexagon
## head bolt and screw in the catalogue as a struct array, one entry for each
## maker's article in each size and length, sorted by size, pitch and length.
## @code{@var{C} = parts.screw.hex (@qcode{'data'}, @var{NAME})} returns
## those of the thread @var{NAME}, a coarse thread as @qcode{'M10'} or a fine
## one as @qcode{'M10x1.25'}, and
## @code{@var{C} = parts.screw.hex (@qcode{'data'}, @var{NAME}, @var{L})}
## those of nominal length @var{L} too: every article sold as that bolt or
## screw, each with its property class and finish.  Nothing is built.
##
## @code{@var{S} = parts.screw.hex (@qcode{'solid'}, @var{NAME}, @var{L})}
## builds the bolt or screw as a @code{solid.Shape} whether or not anyone
## sells it: any thread whose head the standards define, any pitch, any
## length.  The bearing face of the head lies on the @math{xy} plane, the
## head above it to @math{z} = @var{k} with two of its corners on the
## @math{x} axis, the shank below it to @math{z} = -@var{L}.
## @code{@var{S}.Name} holds the designation.
##
## Name/Value pairs:
##
## @table @asis
## @item @qcode{'FullThread'}
## @code{true} for a screw threaded to the head, @code{false} for a bolt,
## the default for @qcode{'solid'}.  For @qcode{'data'} it keeps that kind
## only; without it both come.
##
## @item @qcode{'Flange'}
## @code{true} for a hexagon flange bolt of ISO 4162, small series, M5 to
## M16: a hexagon @var{s} across flats and @var{k} high on a flange
## @var{dc} across and @var{c} thick, threaded to the head up to the length
## its table gives and @var{b} beyond.  It takes no @qcode{'FullThread'}.
## No maker's catalogue read so far sells it, so its @qcode{'data'} is empty.
##
## @item @qcode{'Maker'}
## For @qcode{'data'}: only that maker's articles, such as
## @qcode{'REYHER'}, in any case.
##
## @item @qcode{'ThreadLength'}
## For @qcode{'solid'}: the length of thread @var{b} of a bolt, from 0 to
## @var{L}.  Without it a bolt takes the @var{b} its standard gives for the
## length (for 125 or less, up to 200, longer), the formula of ISO 888 where
## the standard gives none for the size, and a bolt shorter than its
## standard's lengths is threaded to the head.
##
## @item @qcode{'Detailed'}
## For @qcode{'solid'}: @code{true} builds the washer face, @var{dw} across
## and @var{c} high, the 30 degree chamfer on top of the head, starting at
## the flats, the fillet of radius @var{r} under the head, and the thread,
## cut by @code{solid.Shape.thread}; a screw's runs to within its run-out
## @var{a} of the head.  By default (@code{false}) the head is a plain
## hexagonal prism and the shank a plain cylinder of diameter @var{d}.  The
## point, which ISO 4753 governs, is left flat.  A flange bolt's chamfer
## starts at the smallest circle ISO 4162 allows, 0.85 @var{s}, and its
## flange rises at 25 degrees from @var{c} thick at @var{dw}; its fillet
## and the bearing face's slight cone are left out.
## @end table
##
## Each entry is a struct with these fields, lengths in millimetres:
##
## @multitable @columnfractions 0.16 0.84
## @item @code{designation} @tab the designation of ISO 8991, as in
## @qcode{'Hexagon head bolt ISO 4014 - M12 x 80'}, without the property
## class
## @item @code{standard} @tab the standard when its table defines the bolt
## or screw, else empty: such a one is custom
## @item @code{d} @tab nominal diameter
## @item @code{P} @tab pitch
## @item @code{l} @tab nominal length
## @item @code{b} @tab length of thread from the end, @var{l} when threaded
## to the head
## @item @code{s} @tab width across flats
## @item @code{k} @tab head height, nominal
## @item @code{grade} @tab product grade, @qcode{'A'} or @qcode{'B'}
## @item @code{class} @tab property class or steel grade, as @qcode{'8.8'},
## @qcode{'A4-70'} or @qcode{'25CrMo4'}
## @item @code{finish} @tab the finish as the maker names it, as
## @qcode{'plain'} or @qcode{'hot dip galvanized'}
## @item @code{maker} @tab the maker
## @item @code{article} @tab the maker's article number
## @item @code{source} @tab the catalogue and page the article was read from
## @end multitable
##
## A bolt is designated by its standard's number when the standard's table
## defines it: the size, a length of its commercial range and the thread
## length its table gives; a screw likewise, threaded to the head.  Every
## other one is custom, a bolt writing its thread length, as
## @qcode{'Hexagon head bolt M10 x 110 x 32'}.  The product grade follows the
## standards: A for M24 and smaller up to 10 @var{d} or 150 long, whichever
## is shorter, B for the rest.
##
## @subheading The catalogue
##
## Articles from REYHER, @cite{The Catalogue}, edition 2020.04, English,
## pages 236 to 271 (steel), 529 to 540 (stainless steel), 384 to 387 and
## 372 to 374 (fine threads): every article of a plain bolt or screw,
## pressure vessel grades and hot dip galvanized ones included, in sizes the
## standards define.  Left out: the sets sold with nuts (EN 15048 and the
## like), the size M7 and the fine threads M24 x 1.5 and M22 x 2, which none
## of the four standards defines.  A bolt article in a length shorter than
## its standard's range is taken as threaded to the head, as REYHER notes
## and ISO 4014 recommends ISO 4017 there, and is custom.
##
## Dimensions from ISO 4014, 4017, 8765 and 8676, all 1999, Tables 1 and 2,
## read in IS 1364 Parts 1 and 2:2002, IS 13726:2002 and IS 13725:2002 with
## their corrigenda, which agree with REYHER's @cite{Technical Information}
## (2019, TI-15); thread lengths beyond the tables from ISO 888:1976, read
## in IS 4206:1987; flange bolts from ISO 4162:1990, read in IS 15582:2005.
##
## @seealso{parts.screw.cap, parts.screw.set}
## @end deftypefn

function OUT = hex (MODE, varargin)

  if (nargin < 1 || ! ischar (MODE)
      || ! any (strcmp (MODE, {'data', 'solid'})))
    error ("parts.screw.hex: MODE must be 'data' or 'solid'.");
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
        error ("parts.screw.hex: L must be a positive length.");
      endif
    endif
  endif
  if (strcmp (MODE, 'solid') && isempty (L))
    error ("parts.screw.hex: a solid needs a NAME and a length L.");
  endif

  full = false;
  byfull = false;
  flange = false;
  maker = '';
  detailed = false;
  B = [];
  if (mod (numel (args), 2) != 0)
    error ("parts.screw.hex: Name/Value arguments must come in pairs.");
  endif
  for ii = 1:2:numel (args)
    name = args{ii};
    val = args{ii+1};
    if (! ischar (name) || ! isrow (name))
      error ("parts.screw.hex: option names must be character vectors.");
    endif
    switch (lower (name))
      case 'fullthread'
        if (! islogical (val) || ! isscalar (val))
          error ("parts.screw.hex: 'FullThread' must be true or false.");
        endif
        full = val;
        byfull = true;
      case 'flange'
        if (! islogical (val) || ! isscalar (val))
          error ("parts.screw.hex: 'Flange' must be true or false.");
        endif
        flange = val;
      case 'maker'
        if (strcmp (MODE, 'solid'))
          error ("parts.screw.hex: 'Maker' applies to 'data' only.");
        endif
        if (! ischar (val) || ! isrow (val))
          error ("parts.screw.hex: 'Maker' must be a character vector.");
        endif
        maker = val;
      case 'detailed'
        if (strcmp (MODE, 'data'))
          error ("parts.screw.hex: 'Detailed' applies to 'solid' only.");
        endif
        if (! islogical (val) || ! isscalar (val))
          error ("parts.screw.hex: 'Detailed' must be true or false.");
        endif
        detailed = val;
      case 'threadlength'
        if (strcmp (MODE, 'data'))
          error ("parts.screw.hex: 'ThreadLength' applies to 'solid' only.");
        endif
        B = val;
      otherwise
        error ("parts.screw.hex: unknown option '%s'.", name);
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
      error (strcat ("parts.screw.hex: NAME must name a metric thread,", ...
                     " such as 'M10' or 'M10x1.25'."));
    endif
    d = str2double (tok{1});
    if (! isempty (tok{2}))
      P = str2double (tok{2});
    endif
  endif

  if (flange && byfull)
    error (strcat ("parts.screw.hex: 'FullThread' does not apply to a", ...
                   " flange bolt; give 'ThreadLength'."));
  endif
  if (strcmp (MODE, 'data'))
    OUT = catalogue (NAME, d, P, L, full, byfull, flange, maker);
  elseif (flange)
    OUT = flanged (d, P, L, B, detailed);
  else
    if (! isempty (B) && full)
      error (strcat ("parts.screw.hex: 'ThreadLength' applies to a bolt,", ...
                     " not to a screw threaded to the head."));
    endif
    OUT = shape (d, P, L, B, full, detailed);
  endif

endfunction

## The heads, a row for each thread: d, P, b for a bolt of 125 or less, up to
## 200 and longer, c max, da max, dw min of grade A and of grade B, k nom,
## r min, s nom, a max of a screw, the shortest and longest bolt and the
## shortest and longest screw; coarse threads from ISO 4014 and 4017, fine
## ones from ISO 8765 and 8676, Tables 1 and 2 of each
function [H, F] = heads ()

  H = [1.6, 0.35, 9, 15, 28, 0.25, 2, 2.42, 2.3, 1.1, 0.1, 3.2, 1.05, 12, ...
         16, 2, 16;
       2, 0.4, 10, 16, 29, 0.25, 2.6, 3.07, 2.95, 1.4, 0.1, 4, 1.2, 16, ...
         20, 4, 20;
       2.5, 0.45, 11, 17, 30, 0.25, 3.1, 4.07, 3.95, 1.7, 0.1, 5, 1.35, ...
         16, 25, 5, 25;
       3, 0.5, 12, 18, 31, 0.4, 3.6, 4.57, 4.45, 2, 0.1, 5.5, 1.5, 20, ...
         30, 6, 30;
       3.5, 0.6, 13, 19, 32, 0.4, 4.1, 5.07, 4.95, 2.4, 0.1, 6, 1.8, 20, ...
         35, 8, 35;
       4, 0.7, 14, 20, 33, 0.4, 4.7, 5.88, 5.74, 2.8, 0.2, 7, 2.1, 25, ...
         40, 8, 40;
       5, 0.8, 16, 22, 35, 0.5, 5.7, 6.88, 6.74, 3.5, 0.2, 8, 2.4, 25, ...
         50, 10, 50;
       6, 1, 18, 24, 37, 0.5, 6.8, 8.88, 8.74, 4, 0.25, 10, 3, 30, 60, 12, 60;
       8, 1.25, 22, 28, 41, 0.6, 9.2, 11.63, 11.47, 5.3, 0.4, 13, 4, 40, ...
         80, 16, 80;
       10, 1.5, 26, 32, 45, 0.6, 11.2, 14.63, 14.47, 6.4, 0.4, 16, 4.5, ...
         45, 100, 20, 100;
       12, 1.75, 30, 36, 49, 0.6, 13.7, 16.63, 16.47, 7.5, 0.6, 18, 5.3, ...
         50, 120, 25, 120;
       14, 2, 34, 40, 53, 0.6, 15.7, 19.64, 19.15, 8.8, 0.6, 21, 6, 60, ...
         140, 30, 140;
       16, 2, 38, 44, 57, 0.8, 17.7, 22.49, 22, 10, 0.6, 24, 6, 65, 160, ...
         30, 200;
       18, 2.5, 42, 48, 61, 0.8, 20.2, 25.34, 24.85, 11.5, 0.6, 27, 7.5, ...
         70, 180, 35, 200;
       20, 2.5, 46, 52, 65, 0.8, 22.4, 28.19, 27.7, 12.5, 0.8, 30, 7.5, ...
         80, 200, 40, 200;
       22, 2.5, 50, 56, 69, 0.8, 24.4, 31.71, 31.35, 14, 0.8, 34, 7.5, ...
         90, 220, 45, 200;
       24, 3, 54, 60, 73, 0.8, 26.4, 33.61, 33.25, 15, 0.8, 36, 9, 90, ...
         240, 50, 200;
       27, 3, 60, 66, 79, 0.8, 30.4, NaN, 38, 17, 1, 41, 9, 100, 260, 55, 200;
       30, 3.5, 66, 72, 85, 0.8, 33.4, NaN, 42.75, 18.7, 1, 46, 10.5, ...
         110, 300, 60, 200;
       33, 3.5, NaN, 78, 91, 0.8, 36.4, NaN, 46.55, 21, 1, 50, 10.5, 130, ...
         320, 65, 200;
       36, 4, NaN, 84, 97, 0.8, 39.4, NaN, 51.11, 22.5, 1, 55, 12, 140, ...
         360, 70, 200;
       39, 4, NaN, 90, 103, 1, 42.4, NaN, 55.86, 25, 1, 60, 12, 150, 380, ...
         80, 200;
       42, 4.5, NaN, 96, 109, 1, 45.6, NaN, 59.95, 26, 1.2, 65, 13.5, ...
         160, 440, 80, 200;
       45, 4.5, NaN, 102, 115, 1, 48.6, NaN, 64.7, 28, 1.2, 70, 13.5, ...
         180, 440, 90, 200;
       48, 5, NaN, 108, 121, 1, 52.6, NaN, 69.45, 30, 1.6, 75, 15, 180, ...
         480, 100, 200;
       52, 5, NaN, 116, 129, 1, 56.6, NaN, 74.2, 33, 1.6, 80, 15, 200, ...
         480, 100, 200;
       56, 5.5, NaN, NaN, 137, 1, 63, NaN, 78.66, 35, 2, 85, 16.5, 220, ...
         500, 110, 200;
       60, 5.5, NaN, NaN, 145, 1, 67, NaN, 83.41, 38, 2, 90, 16.5, 240, ...
         500, 120, 200;
       64, 6, NaN, NaN, 153, 1, 71, NaN, 88.16, 40, 2, 95, 18, 260, 500, ...
         120, 200];

  F = [8, 1, 22, 28, 41, 0.6, 9.2, 11.63, 11.47, 5.3, 0.4, 13, 3, 40, 80, ...
         16, 80;
       10, 1, 26, 32, 45, 0.6, 11.2, 14.63, 14.47, 6.4, 0.4, 16, 3, 45, ...
         100, 20, 100;
       10, 1.25, 26, 32, 45, 0.6, 11.2, 14.63, 14.47, 6.4, 0.4, 16, 4, ...
         45, 100, 20, 100;
       12, 1.25, 30, 36, 49, 0.6, 13.7, 16.63, 16.47, 7.5, 0.6, 18, 4, ...
         50, 120, 25, 120;
       12, 1.5, 30, 36, 49, 0.6, 13.7, 16.63, 16.47, 7.5, 0.6, 18, 4.5, ...
         50, 120, 25, 120;
       14, 1.5, 34, 40, 57, 0.6, 15.7, 19.64, 19.15, 8.8, 0.6, 21, 4.5, ...
         60, 140, 30, 140;
       16, 1.5, 38, 44, 57, 0.8, 17.7, 22.49, 22, 10, 0.6, 24, 4.5, 65, ...
         160, 35, 160;
       18, 1.5, 42, 48, 61, 0.8, 20.2, 25.34, 24.85, 11.5, 0.6, 27, 4.5, ...
         70, 180, 35, 180;
       20, 1.5, 46, 52, 65, 0.8, 22.4, 28.19, 27.7, 12.5, 0.8, 30, 4.5, ...
         80, 200, 40, 200;
       20, 2, 46, 52, 65, 0.8, 22.4, 28.19, 27.7, 12.5, 0.8, 30, 6, 80, ...
         200, 40, 200;
       22, 1.5, 50, 56, 69, 0.8, 24.4, 31.71, 31.35, 14, 0.8, 34, 4.5, ...
         90, 220, 45, 220;
       24, 2, 54, 60, 73, 0.8, 26.4, 33.61, 33.25, 15, 0.8, 36, 6, 100, ...
         240, 40, 200;
       27, 2, 60, 66, 79, 0.8, 30.4, NaN, 38, 17, 1, 41, 6, 110, 260, 55, 260;
       30, 2, 66, 72, 85, 0.8, 33.4, NaN, 42.75, 18.7, 1, 46, 6, 120, ...
         300, 40, 200;
       33, 2, NaN, 78, 91, 0.8, 36.4, NaN, 46.55, 21, 1, 50, 6, 130, 320, ...
         65, 360;
       36, 3, NaN, 84, 97, 0.8, 39.4, NaN, 51.11, 22.5, 1, 55, 9, 140, ...
         360, 40, 200;
       39, 3, NaN, 90, 103, 1, 42.4, NaN, 55.86, 25, 1, 60, 9, 150, 380, ...
         80, 380;
       42, 3, NaN, 96, 109, 1, 45.6, NaN, 59.95, 26, 1.2, 65, 9, 160, ...
         440, 90, 420;
       45, 3, NaN, 102, 115, 1, 48.6, NaN, 64.7, 28, 1.2, 70, 9, 180, ...
         440, 90, 440;
       48, 3, NaN, 108, 121, 1, 52.6, NaN, 69.45, 30, 1.6, 75, 9, 200, ...
         480, 100, 480;
       52, 4, NaN, 116, 129, 1, 56.6, NaN, 74.2, 33, 1.6, 80, 12, 200, ...
         480, 100, 500;
       56, 4, NaN, NaN, 137, 1, 63, NaN, 78.66, 35, 2, 85, 12, 220, 500, ...
         120, 500;
       60, 4, NaN, NaN, 145, 1, 67, NaN, 83.41, 38, 2, 90, 12, 240, 500, ...
         120, 500;
       64, 4, NaN, NaN, 153, 1, 71, NaN, 88.16, 40, 2, 95, 12, 260, 500, ...
         130, 500];

endfunction

## The head rows h of threads d of pitch P, columns; empty rows of NaN where
## the standards define no head
function h = lookup (d, P)

  [H, F] = heads ();
  n = numel (d);
  h = NaN (n, columns (H));
  [~, k] = ismember (d, H(:,1));
  coarse = k > 0;
  coarse(coarse) = isnan (P(coarse)) | P(coarse) == H(k(coarse),2);
  h(coarse,:) = H(k(coarse),:);
  [~, j] = ismember ([d, P], F(:,1:2), 'rows');
  fine = ! coarse & j > 0;
  h(fine,:) = F(j(fine),:);

endfunction

## The thread lengths of bolts of head rows h and lengths l by their
## standard, the formula of ISO 888 where it gives none, l for one shorter
## than the standard's lengths
function b = boltform (h, l)

  n = numel (l);
  r = 3 + (l > 125) + (l > 200);
  b = h(sub2ind (size (h), (1:n)', r));
  f = isnan (b);
  b(f) = 2 * h(f,1) + [6, 12, 25](r(f) - 2)(:);
  b(l < h(:,14)) = l(l < h(:,14));

endfunction

## The designations and standards of bolts and screws: head rows h, pitches
## P, lengths l, thread lengths b and FULL, true for a screw; character
## vectors for one
function [name, standard, thread] = designate (h, P, l, b, full)

  series = [2:6, 8, 10, 12, 16, 20:5:70, 80:10:160, 180:20:500];
  n = numel (l);
  full = full(:) & true (n, 1);
  [H, ~] = heads ();
  [~, k] = ismember (h(:,1), H(:,1));
  coarse = k > 0 & P == H(max (k, 1),2);
  inseries = ismember (l, series);
  bolt = (! full & b < l & b == boltform (h, l) & l >= h(:,14)
          & l <= h(:,15) & inseries);
  screw = full & b == l & l >= h(:,16) & l <= h(:,17) & inseries;
  standard = repmat ({''}, n, 1);
  standard(bolt & coarse) = {'ISO 4014'};
  standard(bolt & ! coarse) = {'ISO 8765'};
  standard(screw & coarse) = {'ISO 4017'};
  standard(screw & ! coarse) = {'ISO 8676'};
  denom = repmat ({'Hexagon head bolt'}, n, 1);
  denom(b == l) = {'Hexagon head screw'};
  [name, thread] = parts.__designation__ (denom, standard, h(:,1), P, l, b);
  if (n == 1)
    name = name{1};
    standard = standard{1};
    thread = thread{1};
  endif

endfunction

function C = catalogue (NAME, d, P, L, full, byfull, flange, maker)

  ## Built on the first call, kept for the session
  persistent E;
  if (isempty (E))
    E = entries ();
  endif

  keep = true (size (E));
  if (! isempty (d))
    if (isnan (P))
      [H, ~] = heads ();
      if (any (H(:,1) == d))
        P = H(H(:,1) == d,2);
      endif
    endif
    keep &= [E.d] == d & [E.P] == P;
  endif
  if (! isempty (L))
    keep &= [E.l] == L;
  endif
  if (byfull)
    keep &= ([E.b] == [E.l]) == full;
  endif
  if (! isempty (maker))
    keep &= strcmpi ({E.maker}, maker);
  endif
  ## No maker's catalogue read so far sells ISO 4162
  keep &= ! flange;
  C = E(keep);

  if (isempty (C))
    what = '';
    if (! isempty (NAME))
      what = [NAME, ' '];
      if (! isempty (L))
        what = sprintf ("%s x %g ", NAME, L);
      endif
    endif
    kind = 'hexagon head bolt or screw';
    if (flange)
      kind = 'hexagon flange bolt';
    elseif (byfull && full)
      kind = 'hexagon head screw';
    elseif (byfull)
      kind = 'hexagon head bolt';
    endif
    how = '';
    if (! isempty (maker))
      how = sprintf (" by %s", maker);
    endif
    error ("parts.screw.hex: no %s%s%s in the catalogue.", what, kind, how);
  endif

endfunction

## Every entry of the catalogue, sorted by size, pitch, then length
function E = entries ()

  ## BEGIN generated by tools/reyher_tables.py hex
  ## REYHER article, printed page, threaded to the head, class, finish;
  ## then each size, its pitch (0 for coarse) and its lengths
  A = {'04014.504', 236, false, '5.6', 'plain', {
         6, 0, [30, 35, 40, 45, 50, 55, 60, 70];
         8, 0, [35, 40, 45, 50, 55, 60, 80, 90, 100];
         10, 0, [45, 50, 55, 60, 65, 70, 80, 90, 100, 110];
         12, 0, [50, 55, 60, 65, 70, 75, 80, 85, 90, 100, 110, 120, 130, ...
             140, 150, 160];
         16, 0, [65, 70, 75, 80, 85, 90, 95, 100, 110, 120, 130, 140, 150, ...
             160, 180, 200];
         20, 0, [80, 85, 90, 95, 100, 110, 120, 130, 140, 150, 160, 170, ...
             180, 190, 200, 210, 220, 240, 250, 260, 280];
         22, 0, [100];
         24, 0, [90, 95, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, ...
             200, 210, 220, 230, 240, 260, 280, 300];
         27, 0, [100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, ...
             220, 230, 240, 260, 280];
         30, 0, [110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, ...
             220, 230, 240, 250, 260, 280, 300, 320];
         33, 0, [130, 140, 150, 160, 165, 170, 180, 190, 200, 210, 220];
         36, 0, [120, 140, 150, 160, 165, 170, 180, 200, 220, 240, 260, ...
             300];
         39, 0, [150, 160, 180]};
       '04014.514', 236, false, '5.6', 'zinc plated', {
         10, 0, [45, 50, 55, 60, 65, 70, 80, 90, 100, 110];
         12, 0, [50, 55, 60, 65, 70, 75, 80, 85, 90, 100, 110, 120, 130, ...
             140, 150, 160];
         16, 0, [65, 70, 75, 80, 85, 90, 95, 100, 110, 120, 130, 140, 150, ...
             160, 180];
         20, 0, [80, 85, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, ...
             190, 200, 220, 240];
         24, 0, [90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, ...
             220, 240];
         27, 0, [100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, ...
             220, 230, 240, 260];
         30, 0, [110, 120, 130, 140, 150, 160, 180, 190, 200, 210, 220, ...
             230, 240, 250, 260];
         33, 0, [130, 140, 150, 160, 170, 180, 190];
         36, 0, [120, 130, 140, 150, 160, 165, 170, 180, 200, 220]};
       '04014.352', 238, false, '25CrMo4', 'plain', {
         12, 0, [55, 60, 65, 70, 75, 80, 85, 90, 100, 110, 120, 140, 150, ...
             160];
         16, 0, [65, 70, 75, 80, 85, 90, 95, 100, 110, 120, 130, 140, 150, ...
             160, 180, 200];
         20, 0, [80, 85, 90, 95, 100, 110, 120, 130, 140, 150, 160, 170, ...
             180, 190, 200, 210, 220, 230, 240, 250, 260, 280];
         24, 0, [90, 95, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, ...
             200, 210, 220, 230, 240, 260, 280, 300];
         27, 0, [110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 220, ...
             230, 240, 260, 280];
         30, 0, [110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, ...
             220, 230, 240, 250, 260, 280, 300, 320];
         33, 0, [130, 140, 150, 160, 165, 170, 180, 190, 200, 210, 220];
         36, 0, [120, 140, 150, 160, 170, 180, 200, 220, 240, 260, 300];
         39, 0, [150, 160, 180]};
       '04014.355', 238, false, '25CrMo4', 'zinc plated', {
         12, 0, [55, 60, 65, 70, 75, 80, 85, 90, 100, 110, 120, 130, 140, ...
             150, 160];
         16, 0, [65, 70, 75, 80, 85, 90, 95, 100, 110, 120, 130, 140, 150, ...
             160, 180];
         20, 0, [80, 85, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, ...
             190, 200, 220, 240];
         24, 0, [90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, ...
             220, 240];
         27, 0, [110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 220, ...
             230, 240, 260];
         30, 0, [130, 140, 150, 160, 180, 190, 200, 210, 220, 230, 240, ...
             250, 260];
         33, 0, [130, 140, 150, 160, 170, 180, 190];
         36, 0, [120, 130, 140, 150, 160, 165, 170, 180, 200, 220]};
       '04014.800', 239, false, '8.8', 'plain', {
         3, 0, [30, 35, 40];
         4, 0, [25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 100];
         5, 0, [25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, ...
             100, 110, 120, 130];
         6, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, ...
             100, 105, 110, 115, 120, 125, 130, 135, 140, 145, 150, 160, ...
             170, 180, 200];
         8, 0, [35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, ...
             105, 110, 115, 120, 125, 130, 135, 140, 145, 150, 160, 170, ...
             180, 190, 200, 210, 220, 230, 240, 250, 260, 280, 300];
         10, 0, [40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 105, ...
             110, 115, 120, 125, 130, 135, 140, 145, 150, 160, 170, 180, ...
             190, 200, 210, 220, 230, 240, 250, 260, 270, 280, 290, 300, ...
             320, 340, 360, 380];
         12, 0, [45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 105, 110, ...
             115, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, ...
             230, 240, 250, 260, 270, 280, 290, 300, 310, 320, 330, 340, ...
             350, 360, 380, 400, 420, 440, 460, 480, 500];
         14, 0, [50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 110, 120, ...
             130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, ...
             250, 260, 270, 280, 290, 300, 310, 320];
         16, 0, [55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 110, 120, 130, ...
             140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, ...
             260, 270, 280, 290, 300, 310, 320, 330, 340, 350, 360, 370, ...
             380, 390, 400, 410, 420, 430, 440, 450, 460, 480, 500];
         18, 0, [65, 70, 75, 80, 85, 90, 95, 100, 110, 120, 130, 140, 150, ...
             160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 260, 270, ...
             280, 290, 300];
         20, 0, [60, 65, 70, 75, 80, 85, 90, 95, 100, 110, 120, 130, 140, ...
             150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 260, ...
             270, 280, 290, 300, 310, 320, 330, 340, 350, 360, 370, 380, ...
             390, 400, 410, 420, 430, 440, 450, 460, 480, 500];
         22, 0, [70, 75, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, ...
             180, 190, 200, 210, 220, 230, 240, 250, 260, 270, 280, 300, ...
             320];
         24, 0, [75, 80, 85, 90, 95, 100, 110, 120, 130, 140, 150, 160, ...
             170, 180, 190, 200, 210, 220, 230, 240, 250, 260, 270, 280, ...
             290, 300, 310, 320, 330, 340, 350, 360, 370, 380, 390, 400, ...
             410, 420, 430, 440, 450, 460, 480, 500, 560, 600, 640];
         27, 0, [75, 80, 85, 90, 100, 110, 120, 130, 140, 150, 160, 170, ...
             180, 190, 200, 210, 220, 230, 240, 250, 260, 270, 280, 290, ...
             300, 320, 340, 360, 380, 400, 420, 440, 460, 480, 500, 520, ...
             540, 560];
         30, 0, [80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, ...
             200, 210, 220, 240, 250, 260, 270, 280, 290, 300, 310, 320, ...
             330, 340, 350, 360, 370, 380, 390, 400, 420, 440, 450, 460, ...
             480, 500, 520, 560, 580, 600];
         33, 0, [90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, ...
             210, 220, 230, 240, 250, 260, 270, 280, 300, 400];
         36, 0, [100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, ...
             210, 220, 230, 240, 250, 260, 270, 280, 290, 300, 310, 320, ...
             330, 340, 350, 360, 380, 400, 420, 440, 460, 480, 500, 540, ...
             580];
         39, 0, [110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 220, ...
             240, 250, 260, 280, 300];
         42, 0, [120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, ...
             240, 250, 260, 280, 300, 320, 340, 360, 380, 400, 420];
         45, 0, [120, 130, 140, 150, 160, 170, 180, 190, 200, 220];
         48, 0, [130, 140, 150, 160, 170, 180, 190, 200, 220, 240, 250, ...
             260, 280, 290, 300, 320, 340, 360, 380, 400, 420, 480];
         52, 0, [150, 200];
         56, 0, [130, 140, 150, 160, 170, 180, 190, 200, 220, 240, 250, ...
             260, 280, 300, 380];
         64, 0, [300]};
       '04014.810', 242, false, '8.8', 'zinc plated', {
         3, 0, [30, 35, 40];
         4, 0, [25, 30, 35, 40, 45, 50, 55, 60, 70, 80];
         5, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 85, 90, 95, 100, ...
             120, 130];
         6, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, ...
             100, 105, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200];
         8, 0, [35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, ...
             110, 115, 120, 125, 130, 135, 140, 145, 150, 160, 170, 180, ...
             190, 200, 210, 220];
         10, 0, [40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 105, ...
             110, 115, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, ...
             220, 230, 240, 250, 260, 270, 280, 300];
         12, 0, [45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 110, 115, ...
             120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, ...
             240, 250, 260, 270, 280, 290, 300, 310, 320, 330];
         14, 0, [50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 110, 120, ...
             130, 140, 150, 160, 170, 180, 190, 200, 220, 240];
         16, 0, [50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 110, 120, ...
             130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, ...
             250, 260, 270, 280, 290, 300, 310, 320, 330, 340, 350, 360, ...
             370, 380, 390, 400, 420, 430, 440];
         18, 0, [65, 70, 75, 80, 90, 95, 100, 110, 120, 130, 140, 150, 160, ...
             170, 180, 190, 200, 220, 230, 240];
         20, 0, [65, 70, 75, 80, 85, 90, 95, 100, 110, 120, 130, 140, 150, ...
             160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 260, 270, ...
             280, 290, 300, 310, 320, 330, 340, 350, 360, 380, 390, 400, ...
             420, 430, 440, 450, 460, 480, 500];
         22, 0, [70, 75, 80, 90, 100, 110, 120, 130, 140, 150, 160, 180, ...
             200, 240, 260, 280, 300];
         24, 0, [75, 80, 85, 90, 95, 100, 110, 120, 130, 140, 150, 160, ...
             170, 180, 190, 200, 210, 220, 230, 240, 250, 260, 270, 280, ...
             300, 310, 320, 330, 340, 350, 360, 380, 390, 400, 410, 420, ...
             430, 440, 450];
         27, 0, [80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, ...
             200, 220, 230, 240, 260, 270, 280, 300, 320];
         30, 0, [80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, ...
             200, 210, 220, 230, 240, 250, 260, 280, 290, 300, 310, 320, ...
             330, 340, 350, 360, 380];
         33, 0, [100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, ...
             210, 220, 240, 260, 280, 300];
         36, 0, [110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, ...
             220, 230, 240, 250, 260, 270, 280, 300, 320, 360, 400];
         39, 0, [140, 150, 160, 170, 180, 190, 200];
         42, 0, [120, 130, 140, 150, 160, 170, 180, 190, 200, 220, 240, ...
             250, 260, 280];
         48, 0, [140, 150, 160, 170, 180, 200, 220, 240]};
       '04014.870', 244, false, '8.8', 'zinc plated 8 TLP', {
         5, 0, [40, 45, 50];
         6, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, ...
             120];
         8, 0, [35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 100, 110, ...
             120, 130, 140, 150];
         10, 0, [40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 110, ...
             120, 130, 140, 150];
         12, 0, [45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 100, 110, 120, ...
             130, 140, 150, 160, 180];
         16, 0, [55, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, 140, 150, ...
             160, 180, 190, 200];
         20, 0, [70, 75, 80, 100, 110, 120, 130, 140, 160, 240];
         24, 0, [75, 80, 90, 100, 110, 120, 130, 140, 150, 180, 200]};
       '04014.428', 245, false, '8.8', 'zinc plated 8 TLP + SL', {
         5, 0, [50];
         6, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 95, 100, ...
             110, 120, 130, 140, 175, 220];
         8, 0, [35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, ...
             110, 115, 120, 130, 140, 150, 160, 180];
         10, 0, [40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 120, ...
             130, 140, 150, 160, 170, 200];
         12, 0, [45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 110, 120, ...
             130, 135, 140, 150, 160, 170, 180, 200];
         14, 0, [50, 55, 60, 70, 75, 80, 85, 90, 100, 110, 120, 130, 140, ...
             150, 160, 220];
         16, 0, [55, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, 140, 150, ...
             160, 170, 180, 190, 200, 220, 230, 260, 280, 300, 320, 360, ...
             480];
         18, 0, [70];
         20, 0, [65, 70, 75, 80, 90, 100, 105, 110, 120, 130, 140, 150, ...
             160, 170, 180, 190, 200, 210, 220, 230, 240, 260, 280, 300];
         24, 0, [75, 80, 90, 100, 110, 120, 130, 140, 150, 180, 200, 300];
         27, 0, [180];
         30, 0, [170]};
       '04014.353', 246, false, '8.8', 'flZn/TL480h', {
         6, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80];
         8, 0, [35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100];
         10, 0, [40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120];
         12, 0, [45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120];
         16, 0, [55, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, 140];
         20, 0, [65, 70, 75, 80, 90, 100, 110, 120, 130, 140, 150, 160, ...
             170, 180];
         24, 0, [75, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180]};
       '04014.820', 246, false, '8.8', 'hot dip galvanized', {
         8, 0, [35, 40, 45, 50, 60, 65, 70, 80, 100];
         10, 0, [40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120];
         12, 0, [45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, ...
             140, 150, 160, 180, 200];
         16, 0, [55, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, 140, 150, ...
             160, 180, 190, 200, 220, 240, 260, 300];
         20, 0, [65, 70, 75, 80, 85, 90, 100, 110, 120, 130, 140, 150, 160, ...
             180, 200, 210, 220, 240, 260, 300];
         24, 0, [75, 80, 85, 90, 95, 100, 110, 120, 130, 140, 150, 160, ...
             180, 200, 220, 240, 260, 300];
         27, 0, [90, 100, 110, 120, 130, 140, 150, 160, 180, 200];
         30, 0, [90, 100, 110, 120, 130, 140, 150, 160, 180, 200, 220, 240, ...
             260, 280, 300];
         33, 0, [120, 130, 140, 180, 200];
         36, 0, [120, 130, 140, 150, 160, 180, 190, 200, 220]};
       '04014.809', 247, false, '8.8', 'plain', {
         8, 0, [35, 40];
         10, 0, [45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 120];
         12, 0, [50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120];
         16, 0, [55, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, 140];
         20, 0, [65, 70, 75, 80, 90, 100, 110, 120, 130, 140, 150, 160, ...
             170, 180];
         24, 0, [75, 80, 90, 100, 110, 120, 140, 150, 160, 180];
         27, 0, [90, 100, 110, 120, 130, 150, 160]};
       '04014.100', 249, false, '10.9', 'plain', {
         5, 0, [25, 30, 35, 40, 45, 50, 55, 60, 65, 75, 80];
         6, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100, 110, 120, ...
             130, 140];
         8, 0, [35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, ...
             130, 140, 150, 160, 170, 180, 190, 200, 220, 240];
         10, 0, [35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, ...
             130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 240, 260];
         12, 0, [40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 110, ...
             120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 240, ...
             260, 280, 300, 320];
         14, 0, [45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, ...
             140, 150, 160, 170, 180, 190, 200, 220];
         16, 0, [55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 110, 120, 130, ...
             140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, ...
             260, 270, 280, 290, 300, 310, 320, 330, 340, 350, 360, 380, ...
             400, 420];
         18, 0, [65, 70, 75, 80, 90, 100, 110, 120, 130, 140, 150, 160, ...
             170, 180, 190, 200, 220, 240, 260, 280, 300, 320];
         20, 0, [65, 70, 75, 80, 85, 90, 95, 100, 110, 120, 130, 140, 150, ...
             160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 260, 270, ...
             280, 290, 300, 310, 320, 330, 340, 350, 360, 370, 380, 390, ...
             400];
         22, 0, [70, 75, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, ...
             180, 200, 220, 230, 240, 260, 280, 300, 320];
         24, 0, [75, 80, 85, 90, 100, 110, 120, 130, 140, 150, 160, 170, ...
             180, 190, 200, 210, 220, 230, 240, 250, 260, 270, 280, 290, ...
             300, 310, 320, 330, 340, 350, 360, 370, 380, 390, 400];
         27, 0, [80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, ...
             200, 210, 220, 230, 240, 250, 260, 270, 280, 290, 300, 320];
         30, 0, [80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, ...
             200, 210, 220, 230, 240, 250, 260, 270, 280, 290, 300, 320, ...
             330, 340, 350, 360, 380, 400];
         33, 0, [100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, ...
             220, 240, 250, 260, 280, 300, 320];
         36, 0, [110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, ...
             220, 230, 240, 250, 260, 270, 280, 290, 300, 320, 340, 360, ...
             380, 400];
         39, 0, [110, 120, 130, 140, 150, 160, 170, 180, 200, 220, 240, ...
             260, 280, 300, 320];
         42, 0, [120, 130, 140, 150, 160, 170, 180, 190, 200, 220, 240, ...
             260, 280, 300, 320];
         45, 0, [130, 140, 150, 160, 180, 200, 220, 240, 260, 280, 300, ...
             320];
         48, 0, [140, 150, 160, 180, 200, 220, 240, 260, 280, 300, 320]};
       '04014.110', 251, false, '10.9', 'zinc plated, baked', {
         6, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100];
         8, 0, [35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 100, 110, 120, 130, ...
             140, 150];
         10, 0, [40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, ...
             130, 140, 150, 160, 170, 180];
         12, 0, [45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 110, 120, ...
             130, 140, 150, 160, 170, 180, 190, 200];
         14, 0, [45, 50, 55, 60, 70, 75, 80, 90, 100, 110, 120, 130, 140, ...
             150];
         16, 0, [55, 60, 65, 70, 75, 80, 85, 90, 100, 110, 120, 130, 140, ...
             150, 160, 170, 180, 190, 200, 210, 230, 240, 250, 260, 270, ...
             280];
         18, 0, [65, 70, 80, 90, 100, 110, 120, 130, 140, 160];
         20, 0, [65, 70, 75, 80, 85, 90, 100, 110, 115, 120, 130, 140, 150, ...
             160, 170, 180, 200, 220, 230, 240, 250, 260, 270, 280, 290, ...
             300, 310, 320, 340];
         24, 0, [75, 80, 90, 100, 110, 120, 130, 140, 145, 150, 160, 170, ...
             180, 190, 200, 220, 240, 250, 260, 270, 280, 290, 300];
         27, 0, [80, 90, 100, 110, 120, 130, 140];
         30, 0, [80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, ...
             200, 210, 220, 230, 240, 250, 260, 270, 280, 300]};
       '04014.354', 252, false, '10.9', 'flZn/TL480h', {
         6, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 80];
         8, 0, [35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 100];
         10, 0, [40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120];
         12, 0, [45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120];
         16, 0, [55, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, 140];
         20, 0, [65, 70, 75, 80, 90, 100, 110, 120, 130, 140, 150, 160, ...
             170, 180];
         24, 0, [75, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, ...
             200, 230]};
       '04014.133', 253, false, '10.9', 'flZnL480h', {
         6, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 80];
         8, 0, [35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 150, 240];
         10, 0, [40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, ...
             140, 180];
         12, 0, [45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, ...
             140, 150, 160, 170];
         14, 0, [55, 60, 100];
         16, 0, [55, 60, 65, 70, 75, 80, 90, 95, 100, 110, 120, 125, 130, ...
             140, 150, 190, 200];
         18, 0, [90, 100];
         20, 0, [65, 70, 75, 80, 90, 95, 100, 105, 110, 120, 130, 140, 150, ...
             160, 170, 180, 200, 290, 340, 360, 380];
         22, 0, [110];
         24, 0, [75, 80, 90, 100, 110, 120, 130, 135, 140, 150, 160, 170, ...
             180, 200, 230, 240, 300]};
       '04014.200', 253, false, '12.9', 'plain', {
         10, 0, [40, 45, 50, 60, 70, 80, 90, 100];
         12, 0, [45, 50, 55, 60, 65, 70, 80, 90, 100, 120, 140];
         14, 0, [60, 80, 100];
         16, 0, [55, 60, 70, 80, 90, 100, 120, 130, 140, 150];
         20, 0, [65, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160];
         24, 0, [80, 90, 100, 110, 120, 130, 140, 150, 160, 180, 200, 220, ...
             240];
         30, 0, [90, 100, 110, 120, 130, 140, 150, 160, 180, 200]};
       '04014.240', 254, false, '12.9', 'flZnL480h', {
         6, 0, [10, 12, 16, 20, 25, 30, 35, 40, 50];
         8, 0, [10, 12, 16, 20, 25, 30, 35, 40, 50, 65, 70, 80];
         10, 0, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100];
         12, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100, ...
             110];
         14, 0, [50];
         16, 0, [25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100, 110, ...
             120];
         20, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, ...
             120, 130, 140, 150, 160, 180, 200];
         22, 0, [50];
         24, 0, [30, 35, 40, 50, 55, 60, 65, 70, 75, 80, 85, 90, 100, 110, ...
             120, 130, 140, 150, 160, 180, 200];
         27, 0, [50, 60, 65, 70, 75, 80, 90, 100, 110, 120, 140];
         30, 0, [40, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, ...
             140, 150, 180, 200];
         33, 0, [90, 100, 110, 120, 130];
         36, 0, [50, 55, 70, 80, 90, 100, 110, 120, 130]};
       '04017.514', 255, true, '5.6', 'zinc plated', {
         6, 0, [12, 16, 20, 25, 30, 35, 40, 50];
         8, 0, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 60, 80];
         10, 0, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80];
         12, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100, ...
             110];
         14, 0, [50];
         16, 0, [25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100, 110, ...
             120];
         20, 0, [35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 130, 140, ...
             150, 160, 180, 200];
         24, 0, [40, 50, 55, 60, 65, 70, 75, 80, 85, 90, 100, 110, 120, ...
             130, 150, 160, 180, 220];
         27, 0, [60, 65, 70, 75, 80, 90, 95, 100, 110, 120, 140];
         30, 0, [60, 65, 70, 75, 80, 90, 100, 110, 120];
         33, 0, [90, 100, 110, 120, 130]};
       '04017.398', 256, true, '25CrMo4', 'plain', {
         12, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100, 110, ...
             120];
         16, 0, [25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100, 110, ...
             120];
         20, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, ...
             120, 130, 140, 150, 160, 180, 200];
         24, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 100, ...
             110, 120, 130, 140, 150, 160, 180, 200];
         27, 0, [60, 65, 70, 75, 80, 90, 100, 110, 120, 140];
         30, 0, [50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, 140, ...
             150, 180, 200];
         33, 0, [90, 100, 110, 120, 130];
         36, 0, [70, 80, 90, 100, 110, 120, 130]};
       '04017.397', 256, true, '25CrMo4', 'zinc plated', {
         12, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100];
         16, 0, [25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100, 110, ...
             120];
         20, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 130, ...
             140, 150, 160, 180, 200];
         24, 0, [35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 100, 110, ...
             120, 130, 150, 160, 180, 220];
         27, 0, [60, 65, 70, 75, 80, 90, 95, 100, 110, 120, 140];
         30, 0, [60, 65, 70, 75, 80, 90, 100, 110, 120];
         33, 0, [100, 110, 120, 130]};
       '04017.800', 257, true, '8.8', 'plain', {
         3, 0, [5, 6, 8, 10, 12, 16, 18, 20, 22, 25, 30, 35, 40, 50, 60];
         4, 0, [6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, ...
             55, 60, 65, 70];
         5, 0, [6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, ...
             55, 60, 65, 70, 80, 90, 100];
         6, 0, [6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 28, 30, 35, 40, 45, ...
             50, 55, 60, 65, 70, 75, 80, 85, 90, 100, 110, 120, 130, 140, ...
             150];
         8, 0, [8, 10, 12, 14, 16, 18, 20, 22, 25, 28, 30, 35, 40, 45, 50, ...
             55, 60, 65, 70, 75, 80, 85, 90, 100, 110, 120, 130, 140, 150, ...
             160, 170, 180, 200];
         10, 0, [10, 12, 16, 18, 20, 22, 25, 28, 30, 35, 40, 45, 50, 55, ...
             60, 65, 70, 75, 80, 85, 90, 100, 110, 120, 130, 140, 150, 160, ...
             170, 180, 190, 200, 220, 240, 300];
         12, 0, [10, 12, 16, 18, 20, 22, 25, 28, 30, 35, 40, 45, 50, 55, ...
             60, 65, 70, 75, 80, 85, 90, 100, 110, 120, 130, 140, 150, 160, ...
             170, 180, 190, 200, 220, 240, 300];
         14, 0, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, ...
             90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 200, 220];
         16, 0, [12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, ...
             80, 85, 90, 95, 100, 110, 120, 130, 140, 150, 160, 170, 180, ...
             190, 200, 210, 220, 230, 240, 250, 260, 280, 300, 320, 340, ...
             400, 500];
         18, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, ...
             90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200];
         20, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, ...
             90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, ...
             210, 220, 230, 240, 250, 260, 280, 300, 360];
         22, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, ...
             120, 130, 140, 150, 160, 170, 180, 190, 200];
         24, 0, [25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, ...
             100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, ...
             220, 230, 240, 250, 260, 280, 300, 320, 500];
         27, 0, [30, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 100, 110, ...
             120, 130, 140, 150, 160, 170, 180, 190, 200, 300];
         30, 0, [35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 100, 110, ...
             120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, ...
             240, 250, 260, 280, 300, 320, 340, 360, 380, 400, 500, 600];
         33, 0, [40, 50, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, 140, ...
             150, 160, 170, 180, 190, 200, 300];
         36, 0, [40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 100, 110, 120, ...
             130, 140, 150, 160, 170, 180, 190, 200, 220, 260, 280, 300, ...
             320, 340, 400, 600];
         39, 0, [80, 90, 100, 110, 120, 130, 140, 150, 160, 180, 190, 200];
         42, 0, [50, 55, 60, 70, 75, 80, 85, 90, 100, 110, 120, 130, 140, ...
             150, 160, 170, 180, 190, 200, 220, 250, 260, 300, 360, 400];
         45, 0, [90, 100, 110, 120, 130, 140, 150];
         48, 0, [60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, ...
             180, 190, 200, 420]};
       '04017.810', 260, true, '8.8', 'zinc plated', {
         3, 0, [5, 6, 8, 10, 12, 16, 20, 25, 30, 35, 40, 50];
         4, 0, [6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, ...
             55, 60, 70];
         5, 0, [6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, ...
             55, 60, 65, 70, 75, 80, 90, 100];
         6, 0, [6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 28, 30, 35, 40, 45, ...
             50, 55, 60, 65, 70, 75, 80, 85, 90, 100, 110, 120, 130, 140, ...
             150];
         8, 0, [8, 10, 12, 14, 16, 18, 20, 22, 25, 28, 30, 35, 40, 45, 50, ...
             55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 110, 120, 130, 140, ...
             150, 160, 170, 180, 190, 200];
         10, 0, [10, 12, 14, 16, 18, 20, 22, 25, 28, 30, 35, 40, 45, 50, ...
             55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 110, 120, 130, 140, ...
             150, 160, 170, 180, 190, 200, 220];
         12, 0, [12, 16, 18, 20, 22, 25, 28, 30, 35, 40, 45, 50, 55, 60, ...
             65, 70, 75, 80, 85, 90, 95, 100, 110, 120, 130, 140, 150, 160, ...
             170, 180, 190, 200, 220, 240, 260];
         14, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, ...
             100, 110, 120, 130, 140, 200];
         16, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, ...
             90, 95, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, ...
             210, 220, 230, 240, 250, 260, 280, 300, 320, 340];
         18, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, ...
             100];
         20, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, ...
             90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, ...
             210, 220, 230, 240, 250, 260, 280, 300, 320, 340, 360, 460];
         22, 0, [40, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120];
         24, 0, [25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, ...
             95, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, ...
             210, 220, 240, 250, 260, 280, 300, 320];
         27, 0, [40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, ...
             130, 140, 150, 160, 180, 200];
         30, 0, [35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 100, 110, ...
             120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 240, ...
             260, 280, 300, 320];
         33, 0, [60, 70, 75, 80, 90, 100, 110, 120, 130, 140, 150, 160, ...
             170, 180, 190, 200];
         36, 0, [50, 55, 60, 70, 75, 80, 85, 90, 100, 110, 120, 130, 140, ...
             150, 160, 170, 180, 190, 200, 220, 280];
         39, 0, [80, 90, 100, 110, 120, 130, 140, 150, 160, 180, 200];
         42, 0, [50, 60, 70, 75, 80, 90, 100, 110, 120, 130, 140, 150, 160, ...
             170, 180, 190, 200, 220];
         48, 0, [60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 200]};
       '04017.317', 262, true, '8.8', 'zinc plated 8 TLP', {
         3, 0, [8, 10, 12, 16, 20, 25];
         4, 0, [6, 10, 12, 16, 20, 25, 30, 35, 40];
         5, 0, [8, 10, 12, 16, 20, 25, 30, 35, 40, 50];
         6, 0, [8, 10, 12, 16, 18, 20, 30, 35, 40, 45, 50, 55, 60, 65, 70, ...
             75, 80];
         8, 0, [10, 12, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, 65, ...
             70, 75, 80, 90, 100, 110];
         10, 0, [12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, ...
             90, 100, 110, 120, 130];
         12, 0, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, ...
             90, 100, 120];
         14, 0, [30, 35, 40, 45, 50];
         16, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, ...
             90, 100, 120, 130, 150];
         20, 0, [30, 35, 40, 45, 50, 60, 65, 70, 75, 80, 90, 100, 110, 120];
         24, 0, [50, 55, 60, 65, 70, 75, 80, 90, 100, 110];
         30, 0, [100, 120]};
       '04017.428', 263, true, '8.8', 'zinc plated 8 TLP + SL', {
         3, 0, [8, 10, 12, 16, 20, 25];
         4, 0, [6, 8, 10, 12, 16, 20, 25, 30, 35, 40];
         5, 0, [8, 10, 12, 16, 20, 25, 30, 35, 40, 50];
         6, 0, [8, 10, 12, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             65, 70, 75, 80];
         8, 0, [10, 12, 14, 16, 18, 20, 22, 25, 28, 30, 35, 40, 45, 50, 55, ...
             60, 65, 70, 75, 80, 90, 100, 110];
         10, 0, [12, 16, 20, 25, 28, 30, 35, 40, 45, 50, 55, 60, 65, 70, ...
             80, 85, 90, 100, 110, 120, 130, 140, 180];
         12, 0, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, ...
             85, 90, 100, 110, 120, 130, 140, 150, 200, 220];
         14, 0, [20, 30, 35, 40, 45, 50, 60, 150];
         16, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, ...
             90, 100, 110, 120, 130, 140, 150, 180, 200];
         18, 0, [100];
         20, 0, [30, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 100, 110, ...
             120, 150];
         24, 0, [50, 55, 60, 65, 70, 75, 80, 90, 100, 110];
         30, 0, [100, 120]};
       '04017.353', 264, true, '8.8', 'flZn/TL480h', {
         6, 0, [10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60];
         8, 0, [12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70];
         10, 0, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, ...
             100];
         12, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, ...
             100];
         16, 0, [25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, ...
             110, 120];
         20, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, ...
             120];
         24, 0, [40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120]};
       '04017.820', 265, true, '8.8', 'hot dip galvanized', {
         6, 0, [12, 16, 20, 25, 30, 35, 40];
         8, 0, [10, 12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90, ...
             100];
         10, 0, [12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, ...
             90, 100];
         12, 0, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, ...
             100, 120];
         16, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 85, 90, ...
             100, 110, 120, 130, 140, 150, 160, 170, 180, 200, 220, 240, ...
             260, 280, 300];
         20, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, ...
             120, 130, 140, 150, 160, 180];
         24, 0, [40, 45, 50, 55, 60, 65, 70, 80, 90, 100, 110, 120, 130, ...
             140, 150, 180];
         30, 0, [60, 70, 80, 90, 100, 120, 130, 140, 150, 160, 170, 180, ...
             190, 200]};
       '04017.809', 265, true, '8.8', 'plain', {
         8, 0, [12, 16, 20, 25, 30, 35, 40, 45, 50, 70];
         10, 0, [16, 20, 25, 30, 35, 40, 45, 50, 60, 65, 70, 80, 90, 100];
         12, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, ...
             100];
         16, 0, [25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100];
         20, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 120];
         24, 0, [40, 45, 50, 55, 60, 65, 70, 80, 90, 100, 120];
         27, 0, [65, 90, 100]};
       '04017.100', 267, true, '10.9', 'plain', {
         5, 0, [10, 12, 14, 16, 18, 22, 25, 30, 35];
         6, 0, [10, 12, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, 70, ...
             80];
         8, 0, [12, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, ...
             75, 80, 90, 100, 110, 120, 130, 140, 150, 180];
         10, 0, [12, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, 65, ...
             70, 75, 80, 90, 100, 110, 120, 130, 140, 150, 200];
         12, 0, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, ...
             90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 200];
         14, 0, [25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, ...
             110, 120, 160, 200];
         16, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, ...
             100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 220, ...
             240, 260, 280, 300];
         18, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 120, ...
             130, 160, 200];
         20, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, ...
             120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 240, ...
             260, 280, 300];
         22, 0, [50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, 140, ...
             150, 200];
         24, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, ...
             120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 240, ...
             260, 280, 300];
         27, 0, [50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, 140, ...
             150, 160, 180, 200];
         30, 0, [40, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, ...
             140, 150, 160, 170, 180, 190, 200];
         33, 0, [100, 160, 200];
         36, 0, [40, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, ...
             140, 150, 160, 170, 180, 190, 200];
         42, 0, [100, 110, 130, 200]};
       '04017.110', 269, true, '10.9', 'zinc plated, baked', {
         6, 0, [10, 12, 16, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60];
         8, 0, [12, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, 70, 75, ...
             80, 100];
         10, 0, [12, 16, 18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 75, ...
             80, 90, 100, 110];
         12, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, ...
             100, 110, 120, 130, 140, 150, 160, 180, 200];
         14, 0, [30, 35, 40, 45, 50, 60, 65, 70, 80, 90];
         16, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, ...
             100, 110, 120, 140, 150, 160, 170, 180, 190, 200, 220, 240, ...
             260, 280, 300];
         18, 0, [40, 45, 50, 55, 60, 70];
         20, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, ...
             120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 240, ...
             260]};
       '04017.354', 270, true, '10.9', 'flZn/TL480h', {
         6, 0, [10, 12, 16, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60];
         8, 0, [12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70];
         10, 0, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100];
         12, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100];
         16, 0, [25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, ...
             110, 120];
         20, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, ...
             120];
         24, 0, [40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, ...
             160]};
       '04017.133', 270, true, '10.9', 'flZnL480h', {
         6, 0, [10, 12, 16, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60];
         8, 0, [12, 16, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, 70];
         10, 0, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, ...
             100];
         12, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100, ...
             110, 130];
         14, 0, [45];
         16, 0, [25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, ...
             110, 120];
         18, 0, [80];
         20, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, ...
             120];
         24, 0, [40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120];
         30, 0, [110]};
       '04017.200', 271, true, '12.9', 'plain', {
         6, 0, [12, 16, 20, 25, 30];
         8, 0, [16, 20, 25, 30, 35, 40, 45, 50, 60];
         10, 0, [20, 25, 30, 35, 40, 45, 50, 60];
         12, 0, [25, 30, 35, 40, 45, 50, 60];
         14, 0, [35, 40, 50];
         16, 0, [30, 35, 40, 45, 50, 60, 70, 80, 90, 100];
         20, 0, [40, 45, 50, 55, 60, 70, 80, 90, 100];
         24, 0, [60, 70, 80, 90, 100]};
       '04017.270', 271, true, '12.9', 'flZnL480h', {
         6, 0, [12, 16, 20, 25, 30];
         8, 0, [16, 20, 25, 30, 35, 40];
         10, 0, [20, 25, 30, 35, 40, 50, 60];
         12, 0, [25, 30, 35, 40, 50, 60];
         16, 0, [30, 35, 40, 45, 50, 60];
         20, 0, [40, 45, 50, 60]};
       '04014.920', 529, false, 'A2-70', 'plain', {
         5, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100];
         6, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 100, ...
             110, 120, 130, 140, 150];
         8, 0, [35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 100, 110, ...
             120, 130, 140, 150, 160, 170, 180, 190, 200];
         10, 0, [40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 100, 110, 120, ...
             130, 140, 150, 160, 170, 180, 190, 200, 210, 220];
         12, 0, [40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 100, 105, 110, ...
             120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, ...
             240, 250];
         14, 0, [50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, 140, ...
             150, 160];
         16, 0, [55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 110, 120, 130, ...
             140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250];
         18, 0, [65, 70, 75, 80, 90, 100, 110, 120, 130, 140, 150, 160];
         20, 0, [65, 70, 75, 80, 85, 90, 100, 110, 120, 130, 140, 150, 160, ...
             170, 180, 190, 200, 210, 220, 230, 240, 250];
         22, 0, [80, 90, 100, 110, 120, 130, 140, 150, 160, 180, 200];
         24, 0, [75, 80, 85, 90, 95, 100, 110, 120, 130, 140, 150, 160, ...
             170, 180, 190, 200, 210, 220, 230, 240, 250];
         27, 0, [90, 100, 110, 120, 130, 140, 150]};
       '04014.920', 529, false, 'A2', 'plain', {
         6, 0, [160, 170, 180];
         8, 0, [220];
         12, 0, [260, 280, 300, 320];
         14, 0, [170, 180, 200];
         16, 0, [260, 270, 280, 290, 300];
         20, 0, [260, 270, 280, 290, 300];
         24, 0, [260, 280, 290, 300];
         27, 0, [160, 170, 180, 200, 210, 220, 230, 240, 250];
         30, 0, [90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, ...
             210, 220, 240, 250];
         33, 0, [100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, ...
             210, 220, 230, 240, 250];
         36, 0, [100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, ...
             210, 220, 230, 240, 250]};
       '04014.927', 530, false, 'A2-70', 'plain', {
         10, 0, [50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, 140, ...
             150];
         12, 0, [50, 55, 60, 65, 70, 75, 80, 85, 90, 100, 110, 120, 130, ...
             140, 150];
         16, 0, [50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 110, 120, ...
             130, 140, 150, 160, 170, 180];
         20, 0, [65, 70, 75, 80, 85, 90, 100, 110, 120, 130, 140, 150, 160, ...
             170, 180, 190, 200, 220]};
       '04014.940', 531, false, 'A4-70', 'plain', {
         5, 0, [30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100];
         6, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100, 110, 120, ...
             130, 140, 150];
         8, 0, [35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 100, 110, ...
             120, 130, 140, 150, 160, 170, 180, 190, 200];
         10, 0, [40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 95, 100, 110, 120, ...
             130, 140, 150, 160, 170, 180, 190, 200, 210, 220];
         12, 0, [45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 110, 120, ...
             130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 240, 250];
         14, 0, [50, 55, 60, 65, 70, 80, 90, 100, 110, 120, 130, 140, 150, ...
             160];
         16, 0, [55, 60, 65, 70, 75, 80, 85, 90, 100, 110, 120, 130, 140, ...
             150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250];
         18, 0, [70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, ...
             190, 200];
         20, 0, [65, 70, 75, 80, 85, 90, 100, 110, 120, 130, 140, 150, 160, ...
             170, 180, 190, 200, 210, 220, 230, 240, 250];
         22, 0, [70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, ...
             200];
         24, 0, [75, 80, 85, 90, 100, 110, 120, 130, 140, 150, 160, 170, ...
             180, 190, 200, 210, 220, 230, 240, 250];
         27, 0, [90, 100, 110, 120, 130, 140, 150]};
       '04014.940', 531, false, 'A4', 'plain', {
         6, 0, [160, 170];
         8, 0, [220];
         12, 0, [260, 280, 300, 320, 340, 360];
         14, 0, [170, 180, 190, 200];
         16, 0, [260, 270, 280, 290, 300, 320, 340, 360, 380, 400];
         20, 0, [260, 270, 280, 290, 300];
         24, 0, [260, 270, 280, 290, 300];
         27, 0, [160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 260, ...
             280];
         30, 0, [90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, ...
             210, 220, 240, 250, 260, 280, 300];
         33, 0, [90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, ...
             210, 220, 230, 240, 250];
         36, 0, [100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, ...
             220, 230, 240, 250]};
       '04014.947', 532, false, 'A4-70', 'plain', {
         10, 0, [50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, 140, ...
             150];
         12, 0, [50, 55, 60, 65, 70, 75, 80, 85, 90, 100, 110, 120, 140, ...
             150];
         16, 0, [55, 60, 65, 70, 75, 80, 85, 90, 100, 110, 120, 130, 140, ...
             150, 160, 170, 180, 200];
         20, 0, [65, 70, 75, 80, 90, 100, 110, 120, 130, 140, 150, 160, ...
             170, 180, 190, 200];
         24, 0, [90, 100, 110, 120, 150]};
       '04014.948', 533, false, 'A4-80', 'plain', {
         5, 0, [25, 30, 35, 40, 50, 60, 70, 80];
         6, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100, 110, 120, ...
             130, 140, 150];
         8, 0, [35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, ...
             130, 140, 150, 160];
         10, 0, [40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, ...
             130, 140, 150, 160, 170, 180, 190, 200, 220];
         12, 0, [45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, ...
             140, 150, 160, 170, 180, 190, 200, 220];
         14, 0, [50, 55, 60, 70, 80, 90, 100, 110];
         16, 0, [55, 60, 65, 70, 75, 80, 85, 90, 100, 110, 120, 130, 140, ...
             150, 160, 170, 180, 190, 200, 220];
         20, 0, [65, 70, 75, 80, 90, 100, 110, 120, 130, 140, 150, 160, ...
             170, 180, 190, 200, 220];
         24, 0, [80, 90, 100, 110, 120, 130, 150, 160, 170, 180, 190, 200, ...
             220]};
       '04014.950', 534, false, 'A5', 'plain', {
         6, 0, [30, 35, 40, 50];
         8, 0, [70, 80];
         10, 0, [60, 70, 80, 90, 100, 110, 120];
         12, 0, [70, 80, 90, 100, 110, 120];
         16, 0, [55, 60, 65, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160];
         20, 0, [65, 70, 80, 85, 90, 100, 110, 120, 130, 140, 150, 160, ...
             170, 180]};
       '04017.920', 534, true, 'A2-70', 'plain', {
         5, 0, [10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             70, 80];
         6, 0, [10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             65, 70, 75, 80, 90, 100, 110, 120];
         8, 0, [10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             65, 70, 75, 80, 85, 90, 100, 110, 120, 130, 140, 150, 160, ...
             170, 180, 190, 200];
         10, 0, [12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             65, 70, 75, 80, 85, 90, 100, 110, 120, 130, 140, 150, 160, ...
             170, 180, 190, 200];
         12, 0, [16, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, ...
             80, 85, 90, 95, 100, 110, 120, 130, 140, 150, 160, 170, 180, ...
             190, 200];
         14, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, ...
             100, 110, 120, 130, 140, 150];
         16, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, ...
             90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200];
         18, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, ...
             120, 130, 140, 150];
         20, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, ...
             100, 110, 120, 130, 140, 150, 160, 170, 180, 200];
         22, 0, [30, 35, 40, 50, 55, 60, 65, 70, 80, 90, 100, 110, 120, ...
             130, 140];
         24, 0, [40, 45, 50, 55, 60, 65, 70, 80, 90, 100, 110, 120, 130, ...
             140, 150, 160, 170, 180, 190, 200];
         27, 0, [50, 55, 60, 65, 70, 80, 90, 100, 110, 120, 130, 140, 150]};
       '04017.920', 534, true, 'A2', 'plain', {
         3, 0, [6, 8, 10, 12, 14, 16, 20, 25, 30, 35, 40];
         4, 0, [6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, ...
             60];
         5, 0, [6, 8];
         6, 0, [6, 8];
         8, 0, [8];
         10, 0, [10];
         20, 0, [220];
         30, 0, [60, 65, 70, 80, 90, 100, 110, 120, 130, 140, 150];
         33, 0, [70, 80, 90, 100, 110, 120, 130, 140, 150];
         36, 0, [80, 90, 100, 110, 120, 130, 140, 150]};
       '04017.927', 536, true, 'A2-70', 'plain', {
         10, 0, [16, 20, 25, 30, 35, 40, 45, 50];
         12, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80];
         16, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 110, 120];
         20, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 120]};
       '04017.940', 536, true, 'A4-70', 'plain', {
         5, 0, [10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             70, 80];
         6, 0, [10, 12, 14, 16, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, 65, ...
             70, 75, 80, 90, 100, 110, 120];
         8, 0, [10, 12, 14, 16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, ...
             65, 70, 75, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, ...
             180, 200];
         10, 0, [12, 14, 16, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, 65, ...
             70, 75, 80, 85, 90, 95, 100, 110, 120, 130, 140, 150, 160, ...
             170, 180, 200];
         12, 0, [16, 18, 20, 22, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, ...
             75, 80, 85, 90, 95, 100, 110, 120, 130, 140, 150, 160, 170, ...
             180, 190, 200];
         14, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, ...
             100, 110, 120, 130, 140, 150];
         16, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, ...
             100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200];
         18, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, ...
             120, 130, 150];
         20, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, ...
             120, 130, 140, 150, 160, 170, 180, 190, 200];
         22, 0, [40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, ...
             130, 140, 150];
         24, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, ...
             120, 130, 140, 150, 160, 170, 180, 190, 200];
         27, 0, [50, 55, 60, 65, 70, 80, 90, 100, 110, 120, 130, 140, 150]};
       '04017.940', 536, true, 'A4', 'plain', {
         3, 0, [5, 6, 8, 10, 12, 16, 18, 20, 25, 30, 35, 40];
         4, 0, [6, 8, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, 60];
         5, 0, [6, 8];
         6, 0, [8];
         8, 0, [8];
         10, 0, [10];
         14, 0, [160];
         20, 0, [20];
         22, 0, [30];
         30, 0, [40, 50, 60, 65, 70, 80, 90, 100, 110, 120, 130, 140, 150];
         33, 0, [70, 80, 90, 120, 130, 140, 150];
         36, 0, [80, 90, 100, 110, 120, 130, 140, 150]};
       '04017.947', 538, true, 'A4-70', 'plain', {
         5, 0, [10, 12, 16, 20];
         6, 0, [8, 10, 12, 16, 20, 25, 30];
         8, 0, [12, 16, 20, 25, 30, 35, 40, 45];
         10, 0, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80];
         12, 0, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, ...
             90];
         16, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, ...
             100];
         20, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 120, ...
             160];
         24, 0, [110, 130]};
       '04017.948', 538, true, 'A4-80', 'plain', {
         5, 0, [10, 16, 20, 25, 30, 35, 40, 50, 60, 70];
         6, 0, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, ...
             100, 110, 120];
         8, 0, [10, 12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, ...
             90, 100, 110, 120, 130, 140, 150, 160];
         10, 0, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, ...
             90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200];
         12, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, ...
             100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200];
         14, 0, [25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90];
         16, 0, [25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, ...
             110, 120, 130, 140, 150, 160, 170, 180, 190, 200];
         20, 0, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, ...
             120, 130, 140, 150, 160, 170, 180, 190, 200];
         24, 0, [50, 55, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, ...
             170, 180, 190, 200]};
       '04017.941', 539, true, 'BUMAX88', 'plain', {
         5, 0, [10, 12, 16, 20, 25, 30, 35, 40];
         6, 0, [16, 20, 25, 30, 35, 40, 45, 50];
         8, 0, [16, 20, 25, 30, 35, 40, 45, 50, 60, 70];
         10, 0, [16, 20, 25, 30, 35, 40, 45];
         12, 0, [45, 70, 80, 90, 100];
         14, 0, [30, 40, 50, 60, 70];
         16, 0, [40, 45, 50, 60, 70, 80];
         20, 0, [45, 50, 55, 60, 65, 70, 75, 80, 100];
         24, 0, [50, 65, 70, 80, 90];
         30, 0, [60, 70, 80, 90, 100]};
       '04017.942', 539, true, 'BUMAX109', 'plain', {
         6, 0, [16, 20, 25, 30];
         8, 0, [20, 25, 30, 35, 40, 45, 50, 55, 60];
         10, 0, [30, 40];
         12, 0, [30, 40];
         16, 0, [40, 50, 60];
         20, 0, [40, 50, 60, 70, 80]};
       '04017.950', 540, true, 'A5', 'plain', {
         6, 0, [10, 20, 25, 30, 40, 50];
         8, 0, [25, 30, 35, 40, 50, 60];
         10, 0, [20, 25, 30, 35, 40, 45, 50];
         12, 0, [20, 25, 30, 35, 40, 45, 50, 60];
         16, 0, [25, 30, 35, 40, 45, 50, 55, 60, 65];
         20, 0, [35, 40, 45, 50, 60, 70]};
       '08765.800', 384, false, '8.8', 'plain', {
         8, 1, [30, 35, 40, 45, 50, 60, 70, 80];
         10, 1, [35, 40, 45, 50, 60, 65, 70, 80, 90, 100];
         10, 1.25, [35, 40, 45, 50, 55, 60, 70, 80, 90, 100, 110, 120, 130];
         12, 1.25, [35, 40, 45, 50, 60, 65, 70, 80, 90, 100, 110, 120, 130];
         12, 1.5, [35, 40, 45, 50, 60, 65, 70, 75, 80, 90, 100, 110, 120, ...
             130, 140];
         14, 1.5, [50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, 140];
         16, 1.5, [50, 55, 60, 65, 70, 75, 80, 85, 90, 100, 110, 120, 130, ...
             140, 150, 160];
         18, 1.5, [60, 65, 70, 75, 80, 90, 100, 120, 140, 150];
         20, 1.5, [60, 65, 70, 75, 80, 85, 90, 100, 110, 120, 130, 140, ...
             150, 160, 170, 180, 200];
         20, 2, [60, 65, 70, 80, 100, 120];
         24, 2, [70, 80, 90, 100, 110, 120, 130, 140, 150];
         30, 2, [90, 100, 110, 120, 130, 140, 150, 160];
         36, 3, [110, 120, 130, 140, 150, 160];
         42, 3, [140, 160, 180, 200]};
       '08765.810', 385, false, '8.8', 'zinc plated', {
         12, 1.25, [50, 60, 70, 80, 90, 100, 110, 120, 130];
         12, 1.5, [45, 50, 60, 65, 70, 80, 90, 100, 110, 120, 130, 140];
         14, 1.5, [50, 60, 65, 70, 75, 80, 90, 100];
         16, 1.5, [55, 60, 65, 70, 75, 80, 85, 90, 100, 110, 120, 130, 140, ...
             150, 160];
         20, 1.5, [65, 70, 75, 80, 90, 100, 110, 120, 140, 150, 160, 180, ...
             200];
         24, 2, [80, 90, 100, 120, 130, 140, 150, 160, 170]};
       '08765.100', 386, false, '10.9', 'plain', {
         8, 1, [30, 35, 40, 45, 50, 60, 70, 80];
         10, 1, [35, 40, 45, 50, 55, 60, 70, 80, 90, 100];
         10, 1.25, [35, 40, 45, 50, 55, 60, 70, 80, 90, 100, 110];
         12, 1.25, [35, 40, 45, 50, 60, 65, 70, 80, 90, 100, 110, 120, 130];
         12, 1.5, [35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, 110, ...
             120, 130, 140];
         14, 1.5, [50, 55, 60, 65, 70, 75, 80, 90, 100, 110, 120, 130, 140, ...
             160];
         16, 1.5, [50, 55, 60, 65, 70, 75, 80, 85, 90, 100, 110, 115, 120, ...
             130, 140, 150, 160];
         18, 1.5, [60, 65, 70, 75, 80, 90, 100, 120, 140, 150];
         20, 1.5, [60, 65, 70, 75, 80, 85, 90, 100, 110, 120, 130, 140, ...
             150, 160, 170, 180, 200];
         20, 2, [60, 65, 70, 80, 120];
         22, 1.5, [70, 80, 90, 100, 110, 120, 130, 140];
         24, 2, [70, 80, 90, 100, 110, 120, 130, 150];
         30, 2, [60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160];
         36, 3, [110, 120, 130, 140, 150, 160];
         42, 3, [140, 160, 180, 200]};
       '08765.110', 387, false, '10.9', 'zinc plated, baked', {
         10, 1, [45];
         12, 1.5, [45, 50, 60, 65, 70];
         14, 1.5, [50, 55, 60, 65, 70, 75, 80, 90, 100, 110];
         16, 1.5, [60, 70, 75, 80, 90, 100, 110, 120, 130];
         20, 1.5, [80, 90, 100, 120]};
       '08676.800', 372, true, '8.8', 'plain', {
         8, 1, [20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90, 100];
         10, 1, [16, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90, 100];
         10, 1.25, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, ...
             100];
         12, 1.25, [20, 25, 30, 35, 40, 45, 50, 60, 65, 70, 80, 90, 100, ...
             110, 120, 130];
         12, 1.5, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, ...
             100, 110, 120, 130, 140];
         14, 1.5, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, ...
             100, 110, 120, 130, 140];
         16, 1.5, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, ...
             90, 100, 110, 120, 130, 140, 150];
         18, 1.5, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, ...
             120, 140, 150];
         20, 1.5, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 100, ...
             110, 120, 130, 140, 150];
         20, 2, [50, 55, 60, 65, 70, 80, 100, 120];
         22, 1.5, [50, 60, 70];
         24, 2, [50, 60, 70, 80, 90, 100, 110, 120, 130, 150];
         30, 2, [60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160];
         36, 3, [80, 90, 100, 110, 120, 130, 140, 150, 160];
         42, 3, [140, 160, 180, 200]};
       '08676.810', 373, true, '8.8', 'zinc plated', {
         8, 1, [20];
         10, 1, [16, 20, 25, 30, 40, 50];
         10, 1.25, [20, 25, 30, 35, 40, 45, 50];
         12, 1.25, [20, 25, 30, 35, 40, 45, 65, 70];
         12, 1.5, [20, 25, 30, 35, 40, 45, 50, 55, 60, 80];
         14, 1.5, [25, 30, 35, 40, 45, 50, 60, 70, 80, 90, 100];
         16, 1.5, [30, 35, 40, 45, 50, 60, 70, 80, 90, 100];
         18, 1.5, [40, 50, 55, 60, 70, 80];
         20, 1.5, [30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100, 110];
         24, 2, [50, 90, 100]};
       '08676.100', 373, true, '10.9', 'plain', {
         8, 1, [20, 25, 30, 35, 40, 45, 50, 60, 70, 80];
         10, 1, [20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90, 100];
         10, 1.25, [16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, ...
             100];
         12, 1.25, [20, 25, 30, 35, 40, 45, 50, 60, 65, 70, 80, 90, 100, ...
             110, 120, 130];
         12, 1.5, [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, ...
             100, 110, 120, 130, 140];
         14, 1.5, [25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 90, 100, ...
             110, 120, 130, 140];
         16, 1.5, [25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, ...
             100, 110, 120, 130, 140, 150];
         18, 1.5, [30, 35, 40, 45, 50, 55, 60, 65, 75, 80, 90, 100, 120, ...
             140, 150];
         20, 1.5, [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 100, ...
             110, 120, 130, 140, 150];
         20, 2, [50, 55, 60, 65, 70, 80, 100, 120];
         24, 2, [50, 60, 70, 80, 90, 100, 110, 120, 130, 150];
         30, 2, [60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160];
         36, 3, [80, 90, 100, 110, 120, 130, 140, 150, 160, 180, 200]};
       '08676.110', 374, true, '10.9', 'zinc plated, baked', {
         8, 1, [20, 25, 30, 35];
         10, 1, [20, 30, 35, 40, 45];
         10, 1.25, [30];
         12, 1.25, [35, 40];
         12, 1.5, [30, 35, 40, 45, 50, 55, 60, 70, 80];
         14, 1.5, [25, 30, 35, 40, 45, 50, 55, 60, 70, 80];
         16, 1.5, [25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90];
         20, 1.5, [40, 45, 50, 55, 60]};
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
  P(P == 0) = NaN;
  h = lookup (d, P);
  P(isnan (P)) = h(isnan (P),2);

  full = [A{a,3}]';
  b = boltform (h, l);
  b(full) = l(full);
  [name, standard] = designate (h, P, l, b, full);
  grade = repmat ({'B'}, n, 1);
  grade(d <= 24 & l <= min (10 * d, 150)) = {'A'};
  source = arrayfun (@(p) sprintf ("REYHER, The Catalogue, 2020.04, p. %d", ...
                                   p), [A{:,2}]', 'UniformOutput', false);

  F = [name, standard, num2cell([d, P, l, b, h(:,[12, 10])]), grade, ...
       A(a,4:5), repmat({'REYHER'}, n, 1), A(a,1), source(a)]';
  E = cell2struct (F, {'designation', 'standard', 'd', 'P', 'l', 'b', ...
                       's', 'k', 'grade', 'class', 'finish', 'maker', ...
                       'article', 'source'}, 1)';
  [~, k] = sortrows ([d, P, l], [1, 2, 3]);
  E = E(k);

endfunction

function S = shape (d, P, L, B, full, detailed)

  h = lookup (d, P);
  if (isnan (h(1)))
    if (isnan (P))
      error ("parts.screw.hex: ISO 4014 and 4017 define no M%g head.", d);
    else
      error ("parts.screw.hex: ISO 8765 and 8676 define no M%gx%g head.", ...
             d, P);
    endif
  endif
  P = h(2);
  if (full)
    B = L;
  elseif (isempty (B))
    B = boltform (h, L);
  elseif (! isnumeric (B) || ! isreal (B) || ! isscalar (B) || B <= 0
          || B > L)
    error ("parts.screw.hex: 'ThreadLength' must be a length from 0 to L.");
  endif
  [name, ~, tname] = designate (h, P, L, B, full);

  s = h(12);
  k = h(10);
  a = pi / 3 * (0:5)';
  X = geom.Region (s / sqrt (3) * [cos(a), sin(a)]);
  if (detailed)
    c = h(6);
    dw = h(8);
    if (isnan (dw) || ! (d <= 24 && L <= min (10 * d, 150)))
      dw = h(9);
    endif
    X.UCS = geom.UCS ([0, 0, 1], [0, 0, c]);
    head = solid.extrude (X, k - c);
    ## The chamfer at 30 degrees to the top, from the flats outwards
    t = (s - s / 2) * tand (30);
    R = geom.Region ([0, c; s, c; s, k - t; s / 2, k; 0, k]);
    R.UCS = geom.UCS ([0, -1, 0], [0, 0, 0]);
    head = intersect (head, solid.revolve (R));
    r = h(11);
    R = geom.Region ([0, -L, 0; d / 2, -L, 0; d / 2, -r, -tan(pi/8);
                      d / 2 + r, 0, 0; dw / 2, 0, 0; dw / 2, c, 0; 0, c, 0]);
    R.UCS = geom.UCS ([0, -1, 0], [0, 0, 0]);
    S = union (head, solid.revolve (R));
    if (full)
      B = L - h(13);
    endif
    S = thread (S, [0, 0, -L], tname, B, 'Direction', [0, 0, 1], ...
                'Custom', true);
  else
    head = solid.extrude (X, k);
    S = union (head, solid.cylinder (d / 2, L, geom.UCS ([0, 0, 1], ...
                                                         [0, 0, -L])));
  endif
  S.Name = name;

endfunction

## ISO 4162:1990, small series, a row for each size: d, P, b for 125 or
## less, up to 200 and longer, c min, dc max, dw min, k max, s max, the
## longest length threaded to the head, the shortest and longest length
function G = flanges ()

  G = [5, 0.8, 16, NaN, NaN, 1, 11.4, 9.4, 5.6, 7, 20, 10, 50;
       6, 1, 18, NaN, NaN, 1.1, 13.6, 11.6, 6.8, 8, 25, 12, 60;
       8, 1.25, 22, 28, NaN, 1.2, 17, 14.9, 8.5, 10, 30, 16, 80;
       10, 1.5, 26, 32, NaN, 1.5, 20.8, 18.7, 9.7, 13, 35, 20, 100;
       12, 1.75, 30, 36, NaN, 1.8, 24.7, 22.5, 11.9, 15, 40, 25, 120;
       14, 2, 34, 40, NaN, 2.1, 28.6, 26.4, 12.9, 18, 45, 30, 140;
       16, 2, 38, 44, 57, 2.4, 32.8, 30.6, 15.1, 21, 50, 35, 160];

endfunction

function S = flanged (d, P, L, B, detailed)

  G = flanges ();
  g = G(G(:,1) == d,:);
  if (isempty (g))
    error ("parts.screw.hex: ISO 4162 defines no M%g flange bolt.", d);
  endif
  if (isnan (P))
    P = g(2);
  endif
  r = 3 + (L > 125) + (L > 200);
  form = g(r);
  if (isnan (form))
    form = 2 * d + [6, 12, 25](r - 2);
  endif
  if (L <= g(11))
    form = L;
  endif
  if (isempty (B))
    B = form;
  elseif (! isnumeric (B) || ! isreal (B) || ! isscalar (B) || B <= 0
          || B > L)
    error ("parts.screw.hex: 'ThreadLength' must be a length from 0 to L.");
  endif
  series = [10, 12, 16, 20:5:70, 80:10:160];
  standard = '';
  if (P == g(2) && any (series == L) && L >= g(12) && L <= g(13)
      && B == form)
    standard = 'ISO 4162';
  endif
  [name, tname] = parts.__designation__ ('Hexagon flange bolt', standard, ...
                                         d, P, L, B);

  s = g(10);
  k = g(9);
  c = g(6);
  dc = g(7);
  a = pi / 3 * (0:5)';
  X = geom.Region (s / sqrt (3) * [cos(a), sin(a)]);
  head = solid.extrude (X, k);
  if (detailed)
    ## The chamfer at 30 degrees from the smallest circle the standard
    ## allows, 0.85 s; the flange's top at 25 degrees, c thick at dw
    t = (s - 0.85 * s / 2) * tand (30);
    R = geom.Region ([0, 0; s, 0; s, k - t; 0.85 * s / 2, k; 0, k]);
    R.UCS = geom.UCS ([0, -1, 0], [0, 0, 0]);
    head = intersect (head, solid.revolve (R));
    e = c - (dc - g(8)) / 2 * tand (25);
    rc = s / sqrt (3);
    top = c + (g(8) / 2 - rc) * tand (25);
    R = geom.Region ([0, 0; dc / 2, 0; dc / 2, e; rc, top; 0, top]);
  else
    R = geom.Region ([0, 0; dc / 2, 0; dc / 2, c; 0, c]);
  endif
  R.UCS = geom.UCS ([0, -1, 0], [0, 0, 0]);
  S = union (head, solid.revolve (R), ...
             solid.cylinder (d / 2, L, geom.UCS ([0, 0, 1], [0, 0, -L])));
  if (detailed)
    S = thread (S, [0, 0, -L], tname, B, 'Direction', [0, 0, 1], ...
                'Custom', true);
  endif
  S.Name = name;

endfunction

%!test  # the catalogue, every article in every size and length
%! C = parts.screw.hex ('data');
%! assert_equal (numel (C), 8892);
%!test  # an article as REYHER lists it
%! C = parts.screw.hex ('data', 'M12', 80);
%! E = C(strcmp ({C.article}, '04014.800'));
%! assert_equal ({E.designation, E.grade, E.class, E.finish}, ...
%!               {'Hexagon head bolt ISO 4014 - M12 x 80', 'A', '8.8', ...
%!                'plain'});
%!test  # its sizes
%! C = parts.screw.hex ('data', 'M12', 80);
%! E = C(strcmp ({C.article}, '04014.800'));
%! assert_equal ([E.d, E.P, E.l, E.b, E.s, E.k], [12, 1.75, 80, 30, 18, 7.5]);
%!test  # its source
%! C = parts.screw.hex ('data', 'M12', 80);
%! E = C(strcmp ({C.article}, '04014.800'));
%! assert_equal (E.source, 'REYHER, The Catalogue, 2020.04, p. 239');
%!test  # 'FullThread' keeps the screws
%! C = parts.screw.hex ('data', 'M12', 80, 'FullThread', true);
%! assert_equal (unique ({C.standard}), {'ISO 4017'});
%!test  # and false the bolts
%! C = parts.screw.hex ('data', 'M12', 80, 'FullThread', false);
%! assert_equal (unique ({C.standard}), {'ISO 4014'});
%!test  # a bolt shorter than its standard's lengths, threaded to the head
%! C = parts.screw.hex ('data', 'M10', 40);
%! E = C(strcmp ({C.article}, '04014.800'));
%! assert_equal ({E.designation, E.b}, {'Hexagon head screw M10 x 40', 40});
%!test  # a bolt longer than its standard's lengths is custom
%! C = parts.screw.hex ('data', 'M10', 110, 'FullThread', false);
%! assert_equal (unique ({C.designation}), ...
%!               {'Hexagon head bolt M10 x 110 x 26'});
%!test  # fine threads, bolt and screw
%! C = parts.screw.hex ('data', 'M10x1.25', 50);
%! assert_equal (unique ({C.standard}), {'ISO 8676', 'ISO 8765'});
%!test  # product grade B past 150
%! C = parts.screw.hex ('data', 'M20', 160, 'FullThread', true);
%! assert_equal (unique ({C.grade}), {'B'});
%!test  # pressure vessel grades
%! C = parts.screw.hex ('data', 'M16', 80, 'FullThread', false);
%! assert_equal (all (ismember ({'5.6', '25CrMo4', 'A5'}, {C.class})), true);
%!test  # hot dip galvanized
%! C = parts.screw.hex ('data', 'M16', 80, 'FullThread', false);
%! assert_equal (any (strcmp ({C.finish}, 'hot dip galvanized')), true);
%!testif ; exist ('__occt__') == 3  # hexagonal head, plain shank
%! S = parts.screw.hex ('solid', 'M12', 80);
%! assert_equal (volume (S), sqrt (3) / 2 * 18 ^ 2 * 7.5 + pi * 36 * 80, 1e-6);
%!testif ; exist ('__occt__') == 3  # the bearing face on the plane
%! S = parts.screw.hex ('solid', 'M12', 80);
%! assert_equal (bbox (S), [-6 * sqrt(3), -9, -80, 6 * sqrt(3), 9, 7.5], 1e-6);
%!testif ; exist ('__occt__') == 3  # named by its designation
%! S = parts.screw.hex ('solid', 'M10x1.25', 50, 'FullThread', true);
%! assert_equal (S.Name, ...
%!               {'Hexagon head screw ISO 8676 - M10x1.25 x 50'});
%!testif ; exist ('__occt__') == 3  # a thread length given is custom
%! S = parts.screw.hex ('solid', 'M12', 80, 'ThreadLength', 40);
%! assert_equal (S.Name, {'Hexagon head bolt M12 x 80 x 40'});
%!testif ; exist ('__occt__') == 3  # detailed: washer face, chamfer, thread
%! S = parts.screw.hex ('solid', 'M8', 20, 'FullThread', true, ...
%!                      'Detailed', true);
%! assert_equal (isvalid (S), true);

%!testif ; exist ('__occt__') == 3  # a flange bolt: head, flange, shank
%! S = parts.screw.hex ('solid', 'M12', 80, 'Flange', true);
%! H = sqrt (3) / 2 * 15 ^ 2;
%! V = H * 11.9 + (pi * 12.35 ^ 2 - H) * 1.8 + pi * 36 * 80;
%! assert_equal (volume (S), V, 1e-6);
%!testif ; exist ('__occt__') == 3  # a flange bolt by its standard
%! S = parts.screw.hex ('solid', 'M10', 30, 'Flange', true);
%! assert_equal (S.Name, {'Hexagon flange bolt ISO 4162 - M10 x 30'});
%!testif ; exist ('__occt__') == 3  # a flange bolt past its table is custom
%! S = parts.screw.hex ('solid', 'M16', 210, 'Flange', true);
%! assert_equal (S.Name, {'Hexagon flange bolt M16 x 210 x 57'});
%!testif ; exist ('__occt__') == 3  # detailed flange bolt, valid
%! S = parts.screw.hex ('solid', 'M8', 40, 'Flange', true, 'Detailed', true);
%! assert_equal (isvalid (S), true);

%!error<parts.screw.hex: MODE must be 'data' or 'solid'.> parts.screw.hex ()
%!error<parts.screw.hex: a solid needs a NAME and a length L.> ...
%! parts.screw.hex ('solid', 'M12')
%!error<parts.screw.hex: L must be a positive length.> ...
%! parts.screw.hex ('solid', 'M12', -80)
%!error<parts.screw.hex: NAME must name a metric thread, such as 'M10' or 'M10x1.25'.> ...
%! parts.screw.hex ('data', 'M12y')
%!error<parts.screw.hex: Name/Value arguments must come in pairs.> ...
%! parts.screw.hex ('data', 'M12', 'FullThread')
%!error<parts.screw.hex: option names must be character vectors.> ...
%! parts.screw.hex ('data', 12, 'Maker')
%!error<parts.screw.hex: unknown option 'Drive'.> ...
%! parts.screw.hex ('data', 'Drive', 'torx')
%!error<parts.screw.hex: 'FullThread' must be true or false.> ...
%! parts.screw.hex ('data', 'FullThread', 'yes')
%!error<parts.screw.hex: 'FullThread' must be true or false.> ...
%! parts.screw.hex ('data', 'FullThread', 1)
%!error<parts.screw.hex: 'Maker' applies to 'data' only.> ...
%! parts.screw.hex ('solid', 'M12', 80, 'Maker', 'REYHER')
%!error<parts.screw.hex: 'Maker' must be a character vector.> ...
%! parts.screw.hex ('data', 'Maker', 1)
%!error<parts.screw.hex: 'Detailed' applies to 'solid' only.> ...
%! parts.screw.hex ('data', 'Detailed', true)
%!error<parts.screw.hex: 'Detailed' must be true or false.> ...
%! parts.screw.hex ('solid', 'M12', 80, 'Detailed', 'yes')
%!error<parts.screw.hex: 'Detailed' must be true or false.> ...
%! parts.screw.hex ('solid', 'M12', 80, 'Detailed', 1)
%!error<parts.screw.hex: 'ThreadLength' applies to 'solid' only.> ...
%! parts.screw.hex ('data', 'ThreadLength', 30)
%!error<parts.screw.hex: 'ThreadLength' must be a length from 0 to L.> ...
%! parts.screw.hex ('solid', 'M12', 80, 'ThreadLength', 90)
%!error<parts.screw.hex: 'ThreadLength' applies to a bolt, not to a screw threaded to the head.> ...
%! parts.screw.hex ('solid', 'M12', 80, 'FullThread', true, 'ThreadLength', 30)
%!error<parts.screw.hex: ISO 4014 and 4017 define no M7 head.> ...
%! parts.screw.hex ('solid', 'M7', 30)
%!error<parts.screw.hex: ISO 8765 and 8676 define no M24x1.5 head.> ...
%! parts.screw.hex ('solid', 'M24x1.5', 80)
%!error<parts.screw.hex: no M7 hexagon head bolt or screw in the catalogue.> ...
%! parts.screw.hex ('data', 'M7')
%!error<parts.screw.hex: no M12 x 81 hexagon head screw by NSK in the catalogue.> ...
%! parts.screw.hex ('data', 'M12', 81, 'FullThread', true, 'Maker', 'NSK')
%!error<parts.screw.hex: 'Flange' must be true or false.> ...
%! parts.screw.hex ('solid', 'M12', 80, 'Flange', 'yes')
%!error<parts.screw.hex: 'Flange' must be true or false.> ...
%! parts.screw.hex ('solid', 'M12', 80, 'Flange', 1)
%!error<parts.screw.hex: 'FullThread' does not apply to a flange bolt; give 'ThreadLength'.> ...
%! parts.screw.hex ('solid', 'M12', 80, 'Flange', true, 'FullThread', true)
%!error<parts.screw.hex: ISO 4162 defines no M20 flange bolt.> ...
%! parts.screw.hex ('solid', 'M20', 80, 'Flange', true)
%!error<parts.screw.hex: no M12 hexagon flange bolt in the catalogue.> ...
%! parts.screw.hex ('data', 'M12', 'Flange', true)
