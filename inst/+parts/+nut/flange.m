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
## @deftypefn  {parts} {@var{C} =} parts.nut.flange (@qcode{'data'})
## @deftypefnx {parts} {@var{C} =} parts.nut.flange (@qcode{'data'}, @var{NAME})
## @deftypefnx {parts} {@var{S} =} parts.nut.flange (@qcode{'solid'}, @var{NAME})
## @deftypefnx {parts} {@dots{} =} parts.nut.flange (@dots{}, @var{Name}, @var{Value})
##
## Hexagon nuts with flange: plain, ISO 4161 and with a fine thread ISO 10663,
## and prevailing torque nuts with a non-metallic insert, ISO 7043 and with a
## fine thread ISO 12125, and all-metal, ISO 7044 and with a fine thread ISO
## 12126; and the European standards the market sells them by, EN 1661, 1663
## and 1664.
##
## @code{@var{C} = parts.nut.flange (@qcode{'data'})} returns every flange
## nut in the catalogue as a struct array, one entry for each maker's
## article in each size, sorted by size and pitch.
## @code{@var{C} = parts.nut.flange (@qcode{'data'}, @var{NAME})} returns
## those of the thread @var{NAME}, a coarse thread as @qcode{'M10'} or a fine
## one as @qcode{'M10x1.25'}: every article sold as that nut, each with its
## property class and finish.  Nothing is built.
##
## @code{@var{S} = parts.nut.flange (@qcode{'solid'}, @var{NAME})} builds the
## nut as a @code{solid.Shape} whether or not anyone sells it: any thread
## whose nut the standards define, in any pitch.  The bearing face of the
## flange lies on the @math{xy} plane, the nut above it to @math{z} =
## @var{h} with two corners of its hexagon on the @math{x} axis.
## @code{@var{S}.Name} holds the designation.
##
## Name/Value pairs:
##
## @table @asis
## @item @qcode{'Locking'}
## @code{false} for a plain nut, the default for @qcode{'solid'},
## @qcode{'insert'} or @code{true} for a prevailing torque nut with a
## non-metallic insert, @qcode{'metal'} for an all-metal one.  For
## @qcode{'data'} it keeps that kind only; without it all come.
##
## @item @qcode{'Standard'}
## @qcode{'ISO'}, the default for @qcode{'solid'}, or @qcode{'EN'}.  The
## two differ at M10, 15 across flats in ISO and 16 in EN, and in the
## smallest thread height of an EN prevailing torque nut at M8 to M12.  For
## @qcode{'data'} it keeps that standard's nuts only; without it both come.
##
## @item @qcode{'Maker'}
## For @qcode{'data'}: only that maker's articles, such as
## @qcode{'REYHER'}, in any case.
##
## @item @qcode{'Detailed'}
## For @qcode{'solid'}: @code{true} builds the flange @var{c} thick at
## @var{dw}, its top a cone at 15 degrees, the smallest the standards
## allow, rising to the hexagon; chamfers the top of the hexagon at 30
## degrees from the flats; countersinks the bore at 120 degrees to
## @var{da}, at both ends of a plain nut and at the bearing face of a
## prevailing torque one; and cuts the thread by @code{solid.Shape.thread}
## through the nut.  By default (@code{false}) the nut is a plain disc
## @var{dc} across and @var{c} thick under a hexagonal prism, with a bore of
## diameter @var{d}.  A prevailing torque nut is the hexagon @var{h} high in
## both; the standards leave the form of its locking part to the maker.
## @end table
##
## Each entry is a struct with these fields, lengths in millimetres:
##
## @multitable @columnfractions 0.16 0.84
## @item @code{designation} @tab the designation, as in
## @qcode{'Hexagon nut EN 1661 - M12'}, without the property class
## @item @code{standard} @tab the standard when its table defines the nut,
## else empty: such a nut is custom
## @item @code{d} @tab nominal diameter
## @item @code{P} @tab pitch
## @item @code{s} @tab width across flats, nominal
## @item @code{e} @tab width across corners, smallest
## @item @code{m} @tab height of the thread: the nut's largest height; for
## a prevailing torque nut the smallest, the only one its standard gives
## @item @code{h} @tab overall height, largest: @var{m} for a plain nut
## @item @code{dc} @tab diameter of the flange, largest
## @item @code{c} @tab thickness of the flange at @var{dw}, smallest
## @item @code{dw} @tab diameter of the bearing face, smallest
## @item @code{da} @tab diameter of the countersink, largest
## @item @code{grade} @tab product grade, @qcode{'A'} up to M16,
## @qcode{'B'} above
## @item @code{class} @tab property class or material, as @qcode{'8'} or
## @qcode{'A2'}
## @item @code{finish} @tab the finish as the maker names it
## @item @code{maker} @tab the maker
## @item @code{article} @tab the maker's article number
## @item @code{source} @tab the catalogue and page the article was read from
## @end multitable
##
## A nut is designated by its standard's number when the standard's table
## defines its thread.  Any other is custom, a nut with a fine thread that
## ISO 10663, 12125 or 12126 does not list, or an EN nut with a fine thread,
## and takes the dimensions of its kind's coarse thread.
##
## @subheading The catalogue
##
## Articles from REYHER, @cite{The Catalogue}, edition 2020.04, English,
## pages 222, 223 (steel) and 521 (stainless steel): every article of EN
## 1661, 1663 and 1664 in sizes they define.  Left out: the articles of DIN
## 6923, 6926 and 6927, withdrawn and replaced by the EN standards.  No
## maker's catalogue read so far sells the ISO ones.
##
## Dimensions from ISO 4161, 7043, 7044, 10663 and 12126, all 2012, Table 1
## of each, read in their official previews, GOST R ISO 4161-2013, GOST ISO
## 7043-2014, 7044-2016 and 12126-2016 and IS 15581:2005, which adopt them
## unchanged, and fasten.it; ISO 12125:2012 from globalfastener's
## reproduction, which the draft ISO/DIS 12125:2016 confirms; EN 1661, 1663
## and 1664, 1997, from their own tables, read in SIST EN 1661 and 1664:2001
## and DIN EN 1663:1998, and fasten.it and REYHER's @cite{Technical
## Information} (2019, TI-64 and 69).
##
## @seealso{parts.nut.hex, parts.screw.hex}
## @end deftypefn

