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

## Internal helper.  Cut the drive of a screw into the head of the solid.Shape
## S, whose axis is the z axis and whose head tops out at z = K: the pocket is
## drawn on the plane z = K and sunk T deep, the last value of DIM, so that
## everything of the head above that plane inside its outline is cleared too,
## as on a domed head.  DRIVE is as the screw functions name it and DIM
## holds the family's table values:
##
##   'hexsocket'    [S, T]       a hexagon S across flats, two corners on x
##   'hexalobular'  [NO, T]      socket number NO of ISO 10664
##   'slot'         [N, DK, T]   a slot N wide along x, past a head DK across
##   'crossH'       [NO, M, T]   recess number NO of ISO 4757, M across at
##   'crossZ'       [NO, M, T]   the top of the head
##
## The simple drive (R5) cuts the hexalobular socket as a round hole of its
## diameter A, and a cross recess as two slots M long on x and y, G / sqrt (2)
## wide, so that their inner corners sit on the recess's core circle G.  With
## DETAILED true the hexalobular socket takes the outline of its GO gauge, the
## smallest socket the standard admits: lobe tips of radius Re on a circle A,
## flutes of radius Ri on a circle B, each the middle of the gauge's limits
## but Ri, solved so that the arcs meet tangent.  A detailed cross recess is
## ISO 4757's, its depth set by M rather than T: the wings' edges run at 26.5
## degrees to the axis from M at the top to the core diameter g, below which
## a cone at 28 degrees to the top closes it, g / 2 * tan (28) deep, the
## standard's t1.  What stays between the wings is cut by four ribs, whose
## edges lie b / 2 from the axis where the bottom cone is b across.  In H
## (Table 1) a rib's edge leans in by beta as it goes down, and its tip opens
## at alpha across the width e, then at 92 degrees; No. 0, whose tip the
## standard rounds instead, takes the 92 degrees alone.  In Z (Table 3) the
## ribs are bounded by the wings' walls, f apart and opening by alpha towards
## the top, and cut back across the diagonal to a face b / 2 from the axis,
## leaning by beta: the notches the driver's small ribs enter.  The radii r,
## r1 and r2, Z's angles gamma and delta, and the shallow marks of a Z head
## are left out.  A hexagon socket and a slot are the same either way; their
## standards define nothing more.

