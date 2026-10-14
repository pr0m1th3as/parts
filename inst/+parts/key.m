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
## @deftypefn  {parts} {@var{K} =} parts.key (@qcode{'data'})
## @deftypefnx {parts} {@var{K} =} parts.key (@qcode{'data'}, @var{DS})
## @deftypefnx {parts} {@var{S} =} parts.key (@qcode{'solid'}, @var{DS}, @var{L})
## @deftypefnx {parts} {@var{S} =} parts.key (@dots{}, @var{Name}, @var{Value})
##
## Parallel keys to DIN 6885-1, form A.
##
## @code{@var{K} = parts.key (@qcode{'data'})} returns every key in the
## catalogue as a struct array, smallest first.
## @code{@var{K} = parts.key (@qcode{'data'}, @var{DS})} returns the key for
## a shaft of diameter @var{DS} millimetres, over 6 up to 85.  A shaft on the
## boundary of two rows takes the smaller key, as the table's ranges run over
## one diameter up to the next.  Nothing is built.
##
## @code{@var{S} = parts.key (@qcode{'solid'}, @var{DS}, @var{L})} builds the
## key for that shaft as a @code{solid.Shape} @var{L} long, whether or not
## that length is in the standard series: its length along @math{z} from 0
## to @var{L}, its width centred on the @math{x} axis, its height along
## @math{y} from 0 to @var{h}, both ends rounded.
##
## Name/Value pairs:
##
## @table @asis
## @item @qcode{'Detailed'}
## For @qcode{'solid'}: @code{true} chamfers the edges round the top and the
## bottom face by the smallest @var{s}.  By default (@code{false}) the edges
## are sharp.
## @end table
##
## Each key is a struct with these fields, in millimetres:
##
## @multitable @columnfractions 0.12 0.88
## @item @code{shaft} @tab the shaft diameters it serves, over the first up
## to the second
## @item @code{b} @tab width
## @item @code{h} @tab height
## @item @code{t1} @tab depth of the keyway in the shaft
## @item @code{t2} @tab depth of the keyway in the hub, over the shaft
## @item @code{s} @tab the chamfer of the edges, smallest and largest
## @item @code{l} @tab the standard lengths, a row vector
## @end multitable
##
## @subheading The catalogue
##
## Shafts over 6 up to 85 mm, from the data sheet @cite{Passfedern DIN 6885,
## hohe Form} of Wilhelm Wernecke GmbH (2016), agreeing with four other
## makers' tables; the lengths are those of the DIN series 6 to 250 within
## each row's range.  Depths are toleranced +0.1 for widths up to 6 and +0.2
## above.
##
## The chamfer @var{s}, which neither the data sheet nor REYHER's
## @cite{Technical Information} gives, from ISO/R 773:1969, the ISO
## counterpart of DIN 6885-1 with the same sections and lengths, read in its
## official preview and agreeing with BS 4235-1:1972.
##
## @seealso{parts.bearing.deepgroove, parts.dowel, parts.screw.cap}
## @end deftypefn