function OUT = flange (MODE, varargin)

  if (nargin < 1 || ! ischar (MODE)
      || ! any (strcmp (MODE, {'data', 'solid'})))
    error ("parts.nut.flange: MODE must be 'data' or 'solid'.");
  endif

  ## A thread NAME leads the Name/Value pairs
  args = varargin;
  NAME = '';
  if (! isempty (args) && ischar (args{1})
      && ! isempty (regexp (args{1}, '^M\d', 'once')))
    NAME = args{1};
    args(1) = [];
  endif
  if (strcmp (MODE, 'solid') && isempty (NAME))
    error ("parts.nut.flange: a solid needs a NAME.");
  endif

  lock = '';
  bylock = false;
  family = 'ISO';
  byfamily = false;
  maker = '';
  detailed = false;
  if (mod (numel (args), 2) != 0)
    error ("parts.nut.flange: Name/Value arguments must come in pairs.");
  endif
  for ii = 1:2:numel (args)
    name = args{ii};
    val = args{ii+1};
    if (! ischar (name) || ! isrow (name))
      error ("parts.nut.flange: option names must be character vectors.");
    endif
    switch (lower (name))
      case 'locking'
        if (islogical (val) && isscalar (val))
          lock = '';
          if (val)
            lock = 'insert';
          endif
        elseif (ischar (val) && any (strcmpi (val, {'insert', 'metal'})))
          lock = lower (val);
        else
          error (strcat ("parts.nut.flange: 'Locking' must be false,", ...
                         " 'insert', true or 'metal'."));
        endif
        bylock = true;
      case 'standard'
        if (! ischar (val) || ! any (strcmpi (val, {'ISO', 'EN'})))
          error ("parts.nut.flange: 'Standard' must be 'ISO' or 'EN'.");
        endif
        family = upper (val);
        byfamily = true;
      case 'maker'
        if (strcmp (MODE, 'solid'))
          error ("parts.nut.flange: 'Maker' applies to 'data' only.");
        endif
        if (! ischar (val) || ! isrow (val))
          error ("parts.nut.flange: 'Maker' must be a character vector.");
        endif
        maker = val;
      case 'detailed'
        if (strcmp (MODE, 'data'))
          error ("parts.nut.flange: 'Detailed' applies to 'solid' only.");
        endif
        if (! islogical (val) || ! isscalar (val))
          error ("parts.nut.flange: 'Detailed' must be true or false.");
        endif
        detailed = val;
      otherwise
        error ("parts.nut.flange: unknown option '%s'.", name);
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
      error (strcat ("parts.nut.flange: NAME must name a metric thread,", ...
                     " such as 'M10' or 'M10x1.25'."));
    endif
    d = str2double (tok{1});
    if (! isempty (tok{2}))
      P = str2double (tok{2});
    endif
  endif

  if (strcmp (MODE, 'data'))
    OUT = catalogue (NAME, d, P, lock, bylock, family, byfamily, maker);
  else
    OUT = shape (d, P, lock, family, detailed);
  endif