function S = __recess__ (S, DRIVE, DIM, K, DETAILED)

  if (nargin < 5)
    DETAILED = false;
  endif

  t = DIM(end);
  switch (DRIVE)
    case 'hexsocket'
      a = pi / 3 * (0:5)';
      P = DIM(1) / sqrt (3) * [cos(a), sin(a)];
    case 'hexalobular'
      ## ISO 10664:2014: socket number, A of Table 1, then of the GO gauge
      ## in Table 3 A, B and Re, each min and max
      T = [1, 0.9, 0.841, 0.855, 0.592, 0.607, 0.055, 0.062;
           2, 1.0, 0.953, 0.967, 0.674, 0.688, 0.065, 0.072;
           3, 1.2, 1.131, 1.145, 0.800, 0.815, 0.078, 0.085;
           4, 1.35, 1.291, 1.305, 0.912, 0.927, 0.087, 0.093;
           5, 1.5, 1.415, 1.430, 1.013, 1.028, 0.107, 0.111;
           6, 1.75, 1.695, 1.709, 1.210, 1.224, 0.130, 0.134;
           7, 2.1, 2.012, 2.026, 1.437, 1.453, 0.157, 0.165;
           8, 2.4, 2.335, 2.349, 1.672, 1.686, 0.188, 0.193;
           9, 2.6, 2.520, 2.534, 1.809, 1.823, 0.204, 0.210;
           10, 2.8, 2.761, 2.776, 1.979, 1.993, 0.227, 0.231;
           15, 3.35, 3.295, 3.309, 2.353, 2.367, 0.265, 0.269;
           20, 3.95, 3.879, 3.893, 2.764, 2.778, 0.303, 0.307;
           25, 4.5, 4.451, 4.465, 3.170, 3.185, 0.371, 0.378;
           27, 5.1, 5.009, 5.024, 3.564, 3.578, 0.387, 0.393;
           30, 5.6, 5.543, 5.557, 3.958, 3.972, 0.448, 0.454;
           40, 6.75, 6.673, 6.687, 4.766, 4.780, 0.544, 0.548;
           45, 7.93, 7.841, 7.856, 5.555, 5.570, 0.572, 0.576;
           50, 8.95, 8.857, 8.872, 6.366, 6.380, 0.773, 0.777;
           55, 11.35, 11.245, 11.259, 7.930, 7.945, 0.765, 0.769;
           60, 13.45, 13.302, 13.317, 9.490, 9.504, 1.065, 1.069;
           70, 15.7, 15.588, 15.603, 11.085, 11.099, 1.192, 1.196;
           80, 17.75, 17.619, 17.635, 12.646, 12.661, 1.524, 1.529;
           90, 20.2, 20.021, 20.035, 14.232, 14.246, 1.527, 1.534;
           100, 22.4, 22.231, 22.245, 15.820, 15.834, 1.718, 1.724];
      T = T(T(:,1) == DIM(1),:);
      if (DETAILED)
        P = lobular (mean (T(3:4)), mean (T(5:6)), mean (T(7:8)));
      else
        ## Begun on the y axis: a circle whose seam lies in the plane of a
        ## revolved head's seam can leave the cut undone
        P = [0, T(2) / 2, 1; 0, -T(2) / 2, 1];
      endif
    case 'slot'
      h = DIM(1) / 2;
      L = DIM(2);
      P = [-L, -h; L, -h; L, h; -L, h];
    case {'crossH', 'crossZ'}
      if (DETAILED)
        if (strcmp (DRIVE, 'crossH'))
          T = crossH (DIM(1), DIM(2), K);
        else
          T = crossZ (DIM(1), DIM(2), K);
        endif
        S = subtract (S, T);
        return;
      endif
      ## ISO 4757:1983, core diameter g of recess numbers 0 to 4, Tables 1, 3
      if (strcmp (DRIVE, 'crossH'))
        g = [0.81, 1.27, 2.29, 3.81, 5.08](DIM(1) + 1);
      else
        g = [0.86, 1.32, 2.34, 3.86, 5.08](DIM(1) + 1);
      endif
      L = DIM(2) / 2;
      h = g / sqrt (8);
      P = [L, -h; L, h; h, h; h, L; -h, L; -h, h; ...
           -L, h; -L, -h; -h, -h; -h, -L; h, -L; h, -h];
  endswitch
  R = geom.Region (P);
  R.UCS = geom.UCS ([0, 0, 1], [0, 0, K]);
  S = pocket (S, R, t);

endfunction