function OUT = key (MODE, varargin)

  if (nargin < 1 || ! ischar (MODE)
      || ! any (strcmp (MODE, {'data', 'solid'})))
    error ("parts.key: MODE must be 'data' or 'solid'.");
  endif

  ## A shaft diameter DS, then a length L, lead the Name/Value pairs
  args = varargin;
  DS = [];
  L = [];
  if (! isempty (args) && ! ischar (args{1}))
    DS = args{1};
    args(1) = [];
    if (! isempty (args) && ! ischar (args{1}))
      L = args{1};
      args(1) = [];
    endif
  endif
  if (strcmp (MODE, 'data') && ! isempty (L))
    error ("parts.key: 'data' takes a shaft diameter DS only.");
  endif
  if (strcmp (MODE, 'solid') && isempty (L))
    error ("parts.key: a solid needs a shaft diameter DS and a length L.");
  endif

  detailed = false;
  if (mod (numel (args), 2) != 0)
    error ("parts.key: Name/Value arguments must come in pairs.");
  endif
  for ii = 1:2:numel (args)
    name = args{ii};
    val = args{ii+1};
    if (! ischar (name) || ! isrow (name))
      error ("parts.key: option names must be character vectors.");
    endif
    switch (lower (name))
      case 'detailed'
        if (strcmp (MODE, 'data'))
          error ("parts.key: 'Detailed' applies to 'solid' only.");
        endif
        if (! islogical (val) || ! isscalar (val))
          error ("parts.key: 'Detailed' must be true or false.");
        endif
        detailed = val;
      otherwise
        error ("parts.key: unknown option '%s'.", name);
    endswitch
  endfor

  ## Shaft over, up to, b, h, t1, t2, shortest and longest length, s min
  ## and max
  T = [6, 8, 2, 2, 1.2, 1.0, 6, 20, 0.16, 0.25;
       8, 10, 3, 3, 1.8, 1.4, 6, 36, 0.16, 0.25;
       10, 12, 4, 4, 2.5, 1.8, 8, 45, 0.16, 0.25;
       12, 17, 5, 5, 3.0, 2.3, 10, 56, 0.25, 0.4;
       17, 22, 6, 6, 3.5, 2.8, 14, 70, 0.25, 0.4;
       22, 30, 8, 7, 4.0, 3.3, 18, 90, 0.25, 0.4;
       30, 38, 10, 8, 5.0, 3.3, 22, 110, 0.4, 0.6;
       38, 44, 12, 8, 5.0, 3.3, 28, 140, 0.4, 0.6;
       44, 50, 14, 9, 5.5, 3.8, 36, 160, 0.4, 0.6;
       50, 58, 16, 10, 6.0, 4.3, 45, 180, 0.4, 0.6;
       58, 65, 18, 11, 7.0, 4.4, 50, 200, 0.4, 0.6;
       65, 75, 20, 12, 7.5, 4.9, 56, 220, 0.6, 0.8;
       75, 85, 22, 14, 9.0, 5.4, 63, 250, 0.6, 0.8];
  series = [6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 28, 32, 36, 40, 45, 50, ...
            56, 63, 70, 80, 90, 100, 110, 125, 140, 160, 180, 200, 220, 250];
  K = struct ('shaft', num2cell (T(:,1:2), 2), 'b', num2cell (T(:,3)), ...
              'h', num2cell (T(:,4)), 't1', num2cell (T(:,5)), ...
              't2', num2cell (T(:,6)), 's', num2cell (T(:,9:10), 2), ...
              'l', arrayfun (@(k) series(series >= T(k,7)
                                         & series <= T(k,8)), ...
                             (1:rows (T))', 'UniformOutput', false));
  if (isempty (DS))
    OUT = K;
    return;
  endif

  if (! isnumeric (DS) || ! isreal (DS) || ! isscalar (DS) || ! (DS > 0))
    error ("parts.key: DS must be a positive real scalar.");
  endif
  k = find (DS > T(:,1) & DS <= T(:,2));
  if (isempty (k))
    error ("parts.key: no key for a %g mm shaft in the catalogue.", DS);
  endif
  K = K(k);
  if (strcmp (MODE, 'data'))
    OUT = K;
    return;
  endif

  if (! isnumeric (L) || ! isreal (L) || ! isscalar (L) || ! isfinite (L))
    error ("parts.key: L must be a real scalar.");
  endif
  if (L <= K.b)
    error ("parts.key: a %g mm wide key must be longer than %g mm.", K.b, ...
           K.b);
  endif
  w = K.b / 2;
  R = geom.Region ([-w, w, 0; -w, L - w, -1; w, L - w, 0; w, w, -1]);
  R.UCS = geom.UCS ([0, -1, 0], [0, 0, 0]);
  OUT = solid.extrude (R, -K.h);
  if (detailed)
    F = [faces(OUT, 'Normal', [0, 1, 0]), faces(OUT, 'Normal', [0, -1, 0])];
    OUT = chamfer (OUT, edges (OUT, 'Face', F), K.s(1));
  endif

endfunction

%!test  # the key for a 20 mm shaft
%! K = parts.key ('data', 20);
%! assert_equal ([K.shaft, K.b, K.h, K.t1, K.t2], [17, 22, 6, 6, 3.5, 2.8]);
%!test  # its chamfer
%! K = parts.key ('data', 20);
%! assert_equal (K.s, [0.25, 0.4]);
%!test  # its lengths
%! K = parts.key ('data', 20);
%! assert_equal (K.l, [14, 16, 18, 20, 22, 25, 28, 32, 36, 40, 45, 50, 56, ...
%!                     63, 70]);
%!test  # a shaft on a row boundary takes the smaller key
%! K = parts.key ('data', 30);
%! assert_equal ([K.b, K.h], [8, 7]);
%!test  # the largest row
%! K = parts.key ('data', 85);
%! assert_equal ([K.b, K.h, K.t1, K.t2], [22, 14, 9, 5.4]);
%!test  # every key, smallest first
%! K = parts.key ('data');
%! assert_equal ([K.b], [2, 3, 4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 22]);
%!testif ; exist ('__occt__') == 3  # the shape: L long on z, h high on y
%! S = parts.key ('solid', 20, 32);
%! assert_equal (bbox (S), [-3, 0, 0, 3, 6, 32], 1e-6);
%!testif ; exist ('__occt__') == 3  # valid
%! S = parts.key ('solid', 20, 32);
%! assert_equal (isvalid (S), true);
%!testif ; exist ('__occt__') == 3  # its ends are rounded
%! S = parts.key ('solid', 20, 32);
%! assert_equal (volume (S), 6 * (6 * 26 + pi * 9), 1e-6);
%!testif ; exist ('__occt__') == 3  # detailed: valid
%! S = parts.key ('solid', 20, 32, 'Detailed', true);
%! assert_equal (isvalid (S), true);
%!testif ; exist ('__occt__') == 3  # detailed: the same bounds
%! S = parts.key ('solid', 20, 32, 'Detailed', true);
%! assert_equal (bbox (S), [-3, 0, 0, 3, 6, 32], 1e-6);
%!testif ; exist ('__occt__') == 3  # detailed: chamfered by s min
%! S = parts.key ('solid', 20, 32, 'Detailed', true);
%! a = 0.25 ^ 2 / 2;
%! V = 6 * (6 * 26 + pi * 9) - 2 * (2 * 26 * a + 2 * pi * (3 - 0.25 / 3) * a);
%! assert_equal (volume (S), V, 1e-6);
%!testif ; exist ('__occt__') == 3  # a length outside the series
%! S = parts.key ('solid', 20, 30);
%! assert_equal (bbox (S), [-3, 0, 0, 3, 6, 30], 1e-6);

%!error<parts.key: MODE must be 'data' or 'solid'.> parts.key ()
%!error<parts.key: MODE must be 'data' or 'solid'.> parts.key (20)
%!error<parts.key: 'data' takes a shaft diameter DS only.> ...
%! parts.key ('data', 20, 32)
%!error<parts.key: a solid needs a shaft diameter DS and a length L.> ...
%! parts.key ('solid', 20)
%!error<parts.key: Name/Value arguments must come in pairs.> ...
%! parts.key ('solid', 20, 32, 'Detailed')
%!error<parts.key: option names must be character vectors.> ...
%! parts.key ('solid', 20, 32, {1}, 2)
%!error<parts.key: 'Detailed' applies to 'solid' only.> ...
%! parts.key ('data', 20, 'Detailed', true)
%!error<parts.key: 'Detailed' must be true or false.> ...
%! parts.key ('solid', 20, 32, 'Detailed', 1)
%!error<parts.key: unknown option 'Form'.> ...
%! parts.key ('solid', 20, 32, 'Form', 'B')
%!error<parts.key: DS must be a positive real scalar.> parts.key ('data', -1)
%!error<parts.key: no key for a 6 mm shaft in the catalogue.> ...
%! parts.key ('data', 6)
%!error<parts.key: no key for a 90 mm shaft in the catalogue.> ...
%! parts.key ('solid', 90, 100)
%!error<parts.key: L must be a real scalar.> parts.key ('solid', 20, [30, 40])
%!error<parts.key: a 6 mm wide key must be longer than 6 mm.> ...
%! parts.key ('solid', 20, 6)