endfunction

## The nuts of a standard, a row for each thread: d, P, s nom, e min, m (max;
## min for a prevailing torque nut), h max, dc max, c min, dw min, da max.
## Table 1 of each.
function T = sizes (std)

  ## ISO 4161:2012: d, P, s, e, m max, dc, c, dw, da
  B = [5, 0.8, 8, 8.79, 5, 11.8, 1, 9.8, 5.75;
       6, 1, 10, 11.05, 6, 14.2, 1.1, 12.2, 6.75;
       8, 1.25, 13, 14.38, 8, 17.9, 1.2, 15.8, 8.75;
       10, 1.5, 15, 16.64, 10, 21.8, 1.5, 19.6, 10.8;
       12, 1.75, 18, 20.03, 12, 26, 1.8, 23.8, 13;
       14, 2, 21, 23.36, 14, 29.9, 2.1, 27.6, 15.1;
       16, 2, 24, 26.75, 16, 34.5, 2.4, 31.9, 17.3;
       20, 2.5, 30, 32.95, 20, 42.8, 3, 39.9, 21.6];
  ## m min of the prevailing torque nuts, ISO 7043 and 7044
  mmin = [4.7; 5.7; 7.64; 9.64; 11.57; 13.3; 15.3; 18.7];
  ## h max, ISO 7043 and ISO 7044
  h7043 = [7.1; 9.1; 11.1; 13.5; 16.1; 18.2; 20.3; 24.8];
  h7044 = [6.2; 7.3; 9.4; 11.4; 13.8; 15.9; 18.3; 22.4];
  ## The fine threads of ISO 10663, 12125 and 12126, each with its coarse row
  F = [8, 1, 3; 10, 1.25, 4; 10, 1, 4; 12, 1.25, 5; 12, 1.5, 5;
       14, 1.5, 6; 16, 1.5, 7; 20, 1.5, 8];

  switch (std)
    case 'ISO 4161'
      T = [B(:,1:5), B(:,5), B(:,6:9)];
    case 'ISO 10663'
      T = sizes ('ISO 4161');
      T = [F(:,1:2), T(F(:,3),3:end)];
    case 'ISO 7043'
      T = [B(:,1:4), mmin, h7043, B(:,6:9)];
    case 'ISO 7044'
      T = [B(:,1:4), mmin, h7044, B(:,6:9)];
    case 'ISO 12125'
      T = sizes ('ISO 7043');
      T = [F(:,1:2), T(F(:,3),3:end)];
    case 'ISO 12126'
      T = sizes ('ISO 7044');
      T = [F(:,1:2), T(F(:,3),3:end)];
    case 'EN 1661'
      ## As ISO 4161 but 16 across flats at M10
      T = sizes ('ISO 4161');
      T(T(:,1) == 10,3:4) = [16, 17.77];
    case {'EN 1663', 'EN 1664'}
      ## As ISO 7043 and 7044 but 16 across flats at M10 and m min 7.6,
      ## 9.6 and 11.6 at M8 to M12
      iso = {'ISO 7043', 'ISO 7044'};
      T = sizes (iso{strcmp (std, {'EN 1663', 'EN 1664'})});
      T(T(:,1) == 10,3:4) = [16, 17.77];
      T(ismember (T(:,1), [8, 10, 12]),5) = [7.6; 9.6; 11.6];
  endswitch

endfunction

