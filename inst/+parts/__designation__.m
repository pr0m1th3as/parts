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

## Internal helper.  The designation of a threaded part in the order of
## ISO 8991, stopping before the property class: the denomination DENOM, the
## standard STD, and the size, the thread of diameter D and pitch P by the
## nominal length L.  The thread is written without spaces, its pitch only
## when it is not the coarse one of ISO 261 as solid.threadspec gives it,
## 'M5' and 'M16x0.8'.
##
## A part its standard defines takes STD, such as 'ISO 4762', whose table
## fixes the thread length, so B is not written:
##   'Hexagon socket head cap screw ISO 4762 - M5 x 20'.
## Any other part is custom, STD empty, and its thread length B follows L
## only when shorter, B being L for a part threaded to the head:
##   'Hexagon socket head cap screw M16x0.8 x 80 x 25'.
## A shoulder screw is sized by its shoulder diameter DS, its standard
## fixing the thread, '... ISO 7379 - 10 x 40', and a custom one writes it,
## '... 10-M8 x 40'.  A part without a length, a nut, takes L and B empty
## and is sized by its thread alone, 'Hexagon regular nut ISO 4032 - M12'.
##
## THREAD is the thread alone, 'M5' or 'M16x0.8', as solid.Shape.thread
## takes it.
##
## D, P, L, B and DS may be vectors of one length N, and DENOM and STD cell
## arrays of N, for N parts at once; a scalar or a character vector serves
## them all.  NAME and THREAD are then N-by-1 cell arrays, and character
## vectors for one part.

function [name, thread] = __designation__ (DENOM, STD, D, P, L, B, DS)

  if (nargin < 7)
    DS = [];
  endif
  n = max (cellfun (@numel, {D, P, L, B, DS}));
  one = n == 1 && ! iscell (DENOM) && ! iscell (STD);
  D = column (D, n);
  P = column (P, n);
  L = column (L, n);
  B = column (B, n);
  DENOM = cellstr (column (DENOM, n));
  STD = cellstr (column (STD, n));

  ## The coarse pitch of each diameter, NaN for one with none
  [u, ~, k] = unique (D);
  coarse = NaN (size (u));
  for i = 1:numel (u)
    try
      T = solid.threadspec (sprintf ("M%g", u(i)));
      coarse(i) = T.P;
    end_try_catch
  endfor
  plain = coarse(k) == P;
  thread = cell (n, 1);
  thread(plain) = join ("M%g", D(plain));
  thread(! plain) = join ("M%gx%g", D(! plain), P(! plain));

  custom = cellfun (@isempty, STD);
  if (isempty (L))
    dims = thread;
  elseif (isempty (DS))
    dims = join ("%s x %g", thread, L);
    part = custom & B < L;
    dims(part) = join ("%s x %g", dims(part), B(part));
  else
    DS = column (DS, n);
    dims = cell (n, 1);
    dims(custom) = join ("%g-%s x %g", DS(custom), thread(custom), ...
                         L(custom));
    dims(! custom) = join ("%g x %g", DS(! custom), L(! custom));
  endif

  name = cell (n, 1);
  name(custom) = join ("%s %s", DENOM(custom), dims(custom));
  name(! custom) = join ("%s %s - %s", DENOM(! custom), STD(! custom), ...
                         dims(! custom));

  if (one)
    name = name{1};
    thread = thread{1};
  endif

endfunction

## X as an N-by-1 column, one value or character vector repeated
function X = column (X, n)

  if (ischar (X) || numel (X) == 1)
    if (! iscell (X) && ! isnumeric (X))
      X = {X};
    endif
    X = repmat (X, n, 1);
  else
    X = X(:);
  endif

endfunction

## FMT applied to each row of the N-by-1 columns ARGS, numeric or cell, as
## an N-by-1 cell array of character vectors
function C = join (fmt, varargin)

  n = numel (varargin{1});
  for k = 1:numel (varargin)
    if (! iscell (varargin{k}))
      varargin{k} = num2cell (varargin{k});
    endif
    varargin{k} = varargin{k}(:);
  endfor
  args = [varargin{:}]';
  C = ostrsplit (sprintf ([fmt, "\001"], args{:}), "\001");
  C = C(1:n)';

endfunction

