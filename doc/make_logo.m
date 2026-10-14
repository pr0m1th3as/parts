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

## Draw the parts package logo from the package's own catalogue.
##
## An M12 nut, ISO 4032, on its washer, ISO 7089, seen end on: the bearing
## face of the nut, and its thread as a drawing shows one, the minor circle
## and three quarters of the major.  Writes parts.png beside itself; run it
## from anywhere under 'octave', not 'octave-cli', which cannot print.

pkg load drafting
here = fileparts (mfilename ('fullpath'));
addpath (fullfile (here, '..', 'inst'));

N = parts.nut.hex ('data', 'M12');
N = N(1);
W = parts.washer.plain ('data', 'M12');
W = W(1);
D1 = N.d - 1.0825 * N.P;

ink = [43, 43, 43] / 255;
orange = [229, 140, 51] / 255;
grey = [154, 163, 173] / 255;

f = figure ('visible', 'off', 'color', 'w');
ax = axes ('parent', f, 'position', [0, 0, 1, 1]);
hold (ax, 'on');
t = linspace (0, 2 * pi, 361);
disc = @(r, c, w) fill (ax, r * cos (t), r * sin (t), c, 'edgecolor', ink, ...
                        'linewidth', w);
disc (W.d2 / 2, grey, 4);
a = (0:6) * 60;
fill (ax, N.s / sqrt (3) * cosd (a), N.s / sqrt (3) * sind (a), orange, ...
      'edgecolor', ink, 'linewidth', 4);
plot (ax, N.dw / 2 * cos (t), N.dw / 2 * sin (t), 'color', ink, ...
      'linewidth', 1.5);
disc (D1 / 2, 'w', 4);
## Three quarters of the major circle, open at the upper right
u = linspace (pi / 2, 2 * pi, 271);
plot (ax, N.d / 2 * cos (u), N.d / 2 * sin (u), 'color', ink, ...
      'linewidth', 1.5);
w = W.d2 / 2 + 1;
axis (ax, [-w, w, -w, w], 'equal', 'off');
set (f, 'paperunits', 'inches', 'papersize', [2.56, 2.56], ...
     'paperposition', [0, 0, 2.56, 2.56]);
print (f, fullfile (here, 'parts.png'), '-r100');
close (f);