## The standard of a nut by family, locking kind and fineness, empty where
## none defines it
function std = standardof (family, lock, fine)

  stds = struct ('ISO', {{'ISO 4161', 'ISO 10663'; 'ISO 7043', 'ISO 12125';
                          'ISO 7044', 'ISO 12126'}}, ...
                 'EN', {{'EN 1661', ''; 'EN 1663', ''; 'EN 1664', ''}});
  k = find (strcmp (lock, {'', 'insert', 'metal'}));
  std = stds.(family){k, fine + 1};

endfunction

function C = catalogue (NAME, d, P, lock, bylock, family, byfamily, maker)

  ## Built on the first call, kept for the session
  persistent E;
  if (isempty (E))
    E = entries ();
  endif

  keep = true (size (E));
  if (! isempty (d))
    if (isnan (P))
      T = sizes ('ISO 4161');
      if (any (T(:,1) == d))
        P = T(T(:,1) == d,2);
      endif
    endif
    keep &= [E.d] == d & [E.P] == P;
  endif
  std = {E.standard};
  if (bylock)
    kinds = {{'ISO 4161', 'ISO 10663', 'EN 1661'}, ...
             {'ISO 7043', 'ISO 12125', 'EN 1663'}, ...
             {'ISO 7044', 'ISO 12126', 'EN 1664'}};
    keep &= ismember (std, kinds{strcmp (lock, {'', 'insert', 'metal'})});
  endif
  if (byfamily)
    keep &= strncmp (std, family, numel (family));
  endif
  if (! isempty (maker))
    keep &= strcmpi ({E.maker}, maker);
  endif
  C = E(keep);

  if (isempty (C))
    what = '';
    if (! isempty (NAME))
      what = [NAME, ' '];
    endif
    kind = 'hexagon nut with flange';
    if (bylock && ! isempty (lock))
      kind = 'prevailing torque hexagon nut with flange';
    endif
    if (byfamily)
      kind = sprintf ("%s %s", family, kind);
    endif
    how = '';
    if (! isempty (maker))
      how = sprintf (" by %s", maker);
    endif
    error ("parts.nut.flange: no %s%s%s in the catalogue.", what, kind, how);
  endif

endfunction

## The denominations of the standards STD, a cell array: the EN standards
## name every one 'Hexagon nut'
function denom = denomof (std)

  denom = repmat ({'Hexagon nut with flange'}, size (std));
  denom(ismember (std, {'ISO 7043', 'ISO 7044', 'ISO 12125', ...
                        'ISO 12126'})) = ...
    {'Prevailing torque type hexagon nut with flange'};
  denom(strncmp (std, 'EN', 2)) = {'Hexagon nut'};

endfunction