%!test  # a standard screw: no thread length, no coarse pitch
%! name = parts.__designation__ ('Hexagon socket head cap screw', ...
%!                               'ISO 4762', 5, 0.8, 20, 16);
%! assert_equal (name, 'Hexagon socket head cap screw ISO 4762 - M5 x 20');
%!test  # a standard screw with a fine thread
%! name = parts.__designation__ ('Hexagon head screw', 'ISO 8765', ...
%!                               12, 1.5, 100, 30);
%! assert_equal (name, 'Hexagon head screw ISO 8765 - M12x1.5 x 100');
%!test  # a custom screw threaded to the head
%! name = parts.__designation__ ('Hexagon socket head cap screw', '', ...
%!                               8, 1.25, 60, 60);
%! assert_equal (name, 'Hexagon socket head cap screw M8 x 60');
%!test  # a custom screw with a fine pitch and a thread length
%! name = parts.__designation__ ('Hexagon socket head cap screw', '', ...
%!                               16, 0.8, 80, 25);
%! assert_equal (name, 'Hexagon socket head cap screw M16x0.8 x 80 x 25');
%!test  # the thread alone, as solid.Shape.thread takes it
%! [~, thread] = parts.__designation__ ('Hexagon socket head cap screw', ...
%!                                    '', 16, 0.8, 80, 25);
%! assert_equal (thread, 'M16x0.8');
%!test
%! [~, thread] = parts.__designation__ ('Hexagon socket head cap screw', ...
%!                                    'ISO 4762', 5, 0.8, 20, 20);
%! assert_equal (thread, 'M5');
%!test  # several parts at once, one denomination for all
%! name = parts.__designation__ ('Hexagon socket head cap screw', ...
%!                               {'ISO 4762'; ''}, [5; 16], [0.8; 0.8], ...
%!                               [20; 80], [20; 25]);
%! assert_equal (name, {'Hexagon socket head cap screw ISO 4762 - M5 x 20'; ...
%!                      'Hexagon socket head cap screw M16x0.8 x 80 x 25'});
%!test  # their threads
%! [~, thread] = parts.__designation__ ('Stud', '', [5; 16], [0.8; 0.8], ...
%!                                      [20; 80], [20; 25]);
%! assert_equal (thread, {'M5'; 'M16x0.8'});
%!test  # a nut, sized by its thread alone
%! name = parts.__designation__ ('Hexagon regular nut', 'ISO 8673', 16, ...
%!                               1.5, [], []);
%! assert_equal (name, 'Hexagon regular nut ISO 8673 - M16x1.5');
%!test  # several nuts at once
%! name = parts.__designation__ ('Hexagon regular nut', {'ISO 4032'; ''}, ...
%!                               [12; 12], [1.75; 1], [], []);
%! assert_equal (name, {'Hexagon regular nut ISO 4032 - M12'; ...
%!                      'Hexagon regular nut M12x1'});
%!test  # several shoulder screws at once
%! name = parts.__designation__ ('Shoulder screw', {'ISO 7379'; ''}, ...
%!                               [8; 5], [1.25; 0.8], [40; 20], [13; 9.5], ...
%!                               [10; 6]);
%! assert_equal (name, {'Shoulder screw ISO 7379 - 10 x 40'; ...
%!                      'Shoulder screw 6-M5 x 20'});
%!test  # a diameter with no coarse pitch writes its pitch
%! name = parts.__designation__ ('Threaded rod', '', 15, 1.5, 100, 100);
%! assert_equal (name, 'Threaded rod M15x1.5 x 100');
%!test  # coarse pitches from the second choice and the end of the range
%! name = parts.__designation__ ('Stud', 'DIN 938', 3.5, 0.6, 20, 9);
%! assert_equal (name, 'Stud DIN 938 - M3.5 x 20');
%!test  # a set screw takes its point from its standard
%! name = parts.__designation__ ('Hexagon socket set screw', 'ISO 4027', ...
%!                               6, 1, 12, 12);
%! assert_equal (name, 'Hexagon socket set screw ISO 4027 - M6 x 12');
%!test  # a standard shoulder screw: shoulder by length, no thread
%! name = parts.__designation__ ('Hexagon socket head shoulder screw', ...
%!                               'ISO 7379', 8, 1.25, 40, 13, 10);
%! assert_equal (name, ...
%!               'Hexagon socket head shoulder screw ISO 7379 - 10 x 40');
%!test  # a custom shoulder screw writes its thread
%! name = parts.__designation__ ('Hexagon socket head shoulder screw', '', ...
%!                               5, 0.8, 20, 9.5, 6);
%! assert_equal (name, 'Hexagon socket head shoulder screw 6-M5 x 20');