## The hexalobular outline of tip diameter A, flute diameter B and tip radius
## Re, a lobe tip on the x axis: six convex arcs of Re, centred A / 2 - Re from
## the axis, joined by six concave arcs of the radius that meets them tangent,
## centred B / 2 + Ri out, as [x, y, bulge] rows
function P = lobular (A, B, Re)

  p = A / 2 - Re;
  Ri = (Re ^ 2 - p ^ 2 - B ^ 2 / 4 + sqrt (3) / 2 * p * B) ...
       / (B - sqrt (3) * p - 2 * Re);
  q = B / 2 + Ri;
  c = q * [sqrt(3), 1] / 2;
  u = c - [p, 0];
  T = [p, 0] + Re * u / norm (u);
  tip = 2 * atan2 (T(2), T(1) - p);
  flute = 2 * acos (dot (T - c, -c) / (Ri * q));
  P = zeros (12, 3);
  for k = 0:5
    a = k * pi / 3;
    M = [cos(a), -sin(a); sin(a), cos(a)];
    P(2*k+1,:) = [(M * [T(1); -T(2)])', tan(tip / 4)];
    P(2*k+2,:) = [(M * T')', -tan(flute / 4)];
  endfor

endfunction

## The cross recess H of ISO 4757:1983, recess number NO, M across at its
## top z = K, as a cutter with its wings on the x and y axes
function T = crossH (NO, M, K)

  ## Table 1: b, e (the middle of its limits), g, alpha, beta, in degrees
  H = [0.61, 0.31, 0.81, NaN, 7;
       0.97, 0.435, 1.27, 138, 7;
       1.47, 0.815, 2.29, 140, 5.75;
       2.41, 2.005, 3.81, 146, 5.75;
       3.48, 2.415, 5.08, 153, 7](NO + 1,:);
  [T, tg, tt, hm] = envelope (M, H(3), K);
  b = H(1);
  e = H(2);
  beta = H(5);
  tb = tg + (H(3) - b) / 2 * tand (28);
  rt = b / 2 + (hm + tb) * tand (beta);
  rb = b / 2 - (tt - tb) * tand (beta);
  a92 = atan (tand (46) / cosd (beta));
  dx = M * cos (a92);
  dy = M * sin (a92);
  if (isnan (H(4)))
    rib = @(r) [r, 0; r + dx, dy; r + dx, -dy];
  else
    d = e / 2 / tan (atan (tand (H(4) / 2) / cosd (beta)));
    rib = @(r) [r, 0; r + d, e / 2; r + d + dx, e / 2 + dy;
                r + d + dx, -e / 2 - dy; r + d, -e / 2];
  endif
  W = solid.loft ({plane(rib (rb), K - tt), plane(rib (rt), K + hm)}, ...
                  'Ruled', true);
  ribs = arrayfun (@(a) rotate (W, a, [0, 0, 1]), 45:90:315, ...
                   'UniformOutput', false);
  T = subtract (T, ribs{:});

endfunction

## The cross recess Z of ISO 4757:1983, as crossH
function T = crossZ (NO, M, K)

  ## Table 3: b, f, g, alpha, beta, in degrees
  Z = [0.76, 0.48, 0.86, 7, 7.75;
       1.27, 0.74, 1.32, 7, 7.75;
       1.83, 1.03, 2.34, 5.75, 19 / 3;
       2.72, 1.42, 3.86, 5.75, 19 / 3;
       3.96, 2.16, 5.08, 7, 7.75](NO + 1,:);
  [T, tg, tt, hm] = envelope (M, Z(3), K);
  b = Z(1);
  tb = tg + (Z(3) - b) / 2 * tand (28);
  wt = Z(2) / 2 + (hm + tb) * tand (Z(4));
  wb = Z(2) / 2 - (tt - tb) * tand (Z(4));
  rt = b / 2 + (hm + tb) * tand (Z(5));
  rb = b / 2 - (tt - tb) * tand (Z(5));
  quad = @(w) [w, w; M, w; M, M; w, M];
  half = @(r) [r, -M; r + M, -M; r + M, M; r, M] * [1, 1; -1, 1] / sqrt (2);
  Q = solid.loft ({plane(quad (wb), K - tt), plane(quad (wt), K + hm)}, ...
                  'Ruled', true);
  F = solid.loft ({plane(half (rb), K - tt), plane(half (rt), K + hm)}, ...
                  'Ruled', true);
  W = intersect (Q, F);
  ribs = arrayfun (@(a) rotate (W, a, [0, 0, 1]), 0:90:270, ...
                   'UniformOutput', false);
  T = subtract (T, ribs{:});

endfunction

## The solid of revolution a cross recess is cut from: M across at z = K,
## its edges at 26.5 degrees to the axis down to G at depth TG, a cone at 28
## degrees to the top below it, TT deep, and reaching HM above the top
function [T, tg, tt, hm] = envelope (M, G, K)

  tg = (M - G) / 2 / tand (26.5);
  tt = tg + G / 2 * tand (28);
  hm = M / 4;
  rm = M / 2 + hm * tand (26.5);
  R = geom.Region ([0, K + hm; rm, K + hm; G / 2, K - tg; 0, K - tt]);
  R.UCS = geom.UCS ([0, -1, 0], [0, 0, 0]);
  T = solid.revolve (R);

endfunction

## The region of outline P on the plane z = Z
function R = plane (P, Z)

  R = geom.Region (P);
  R.UCS = geom.UCS ([0, 0, 1], [0, 0, Z]);

endfunction

%!shared H
%! H = solid.cylinder (10, 5);
%!testif ; exist ('__occt__') == 3  # a hexagon S across flats, T deep
%! S = parts.screw.__recess__ (H, 'hexsocket', [4, 2.5], 5);
%! assert_equal (volume (H) - volume (S), sqrt (3) / 2 * 4 ^ 2 * 2.5, 1e-6);
%!testif ; exist ('__occt__') == 3  # two hexagon corners on the x axis
%! S = parts.screw.__recess__ (solid.cylinder (2, 5), 'hexsocket', [3, 1], 5);
%! B = bbox (subtract (solid.cylinder (2, 5), S));
%! assert_equal (B([1, 4]), [-sqrt(3), sqrt(3)], 1e-6);
%!testif ; exist ('__occt__') == 3  # a round hole of the socket's A, T deep
%! S = parts.screw.__recess__ (H, 'hexalobular', [25, 1.65], 5);
%! assert_equal (volume (H) - volume (S), pi * 2.25 ^ 2 * 1.65, 1e-6);
%!testif ; exist ('__occt__') == 3  # the GO gauge outline, its tips on x
%! S = parts.screw.__recess__ (H, 'hexalobular', [25, 1.65], 5, true);
%! B = bbox (subtract (H, S));
%! assert_equal (B([1, 4]), [-2.229, 2.229], 1e-9);
%!testif ; exist ('__occt__') == 3  # the GO gauge outline's area
%! S = parts.screw.__recess__ (H, 'hexalobular', [25, 1.65], 5, true);
%! A = 4.458; Bf = 3.1775; Re = 0.3745; p = A / 2 - Re;
%! Ri = (Re ^ 2 - p ^ 2 - Bf ^ 2 / 4 + sqrt (3) / 2 * p * Bf) ...
%!      / (Bf - sqrt (3) * p - 2 * Re);
%! c = (Bf / 2 + Ri) * [sqrt(3), 1] / 2;
%! T = [p, 0] + Re * (c - [p, 0]) / norm (c - [p, 0]);
%! a = 2 * atan2 (T(2), T(1) - p);
%! b = 2 * acos (dot (T - c, -c) / (Ri * norm (c)));
%! z = (T(1) + 1i * T(2) * [-1; 1]) .* exp (1i * pi / 3 * (0:5));
%! poly = polyarea (real (z(:)), imag (z(:)));
%! V = (poly + 3 * Re ^ 2 * (a - sin (a)) - 3 * Ri ^ 2 * (b - sin (b))) * 1.65;
%! assert_equal (volume (H) - volume (S), V, 1e-6);
%!testif ; exist ('__occt__') == 3  # a slot N wide across the whole head
%! S = parts.screw.__recess__ (H, 'slot', [1.2, 20, 1.3], 5);
%! a = 0.6;
%! A = 2 * (a * sqrt (100 - a ^ 2) + 100 * asin (a / 10));
%! assert_equal (volume (H) - volume (S), A * 1.3, 1e-6);
%!testif ; exist ('__occt__') == 3  # the slot runs along the x axis
%! S = parts.screw.__recess__ (H, 'slot', [1.2, 20, 1.3], 5);
%! B = bbox (subtract (H, S));
%! assert_equal (B([2, 5]), [-0.6, 0.6], 1e-6);
%!testif ; exist ('__occt__') == 3  # a cross M long, G / sqrt (2) wide
%! S = parts.screw.__recess__ (H, 'crossH', [2, 5.2, 2.7], 5);
%! w = 2.29 / sqrt (2);
%! assert_equal (volume (H) - volume (S), (2 * 5.2 * w - w ^ 2) * 2.7, 1e-6);
%!testif ; exist ('__occt__') == 3  # the core circle of Z, not of H
%! S = parts.screw.__recess__ (H, 'crossZ', [2, 5.3, 2.65], 5);
%! w = 2.34 / sqrt (2);
%! assert_equal (volume (H) - volume (S), (2 * 5.3 * w - w ^ 2) * 2.65, 1e-6);
%!testif ; exist ('__occt__') == 3  # a domed head cleared above the plane
%! D = solid.sphere (5);
%! S = parts.screw.__recess__ (D, 'hexalobular', [10, 1], 5);
%! V = 2 * pi / 3 * (125 - (25 - 1.4 ^ 2) ^ 1.5) - pi * 1.4 ^ 2 * 4;
%! assert_equal (volume (D) - volume (S), V, 1e-6);
%!testif ; exist ('__occt__') == 3  # detailed H: M across at the top
%! S = parts.screw.__recess__ (H, 'crossH', [2, 4.6, 2.7], 5, true);
%! B = bbox (subtract (H, S));
%! assert_equal (B([1, 2, 4, 5]), [-2.3, -2.3, 2.3, 2.3], 1e-6);
%!testif ; exist ('__occt__') == 3  # detailed H: the depth, g / 2 * tan (28)
%! S = parts.screw.__recess__ (H, 'crossH', [2, 4.6, 2.7], 5, true);
%! B = bbox (subtract (H, S));
%! t = (4.6 - 2.29) / 2 / tand (26.5) + 2.29 / 2 * tand (28);
%! assert_equal (B(3), 5 - t, 1e-6);
%!testif ; exist ('__occt__') == 3  # detailed H: ribs on the diagonals
%! S = parts.screw.__recess__ (H, 'crossH', [2, 4.6, 2.7], 5, true);
%! R = section (subtract (H, S), geom.UCS ([0, 0, 1], [0, 0, 4.9]));
%! V = R{1}.Outline.Vertices;
%! assert_equal (inpolygon ([0.8; 2], [0.8; 0], V(:,1), V(:,2)), [false; true]);
%!testif ; exist ('__occt__') == 3  # detailed H No. 0, its rib tips rounded
%! S = parts.screw.__recess__ (H, 'crossH', [0, 1.9, 1.2], 5, true);
%! assert_equal (isvalid (S), true);
%!testif ; exist ('__occt__') == 3  # detailed Z: M across at the top
%! S = parts.screw.__recess__ (H, 'crossZ', [2, 4.4, 2.6], 5, true);
%! B = bbox (subtract (H, S));
%! assert_equal (B([1, 2, 4, 5]), [-2.2, -2.2, 2.2, 2.2], 1e-6);
%!testif ; exist ('__occt__') == 3  # detailed Z: the depth, g / 2 * tan (28)
%! S = parts.screw.__recess__ (H, 'crossZ', [2, 4.4, 2.6], 5, true);
%! B = bbox (subtract (H, S));
%! t = (4.4 - 2.34) / 2 / tand (26.5) + 2.34 / 2 * tand (28);
%! assert_equal (B(3), 5 - t, 1e-6);
%!testif ; exist ('__occt__') == 3  # detailed Z: the 45 degree notches
%! S = parts.screw.__recess__ (H, 'crossZ', [2, 4.4, 2.6], 5, true);
%! R = section (subtract (H, S), geom.UCS ([0, 0, 1], [0, 0, 4]));
%! V = R{1}.Outline.Vertices;
%! assert_equal (inpolygon ([0.68; 0.78], [0.68; 0.78], V(:,1), V(:,2)), ...
%!               [true; false]);