## Every entry of the catalogue, sorted by size
function E = entries ()

  ## BEGIN generated by tools/reyher_tables.py flange
  ## REYHER article, printed page, standard, class, finish; then its
  ## sizes
  A = {'01661.800', 222, 'EN 1661', '8', 'plain', ...
         [5, 6, 8, 10, 12, 16, 20];
       '01661.810', 222, 'EN 1661', '8', 'zinc plated', ...
         [5, 6, 8, 10, 12, 16, 20];
       '01661.100', 222, 'EN 1661', '10', 'plain', ...
         [5, 6, 8, 10, 12, 16, 20];
       '01661.110', 222, 'EN 1661', '10', 'zinc plated', ...
         [5, 6, 8, 10, 12, 16, 20];
       '01663.810', 223, 'EN 1663', '8', 'zinc plated', ...
         [5, 6, 8, 16];
       '01664.810', 223, 'EN 1664', '8', 'zinc plated', ...
         [5, 6, 8, 10, 12, 16];
       '01661.920', 521, 'EN 1661', 'A2', 'plain', ...
         [5, 6, 8, 10, 12];
       '01661.940', 521, 'EN 1661', 'A4', 'plain', ...
         [5, 6, 8, 10];
      };
  ## END generated

  n = cellfun (@numel, A(:,6));
  a = repelem ((1:rows (A))', n);
  d = [A{:,6}]';
  std = A(a,3);
  h = NaN (numel (a), 10);
  for k = unique (std)'
    T = sizes (k{1});
    pick = strcmp (std, k{1});
    [~, r] = ismember (d(pick), T(:,1));
    h(pick,:) = T(r,:);
  endfor
  name = parts.__designation__ (denomof (std), std, h(:,1), h(:,2), [], []);
  grade = repmat ({'B'}, numel (a), 1);
  grade(h(:,1) <= 16) = {'A'};
  source = arrayfun (@(p) sprintf ("REYHER, The Catalogue, 2020.04, p. %d", ...
                                   p), [A{:,2}]', 'UniformOutput', false);

  F = [name, std, num2cell(h), grade, A(a,4:5), ...
       repmat({'REYHER'}, numel (a), 1), A(a,1), source(a)]';
  E = cell2struct (F, {'designation', 'standard', 'd', 'P', 's', 'e', 'm', ...
                       'h', 'dc', 'c', 'dw', 'da', 'grade', 'class', ...
                       'finish', 'maker', 'article', 'source'}, 1)';
  [~, k] = sortrows (h(:,1:2), [1, 2]);
  E = E(k);

endfunction

function S = shape (d, P, lock, family, detailed)

  std = standardof (family, lock, false);
  T = sizes (std);
  h = T(T(:,1) == d,:);
  if (isempty (h))
    error ("parts.nut.flange: %s defines no M%g nut.", std, d);
  endif
  if (isnan (P))
    P = h(2);
  elseif (P != h(2))
    fstd = standardof (family, lock, true);
    std = '';
    if (! isempty (fstd))
      F = sizes (fstd);
      k = F(:,1) == d & F(:,2) == P;
      if (any (k))
        h = F(k,:);
        std = fstd;
      endif
    endif
  endif
  kstd = standardof (family, lock, false);
  denom = denomof ({kstd}){1};
  [name, tname] = parts.__designation__ (denom, std, d, P, [], []);

  s = h(3);
  H = h(6);
  dc = h(7);
  c = h(8);
  a = pi / 3 * (0:5)';
  X = geom.Region (s / sqrt (3) * [cos(a), sin(a)]);
  if (detailed)
    dw = h(9);
    da = h(10);
    ## The hexagon, its top chamfered at 30 degrees from the flats
    S = solid.extrude (X, H);
    q = 0.6 * s;
    t = (q - s / 2) * tand (30);
    R = geom.Region ([0, 0; q, 0; q, H - t; s / 2, H; 0, H]);
    R.UCS = geom.UCS ([0, -1, 0], [0, 0, 0]);
    S = intersect (S, solid.revolve (R));
    ## The flange, c thick at dw, its top a cone at 15 degrees
    e = c - (dc - dw) / 2 * tand (15);
    z = c + (dw - s) / 2 * tand (15);
    R = geom.Region ([0, 0; dc / 2, 0; dc / 2, e; s / 2, z; 0, z]);
    R.UCS = geom.UCS ([0, -1, 0], [0, 0, 0]);
    S = union (S, solid.revolve (R));
    ## The tapping drill, countersunk, then the thread
    D = solid.holespec (tname, 'Custom', true);
    S = hole (S, [0, 0, 0], D.drill, Inf, 'Countersink', [da, 120], ...
              'Direction', [0, 0, 1]);
    if (isempty (lock))
      S = hole (S, [0, 0, H], D.drill, Inf, 'Countersink', [da, 120]);
    endif
    S = thread (S, [0, 0, H], tname, H, 'Custom', true);
  else
    S = union (solid.extrude (X, H), solid.cylinder (dc / 2, c));
    S = subtract (S, solid.cylinder (d / 2, H));
  endif
  S.Name = name;

endfunction

%!test  # an EN 1661 nut
%! C = parts.nut.flange ('data', 'M8');
%! E = C(strcmp ({C.article}, '01661.800'));
%! assert_equal ({E.designation, E.grade, E.class, E.finish}, ...
%!               {'Hexagon nut EN 1661 - M8', 'A', '8', 'plain'});
%!test  # its dimensions
%! C = parts.nut.flange ('data', 'M8');
%! E = C(strcmp ({C.article}, '01661.800'));
%! assert_equal ([E.d, E.P, E.s, E.m, E.h, E.dc, E.c], ...
%!               [8, 1.25, 13, 8, 8, 17.9, 1.2]);
%!test  # its source
%! C = parts.nut.flange ('data', 'M8');
%! E = C(strcmp ({C.article}, '01661.800'));
%! assert_equal (E.source, 'REYHER, The Catalogue, 2020.04, p. 222');
%!test  # 16 across flats at M10 in EN
%! C = parts.nut.flange ('data', 'M10', 'Locking', false);
%! assert_equal (unique ([C.s, C.e]), [16, 17.77]);
%!test  # an insert nut, EN 1663
%! C = parts.nut.flange ('data', 'M6', 'Locking', 'insert');
%! assert_equal ({C.designation, C.m, C.h}, ...
%!               {'Hexagon nut EN 1663 - M6', 5.7, 9.1});
%!test  # true is the insert
%! C = parts.nut.flange ('data', 'M6', 'Locking', true);
%! assert_equal ({C.standard}, {'EN 1663'});
%!test  # an all-metal nut, EN 1664
%! C = parts.nut.flange ('data', 'M6', 'Locking', 'metal');
%! assert_equal ({C.standard, C.h}, {'EN 1664', 7.3});
%!test  # EN's own m min at M8 to M12
%! C = parts.nut.flange ('data', 'M10', 'Locking', 'metal');
%! assert_equal (C.m, 9.6);
%!test  # 'Standard' keeps that standard
%! C = parts.nut.flange ('data', 'M8', 'Standard', 'EN');
%! assert_equal (unique ({C.standard}), {'EN 1661', 'EN 1663', 'EN 1664'});
%!test  # grades
%! C = parts.nut.flange ('data', 'M20');
%! assert_equal (unique ({C.grade}), {'B'});
%!test  # sorted by size
%! C = parts.nut.flange ('data');
%! assert_equal (issorted ([C.d]), true);
%!test  # 'Maker' in any case
%! C = parts.nut.flange ('data', 'M8', 'Maker', 'reyher');
%! assert_equal (unique ({C.maker}), {'REYHER'});
%!testif ; exist ('__occt__') == 3  # a disc under a prism, with its bore
%! S = parts.nut.flange ('solid', 'M10');
%! V = 3 * sqrt (3) / 2 * (15 / sqrt (3)) ^ 2 * (10 - 1.5) ...
%!     + pi * 10.9 ^ 2 * 1.5 - pi * 25 * 10;
%! assert_equal (volume (S), V, 1e-6);
%!testif ; exist ('__occt__') == 3  # the bearing face on the plane
%! S = parts.nut.flange ('solid', 'M10');
%! assert_equal (bbox (S), [-10.9, -10.9, 0, 10.9, 10.9, 10], 1e-6);
%!testif ; exist ('__occt__') == 3  # its name
%! S = parts.nut.flange ('solid', 'M10');
%! assert_equal (S.Name, {'Hexagon nut with flange ISO 4161 - M10'});
%!testif ; exist ('__occt__') == 3  # EN at M10
%! S = parts.nut.flange ('solid', 'M10', 'Standard', 'EN');
%! V = 3 * sqrt (3) / 2 * (16 / sqrt (3)) ^ 2 * (10 - 1.5) ...
%!     + pi * 10.9 ^ 2 * 1.5 - pi * 25 * 10;
%! assert_equal (volume (S), V, 1e-6);
%!testif ; exist ('__occt__') == 3  # an all-metal nut is h high
%! S = parts.nut.flange ('solid', 'M10', 'Locking', 'metal');
%! B = bbox (S);
%! assert_equal (B(6), 11.4, 1e-6);
%!testif ; exist ('__occt__') == 3  # a fine thread, ISO 10663
%! S = parts.nut.flange ('solid', 'M12x1.25');
%! assert_equal (S.Name, {'Hexagon nut with flange ISO 10663 - M12x1.25'});
%!testif ; exist ('__occt__') == 3  # all-metal, ISO 12126
%! S = parts.nut.flange ('solid', 'M12x1.5', 'Locking', 'metal');
%! assert_equal (S.Name, ...
%!   {'Prevailing torque type hexagon nut with flange ISO 12126 - M12x1.5'});
%!testif ; exist ('__occt__') == 3  # a fine insert nut, ISO 12125
%! S = parts.nut.flange ('solid', 'M12x1.5', 'Locking', 'insert');
%! assert_equal (S.Name, ...
%!   {'Prevailing torque type hexagon nut with flange ISO 12125 - M12x1.5'});
%!testif ; exist ('__occt__') == 3  # an EN nut with a fine thread: custom
%! S = parts.nut.flange ('solid', 'M12x1.5', 'Standard', 'EN');
%! assert_equal (S.Name, {'Hexagon nut M12x1.5'});
%!testif ; exist ('__occt__') == 3  # EN 1661 detailed
%! S = parts.nut.flange ('solid', 'M10', 'Standard', 'EN', 'Detailed', true);
%! assert_equal (isvalid (S), true);
%!testif ; exist ('__occt__') == 3  # detailed: valid
%! S = parts.nut.flange ('solid', 'M10', 'Detailed', true);
%! assert_equal (isvalid (S), true);
%!testif ; exist ('__occt__') == 3  # the flange c thick at dw
%! S = parts.nut.flange ('solid', 'M10', 'Detailed', true);
%! B = bbox (intersect (S, translate (solid.box (0.01, 30, 30), ...
%!                                    [9.8 - 0.005, -15, 0])));
%! assert_equal (B(6), 1.5 + 0.005 * tand (15), 1e-6);
%!testif ; exist ('__occt__') == 3  # detailed insert nut: valid
%! S = parts.nut.flange ('solid', 'M8', 'Locking', 'insert', 'Detailed', true);
%! assert_equal (isvalid (S), true);

%!error<parts.nut.flange: MODE must be 'data' or 'solid'.> ...
%! parts.nut.flange ('cad')
%!error<parts.nut.flange: a solid needs a NAME.> parts.nut.flange ('solid')
%!error<parts.nut.flange: Name/Value arguments must come in pairs.> ...
%! parts.nut.flange ('data', 'M8', 'Locking')
%!error<parts.nut.flange: option names must be character vectors.> ...
%! parts.nut.flange ('data', 'M8', 1, 2)
%!error<parts.nut.flange: 'Locking' must be false, 'insert', true or 'metal'.> ...
%! parts.nut.flange ('data', 'M8', 'Locking', 'glue')
%!error<parts.nut.flange: 'Locking' must be false, 'insert', true or 'metal'.> ...
%! parts.nut.flange ('data', 'M8', 'Locking', 1)
%!error<parts.nut.flange: 'Standard' must be 'ISO' or 'EN'.> ...
%! parts.nut.flange ('data', 'M8', 'Standard', 'DIN')
%!error<parts.nut.flange: 'Maker' applies to 'data' only.> ...
%! parts.nut.flange ('solid', 'M8', 'Maker', 'REYHER')
%!error<parts.nut.flange: 'Maker' must be a character vector.> ...
%! parts.nut.flange ('data', 'M8', 'Maker', 3)
%!error<parts.nut.flange: 'Detailed' applies to 'solid' only.> ...
%! parts.nut.flange ('data', 'M8', 'Detailed', true)
%!error<parts.nut.flange: 'Detailed' must be true or false.> ...
%! parts.nut.flange ('solid', 'M8', 'Detailed', 'yes')
%!error<parts.nut.flange: 'Detailed' must be true or false.> ...
%! parts.nut.flange ('solid', 'M8', 'Detailed', 1)
%!error<parts.nut.flange: unknown option 'Thin'.> ...
%! parts.nut.flange ('data', 'M8', 'Thin', true)
%!error<parts.nut.flange: NAME must name a metric thread, such as 'M10' or 'M10x1.25'.> ...
%! parts.nut.flange ('data', 'M8x')
%!error<parts.nut.flange: ISO 4161 defines no M4 nut.> ...
%! parts.nut.flange ('solid', 'M4')
%!error<parts.nut.flange: no M4 hexagon nut with flange in the catalogue.> ...
%! parts.nut.flange ('data', 'M4')
%!error<parts.nut.flange: no M14 EN prevailing torque hexagon nut with flange in the catalogue.> ...
%! parts.nut.flange ('data', 'M14', 'Standard', 'EN', 'Locking', 'metal')
%!error<parts.nut.flange: no M8 hexagon nut with flange by ACME in the catalogue.> ...
%! parts.nut.flange ('data', 'M8', 'Maker', 'ACME')
