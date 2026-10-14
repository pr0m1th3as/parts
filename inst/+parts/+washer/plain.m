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
## @deftypefn  {parts} {@var{C} =} parts.washer.plain (@qcode{'data'})
## @deftypefnx {parts} {@var{C} =} parts.washer.plain (@qcode{'data'}, @var{NAME})
## @deftypefnx {parts} {@var{S} =} parts.washer.plain (@qcode{'solid'}, @var{NAME})
## @deftypefnx {parts} {@dots{} =} parts.washer.plain (@dots{}, @var{Name}, @var{Value})
##
## Plain washers, product grade A: normal series, ISO 7089, and chamfered,
## ISO 7090, small series, ISO 7092, and large series, ISO 7093-1.
##
## @code{@var{C} = parts.washer.plain (@qcode{'data'})} returns every plain
## washer in the catalogue as a table, one row for each maker's article in
## each size, sorted by size.
## @code{@var{C} = parts.washer.plain (@qcode{'data'}, @var{NAME})} returns
## those for the screw thread @var{NAME}, as @qcode{'M8'}: every article
## sold as that washer, each with its hardness class, material and finish.
## Nothing is built.
##
## @code{@var{S} = parts.washer.plain (@qcode{'solid'}, @var{NAME})} builds
## the washer as a @code{solid.Shape}, whether or not anyone sells it, in
## any size its standard defines: a ring @var{d1} across inside, @var{d2}
## outside and @var{h} thick, lying on the @math{xy} plane with its axis on
## the @math{z} axis.  @code{@var{S}.Name} holds the designation.
##
## Name/Value pairs:
##
## @table @asis
## @item @qcode{'Series'}
## @qcode{'normal'}, the default for @qcode{'solid'}, @qcode{'small'} or
## @qcode{'large'}.  For @qcode{'data'} it keeps that series only; without
## it all come.
##
## @item @qcode{'Chamfer'}
## @code{true} for the chamfered washer of ISO 7090, normal series only,
## @code{false} for one without, the default for @qcode{'solid'}.  For
## @qcode{'data'} it keeps that kind only; without it both come.
##
## @item @qcode{'Maker'}
## For @qcode{'data'}: only that maker's articles, such as
## @qcode{'REYHER'}, in any case.
##
## @item @qcode{'Detailed'}
## For @qcode{'solid'}: @code{true} chamfers a washer of ISO 7090 on the
## outside edge of its top face, at 30 degrees to the axis and @var{h}/4
## deep, the smallest chamfer the standard allows.  By default
## (@code{false}) it is a plain ring.  The other washers have no detail.
## @end table
##
## The table has these variables, each with its unit and its description,
## which @code{summary (@var{C})} lists; lengths are in millimetres:
##
## @multitable @columnfractions 0.16 0.84
## @item @code{designation} @tab designation of the standard, as in
## @qcode{'Washer ISO 7089 - 8'}, without the hardness class
## @item @code{standard} @tab standard
## @item @code{d} @tab nominal size, the diameter of the screw thread
## @item @code{d1} @tab inside diameter, nominal, the smallest
## @item @code{d2} @tab outside diameter, nominal, the largest
## @item @code{h} @tab thickness, nominal
## @item @code{class} @tab hardness class, @qcode{'200 HV'} or
## @qcode{'300 HV'}; empty for a material the standards give none
## @item @code{material} @tab @qcode{'steel'}, a stainless steel as
## @qcode{'A2'}, or another as @qcode{'brass'}
## @item @code{finish} @tab finish as the maker names it, as
## @qcode{'plain'} or @qcode{'zinc plated'}
## @item @code{maker} @tab maker
## @item @code{article} @tab maker's article number
## @item @code{source} @tab catalogue and page the article was read from
## @end multitable
##
## @subheading The catalogue
##
## Articles from REYHER, @cite{The Catalogue}, edition 2020.04, English,
## pages 333 to 338 (steel), 567 to 570 (stainless steel) and 639 to 641
## (brass, copper, aluminium): every article of the four standards in sizes
## they define.  Left out: the polyamide washers sold as ISO 7089 in
## product grade C, the large series of ISO 7093-2, grade C, and the
## articles of DIN 125, 433 and 9021, withdrawn and replaced by these
## standards.
##
## Dimensions from ISO 7089, 7090, 7092 and 7093-1, all 2000, Tables 1 and
## 2: ISO 7089 and 7090 read in DIN EN ISO 7089 and 7090:2000, ISO 7092 and
## 7093-1 in GOST ISO 7092-2016 and 7093-1-2016, all adopting them
## unchanged, and checked against the tolerances of ISO 4759-3:2000, read in
## IS 15274:2003; REYHER's @cite{Technical Information} (2019, TI-84 and 85)
## agrees in every nominal dimension but its ISO 7093 column, which carries
## DIN 9021's.
##
## @seealso{parts.nut.hex, parts.screw.hex}
## @end deftypefn

function OUT = plain (MODE, varargin)

  if (nargin < 1 || ! ischar (MODE)
      || ! any (strcmp (MODE, {'data', 'solid'})))
    error ("parts.washer.plain: MODE must be 'data' or 'solid'.");
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
    error ("parts.washer.plain: a solid needs a NAME.");
  endif

  series = 'normal';
  byseries = false;
  chamfer = false;
  bychamfer = false;
  maker = '';
  detailed = false;
  if (mod (numel (args), 2) != 0)
    error ("parts.washer.plain: Name/Value arguments must come in pairs.");
  endif
  for ii = 1:2:numel (args)
    name = args{ii};
    val = args{ii+1};
    if (! ischar (name) || ! isrow (name))
      error ("parts.washer.plain: option names must be character vectors.");
    endif
    switch (lower (name))
      case 'series'
        if (! ischar (val)
            || ! any (strcmpi (val, {'normal', 'small', 'large'})))
          error (strcat ("parts.washer.plain: 'Series' must be 'normal',", ...
                         " 'small' or 'large'."));
        endif
        series = lower (val);
        byseries = true;
      case 'chamfer'
        if (! islogical (val) || ! isscalar (val))
          error ("parts.washer.plain: 'Chamfer' must be true or false.");
        endif
        chamfer = val;
        bychamfer = true;
      case 'maker'
        if (strcmp (MODE, 'solid'))
          error ("parts.washer.plain: 'Maker' applies to 'data' only.");
        endif
        if (! ischar (val) || ! isrow (val))
          error ("parts.washer.plain: 'Maker' must be a character vector.");
        endif
        maker = val;
      case 'detailed'
        if (strcmp (MODE, 'data'))
          error ("parts.washer.plain: 'Detailed' applies to 'solid' only.");
        endif
        if (! islogical (val) || ! isscalar (val))
          error ("parts.washer.plain: 'Detailed' must be true or false.");
        endif
        detailed = val;
      otherwise
        error ("parts.washer.plain: unknown option '%s'.", name);
    endswitch
  endfor
  if (chamfer && ! strcmp (series, 'normal'))
    error (strcat ("parts.washer.plain: a chamfered washer, ISO 7090, is", ...
                   " of the normal series only."));
  endif

  ## The thread
  d = [];
  if (! isempty (NAME))
    tok = regexp (NAME, '^M(\d+(?:\.\d+)?)$', 'tokens', 'once');
    if (isempty (tok))
      error (strcat ("parts.washer.plain: NAME must name a metric thread", ...
                     " by its diameter, such as 'M8'."));
    endif
    d = str2double (tok{1});
  endif

  if (strcmp (MODE, 'data'))
    OUT = catalogue (NAME, d, series, byseries, chamfer, bychamfer, maker);
  else
    OUT = shape (d, series, chamfer, detailed);
  endif

endfunction

## The washers of each standard, a row for each size: d, d1 min, d2 max,
## h nom.  Tables 1 and 2 of each.
function T = sizes (std)

  switch (std)
    case 'ISO 7089'
      T = [1.6, 1.7, 4, 0.3; 2, 2.2, 5, 0.3; 2.5, 2.7, 6, 0.5;
           3, 3.2, 7, 0.5; 3.5, 3.7, 8, 0.5; 4, 4.3, 9, 0.8;
           5, 5.3, 10, 1; 6, 6.4, 12, 1.6; 8, 8.4, 16, 1.6;
           10, 10.5, 20, 2; 12, 13, 24, 2.5; 14, 15, 28, 2.5;
           16, 17, 30, 3; 18, 19, 34, 3; 20, 21, 37, 3; 22, 23, 39, 3;
           24, 25, 44, 4; 27, 28, 50, 4; 30, 31, 56, 4; 33, 34, 60, 5;
           36, 37, 66, 5; 39, 42, 72, 6; 42, 45, 78, 8; 45, 48, 85, 8;
           48, 52, 92, 8; 52, 56, 98, 8; 56, 62, 105, 10;
           60, 66, 110, 10; 64, 70, 115, 10];
    case 'ISO 7090'
      T = sizes ('ISO 7089');
      T = T(T(:,1) >= 5,:);
    case 'ISO 7092'
      T = [1.6, 1.7, 3.5, 0.3; 2, 2.2, 4.5, 0.3; 2.5, 2.7, 5, 0.5;
           3, 3.2, 6, 0.5; 3.5, 3.7, 7, 0.5; 4, 4.3, 8, 0.5;
           5, 5.3, 9, 1; 6, 6.4, 11, 1.6; 8, 8.4, 15, 1.6;
           10, 10.5, 18, 1.6; 12, 13, 20, 2; 14, 15, 24, 2.5;
           16, 17, 28, 2.5; 18, 19, 30, 3; 20, 21, 34, 3; 22, 23, 37, 3;
           24, 25, 39, 4; 27, 28, 44, 4; 30, 31, 50, 4; 33, 34, 56, 5;
           36, 37, 60, 5];
    case 'ISO 7093-1'
      T = [3, 3.2, 9, 0.8; 3.5, 3.7, 11, 0.8; 4, 4.3, 12, 1;
           5, 5.3, 15, 1; 6, 6.4, 18, 1.6; 8, 8.4, 24, 2;
           10, 10.5, 30, 2.5; 12, 13, 37, 3; 14, 15, 44, 3;
           16, 17, 50, 3; 18, 19, 56, 4; 20, 21, 60, 4; 22, 23, 66, 5;
           24, 25, 72, 5; 27, 30, 85, 6; 30, 33, 92, 6; 33, 36, 105, 6;
           36, 39, 110, 8];
  endswitch

endfunction

## The standard of a series, chamfered or not
function std = standardof (series, chamfer)

  switch (series)
    case 'normal'
      std = 'ISO 7089';
      if (chamfer)
        std = 'ISO 7090';
      endif
    case 'small'
      std = 'ISO 7092';
    case 'large'
      std = 'ISO 7093-1';
  endswitch

endfunction

function C = catalogue (NAME, d, series, byseries, chamfer, bychamfer, maker)

  ## Built on the first call, kept for the session
  persistent E;
  if (isempty (E))
    E = entries ();
  endif

  keep = true (height (E), 1);
  if (! isempty (d))
    keep &= E.d == d;
  endif
  std = E.standard;
  if (byseries)
    switch (series)
      case 'normal'
        keep &= ismember (std, {'ISO 7089', 'ISO 7090'});
      case 'small'
        keep &= strcmp (std, 'ISO 7092');
      case 'large'
        keep &= strcmp (std, 'ISO 7093-1');
    endswitch
  endif
  if (bychamfer)
    keep &= strcmp (std, 'ISO 7090') == chamfer;
  endif
  if (! isempty (maker))
    keep &= strcmpi (E.maker, maker);
  endif
  C = E(keep,:);

  if (height (C) == 0)
    what = '';
    if (! isempty (NAME))
      what = [NAME, ' '];
    endif
    kind = 'plain washer';
    if (bychamfer && chamfer)
      kind = 'chamfered washer';
    endif
    if (byseries)
      kind = sprintf ("%s, %s series,", kind, series);
    endif
    how = '';
    if (! isempty (maker))
      how = sprintf (" by %s", maker);
    endif
    error ("parts.washer.plain: no %s%s%s in the catalogue.", what, kind, ...
           how);
  endif

endfunction

## Every entry of the catalogue, sorted by size
function E = entries ()

  ## BEGIN generated by tools/reyher_tables.py washer
  ## REYHER article, printed page, standard, hardness class, material,
  ## finish; then its sizes
  A = {'07089.000', 333, '7089', '200 HV', 'steel', 'plain', ...
         [1.6, 2, 2.5, 3, 4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 27, ...
          30, 33, 36];
       '07089.010', 333, '7089', '200 HV', 'steel', 'zinc plated', ...
         [2, 2.5, 3, 4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 27, 30, ...
          33, 36];
       '07089.080', 334, '7089', '200 HV', 'steel', 'zinc plated 8 TLP', ...
         [5, 6, 8, 10, 12, 16, 20, 24, 30, 36];
       '07089.428', 334, '7089', '200 HV', 'steel', 'zinc plated 8 TLP + S', ...
         [3, 4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 24, 30, 36];
       '07089.020', 334, '7089', '200 HV', 'steel', 'hot dip galvanized', ...
         [6, 8, 10, 12, 14, 16, 18, 20, 24, 27, 30, 33];
       '07089.031', 334, '7089', '200 HV', 'steel', 'nickel plated', ...
         [3, 4, 5, 6, 8, 10];
       '07089.005', 334, '7089', '200 HV', 'steel', 'nitro carburet', ...
         [12, 16, 20, 24, 27, 30, 33, 36, 39];
       '07089.012', 334, '7089', '200 HV', 'steel', 'zp, nitro carburet', ...
         [12, 16, 20, 24, 27, 30, 33, 36, 39];
       '07089.004', 335, '7089', '300 HV', 'steel', 'plain', ...
         [4, 5, 6, 8, 10, 12, 16, 20, 24, 30];
       '07089.015', 335, '7089', '300 HV', 'steel', 'zinc plated', ...
         [4, 5, 6, 8, 10, 12, 16, 20, 24, 27, 30, 36];
       '07089.438', 335, '7089', '300 HV', 'steel', 'zinc plated 8 TLP + S', ...
         [4, 5, 6, 8, 10, 12, 16, 20, 24];
       '07089.013', 335, '7089', '300 HV', 'steel', 'zinc plated', ...
         [10, 12, 16, 20, 24, 27];
       '07089.024', 335, '7089', '300 HV', 'steel', 'hot dip galvanized', ...
         [10, 12, 16, 20, 24, 27, 30, 36];
       '07090.000', 335, '7090', '200 HV', 'steel', 'plain', ...
         [5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 27, 30, 33, 36, 39, 42, ...
          45, 48, 52, 56, 60, 64];
       '07090.010', 336, '7090', '200 HV', 'steel', 'zinc plated', ...
         [5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 27, 30, 33, 36, 39, 42, ...
          45, 48, 52, 56, 60, 64];
       '07090.080', 336, '7090', '200 HV', 'steel', 'zinc plated 8 TLP', ...
         [5, 6, 8, 10, 12, 16, 20, 24, 30, 36];
       '07090.428', 336, '7090', '200 HV', 'steel', 'zinc plated 8 TLP + S', ...
         [5, 6, 8, 10, 12, 16, 20, 22, 24, 27, 30, 36, 42, 48];
       '07090.353', 336, '7090', '200 HV', 'steel', 'flZn/TL480h', ...
         [6, 8, 10, 12, 14, 16, 18, 20, 22, 24];
       '07090.318', 336, '7090', '300 HV', 'steel', 'flZnL480h', ...
         [6, 8, 10, 12, 14, 16, 18, 20, 22, 24];
       '07090.020', 337, '7090', '200 HV', 'steel', 'hot dip galvanized', ...
         [6, 8, 10, 12, 16, 20, 22, 24, 27, 30, 33, 36, 39, 42, 45, 48, 52];
       '07090.016', 337, '7090', '300 HV', 'steel', 'zinc plated', ...
         [10, 12, 16, 20, 24, 27];
       '07090.026', 337, '7090', '300 HV', 'steel', 'hot dip galvanized', ...
         [8, 10, 12, 16, 20, 24, 27, 30, 36];
       '07092.004', 338, '7092', '200 HV', 'steel', 'plain', ...
         [2, 3, 3.5, 4, 5, 6, 8, 10, 12, 14, 16, 18, 20];
       '07092.014', 338, '7092', '200 HV', 'steel', 'zinc plated', ...
         [2, 2.5, 3, 4, 5, 6, 8, 10, 12, 14, 16, 18, 20];
       '07093.004', 338, '7093', '200 HV', 'steel', 'plain', ...
         [3, 4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 24, 30, 36];
       '07093.014', 338, '7093', '200 HV', 'steel', 'zinc plated', ...
         [3, 4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 24, 30, 36];
       '07093.024', 338, '7093', '200 HV', 'steel', 'hot dip galvanized', ...
         [6, 8, 10, 12, 16, 18, 20, 24, 30, 36];
       '07089.924', 567, '7089', '200 HV', 'A2', 'plain', ...
         [1.6, 2, 2.5, 3, 4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 27, ...
          30, 33, 36, 39, 42, 45, 48, 52, 56];
       '07089.944', 568, '7089', '200 HV', 'A4', 'plain', ...
         [2, 2.5, 3, 4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 27, 30, ...
          33, 36, 39, 42];
       '07089.941', 568, '7089', '200 HV', 'BUMAX88', 'plain', ...
         [24];
       '07089.942', 568, '7089', '300 HV', 'BUMAX109', 'plain', ...
         [5, 6, 8, 10, 12, 16, 20];
       '07089.954', 568, '7089', '200 HV', 'A5', 'plain', ...
         [6, 8, 10, 12, 16, 20, 24, 30];
       '07090.924', 568, '7090', '200 HV', 'A2', 'plain', ...
         [5, 6, 8, 10, 12, 16, 20, 24];
       '07090.944', 569, '7090', '200 HV', 'A4', 'plain', ...
         [5, 6, 8, 10, 12, 16, 18, 20, 24, 27, 30, 33, 36, 42, 45, 48, 52, ...
          56];
       '07090.954', 569, '7090', '200 HV', 'A5', 'plain', ...
         [5, 6, 8, 10, 12, 16, 20, 24, 30];
       '07092.924', 569, '7092', '200 HV', 'A2', 'plain', ...
         [2, 2.5, 3, 4, 5, 6, 8, 10, 12, 14, 16];
       '07092.944', 569, '7092', '200 HV', 'A4', 'plain', ...
         [3, 4, 5, 6, 8, 10, 12, 16, 20, 24];
       '07093.924', 569, '7093', '200 HV', 'A2', 'plain', ...
         [3, 4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 24];
       '07093.944', 570, '7093', '200 HV', 'A4', 'plain', ...
         [3, 4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24];
       '07093.954', 570, '7093', '200 HV', 'A5', 'plain', ...
         [5, 6, 8, 10, 12, 16, 20, 24];
       '07089.700', 639, '7089', '', 'brass', 'plain', ...
         [2, 2.5, 3, 3.5, 4, 5, 6, 8];
       '07089.730', 640, '7089', '', 'brass', 'nickel plated', ...
         [3, 4, 5, 6, 8];
       '07089.310', 640, '7089', '', 'copper', 'plain', ...
         [5, 6, 8, 10, 12, 16];
       '07089.311', 640, '7089', '', 'aluminium', 'plain', ...
         [3, 4, 5, 6, 8, 10, 12, 16];
       '07090.707', 640, '7090', '', 'brass', 'turned', ...
         [5, 6, 8, 10];
       '07090.700', 640, '7090', '', 'brass', 'plain', ...
         [10, 12, 14, 16, 18, 20, 22, 24, 27, 30, 36, 39, 42, 45, 48];
       '07092.700', 641, '7092', '', 'brass', 'plain', ...
         [2, 2.5, 3, 4, 5, 6, 8, 10, 12, 14, 16, 20];
      };
  ## END generated

  stds = {'7089', 'ISO 7089'; '7090', 'ISO 7090'; '7092', 'ISO 7092';
          '7093', 'ISO 7093-1'};
  n = cellfun (@numel, A(:,7));
  a = repelem ((1:rows (A))', n);
  d = [A{:,7}]';
  [~, j] = ismember (A(a,3), stds(:,1));
  std = stds(j,2);
  h = NaN (numel (a), 4);
  for k = 1:rows (stds)
    T = sizes (stds{k,2});
    pick = j == k;
    [~, r] = ismember (d(pick), T(:,1));
    h(pick,:) = T(r,:);
  endfor
  name = cellfun (@(s, x) sprintf ("Washer %s - %g", s, x), std, ...
                  num2cell (d), 'UniformOutput', false);
  source = arrayfun (@(p) sprintf ("REYHER, The Catalogue, 2020.04, p. %d", ...
                                   p), [A{:,2}]', 'UniformOutput', false);

  maker = repmat ({'REYHER'}, numel (a), 1);
  E = table (name, std, h(:,1), h(:,2), h(:,3), h(:,4), A(a,4), A(a,5), ...
             A(a,6), maker, A(a,1), source(a));
  E.Properties.VariableNames = {'designation', 'standard', 'd', 'd1', 'd2', ...
                                'h', 'class', 'material', 'finish', 'maker', ...
                                'article', 'source'};
  E.Properties.VariableUnits = {'', '', 'mm', 'mm', 'mm', 'mm', '', '', '', ...
                                '', '', ''};
  E.Properties.VariableDescriptions = {...
    'designation of the standard, without the hardness class', ...
    'standard', ...
    'nominal size, the diameter of the screw thread', ...
    'inside diameter, nominal, the smallest', ...
    'outside diameter, nominal, the largest', ...
    'thickness, nominal', ...
    'hardness class', ...
    'material', ...
    'finish as the maker names it', ...
    'maker', ...
    "maker's article number", ...
    'catalogue and page the article was read from'};
  E.Properties.Description = 'Plain washers, product grade A';
  E = sortrows (E, 'd');

endfunction

function S = shape (d, series, chamfer, detailed)

  std = standardof (series, chamfer);
  T = sizes (std);
  w = T(T(:,1) == d,:);
  if (isempty (w))
    error ("parts.washer.plain: %s defines no washer for M%g.", std, d);
  endif
  r1 = w(2) / 2;
  r2 = w(3) / 2;
  h = w(4);
  if (detailed && chamfer)
    ## 30 degrees to the axis, h/4 deep, on the top face's outside edge
    e = h / 4;
    c = e * tand (30);
    R = geom.Region ([r1, 0; r2, 0; r2, h - e; r2 - c, h; r1, h]);
  else
    R = geom.Region ([r1, 0; r2, 0; r2, h; r1, h]);
  endif
  R.UCS = geom.UCS ([0, -1, 0], [0, 0, 0]);
  S = solid.revolve (R);
  S.Name = sprintf ("Washer %s - %g", std, d);

endfunction

%!test  # an M8 washer of the normal series
%! C = parts.washer.plain ('data', 'M8', 'Series', 'normal', ...
%!                         'Chamfer', false);
%! E = C(strcmp (C.article, '07089.000'),:);
%! assert_equal ([E.designation, E.class, E.material, E.finish], ...
%!               {'Washer ISO 7089 - 8', '200 HV', 'steel', 'plain'});
%!test  # its dimensions
%! C = parts.washer.plain ('data', 'M8');
%! E = C(strcmp (C.article, '07089.000'),:);
%! assert_equal ([E.d, E.d1, E.d2, E.h], [8, 8.4, 16, 1.6]);
%!test  # its source
%! C = parts.washer.plain ('data', 'M8');
%! E = C(strcmp (C.article, '07089.000'),:);
%! assert_equal (E.source, {'REYHER, The Catalogue, 2020.04, p. 333'});
%!test  # each variable carries its unit and description
%! C = parts.washer.plain ('data', 'M8');
%! assert_equal (C.Properties.VariableUnits([3, 6]), {'mm', 'mm'});
%! assert_equal (C.Properties.VariableDescriptions{5}, ...
%!               'outside diameter, nominal, the largest');
%!test  # chamfered, ISO 7090
%! C = parts.washer.plain ('data', 'M10', 'Chamfer', true);
%! assert_equal (unique (C.designation), {'Washer ISO 7090 - 10'});
%!test  # the small series, ISO 7092
%! C = parts.washer.plain ('data', 'M10', 'Series', 'small');
%! assert_equal (unique (C.d2), 18);
%!test  # the large series, ISO 7093-1
%! C = parts.washer.plain ('data', 'M10', 'Series', 'large');
%! assert_equal (C.designation(1), {'Washer ISO 7093-1 - 10'});
%! assert_equal ([C.d2(1), C.h(1)], [30, 2.5]);
%!test  # the normal series holds both kinds
%! C = parts.washer.plain ('data', 'M10', 'Series', 'normal');
%! assert_equal (unique (C.standard), {'ISO 7089'; 'ISO 7090'});
%!test  # a hardened washer
%! C = parts.washer.plain ('data', 'M10');
%! E = C(strcmp (C.article, '07089.004'),:);
%! assert_equal (E.class, {'300 HV'});
%!test  # a material with no hardness class
%! C = parts.washer.plain ('data', 'M5');
%! E = C(strcmp (C.article, '07089.700'),:);
%! assert_equal ([E.class, E.material], {'', 'brass'});
%!test  # a stainless one
%! C = parts.washer.plain ('data', 'M5');
%! E = C(strcmp (C.article, '07089.924'),:);
%! assert_equal ([E.class, E.material], {'200 HV', 'A2'});
%!test  # above M36 the hole differs from DIN 125's
%! C = parts.washer.plain ('data', 'M42');
%! assert_equal (unique (C.d1), 45);
%!test  # sorted by size
%! C = parts.washer.plain ('data');
%! assert_equal (issorted (C.d), true);
%!test  # 'Maker' in any case
%! C = parts.washer.plain ('data', 'M8', 'Maker', 'reyher');
%! assert_equal (unique (C.maker), {'REYHER'});
%!testif ; exist ('__occt__') == 3  # a plain ring
%! S = parts.washer.plain ('solid', 'M8');
%! assert_equal (volume (S), pi * (8 ^ 2 - 4.2 ^ 2) * 1.6, 1e-6);
%!testif ; exist ('__occt__') == 3  # on the plane
%! S = parts.washer.plain ('solid', 'M8');
%! assert_equal (bbox (S), [-8, -8, 0, 8, 8, 1.6], 1e-6);
%!testif ; exist ('__occt__') == 3  # its name
%! S = parts.washer.plain ('solid', 'M8', 'Series', 'large');
%! assert_equal (S.Name, {'Washer ISO 7093-1 - 8'});
%!testif ; exist ('__occt__') == 3  # detailed: the chamfer of ISO 7090
%! S = parts.washer.plain ('solid', 'M8', 'Chamfer', true, 'Detailed', true);
%! e = 0.4;
%! c = e * tand (30);
%! V = pi * (8 ^ 2 - 4.2 ^ 2) * 1.6 - pi * e * c * (8 - c / 3);
%! assert_equal (volume (S), V, 1e-6);
%!testif ; exist ('__occt__') == 3  # a washer of ISO 7089 has no detail
%! S = parts.washer.plain ('solid', 'M8', 'Detailed', true);
%! assert_equal (volume (S), pi * (8 ^ 2 - 4.2 ^ 2) * 1.6, 1e-6);

%!error<parts.washer.plain: MODE must be 'data' or 'solid'.> ...
%! parts.washer.plain ('cad')
%!error<parts.washer.plain: a solid needs a NAME.> parts.washer.plain ('solid')
%!error<parts.washer.plain: Name/Value arguments must come in pairs.> ...
%! parts.washer.plain ('data', 'M8', 'Series')
%!error<parts.washer.plain: option names must be character vectors.> ...
%! parts.washer.plain ('data', 'M8', 1, 2)
%!error<parts.washer.plain: 'Series' must be 'normal', 'small' or 'large'.> ...
%! parts.washer.plain ('data', 'M8', 'Series', 'huge')
%!error<parts.washer.plain: 'Chamfer' must be true or false.> ...
%! parts.washer.plain ('data', 'M8', 'Chamfer', 'yes')
%!error<parts.washer.plain: 'Chamfer' must be true or false.> ...
%! parts.washer.plain ('data', 'M8', 'Chamfer', 1)
%!error<parts.washer.plain: 'Maker' applies to 'data' only.> ...
%! parts.washer.plain ('solid', 'M8', 'Maker', 'REYHER')
%!error<parts.washer.plain: 'Maker' must be a character vector.> ...
%! parts.washer.plain ('data', 'M8', 'Maker', 3)
%!error<parts.washer.plain: 'Detailed' applies to 'solid' only.> ...
%! parts.washer.plain ('data', 'M8', 'Detailed', true)
%!error<parts.washer.plain: 'Detailed' must be true or false.> ...
%! parts.washer.plain ('solid', 'M8', 'Detailed', 'yes')
%!error<parts.washer.plain: 'Detailed' must be true or false.> ...
%! parts.washer.plain ('solid', 'M8', 'Detailed', 1)
%!error<parts.washer.plain: unknown option 'Grade'.> ...
%! parts.washer.plain ('data', 'M8', 'Grade', 'A')
%!error<parts.washer.plain: a chamfered washer, ISO 7090, is of the normal series only.> ...
%! parts.washer.plain ('solid', 'M8', 'Series', 'small', 'Chamfer', true)
%!error<parts.washer.plain: NAME must name a metric thread by its diameter, such as 'M8'.> ...
%! parts.washer.plain ('data', 'M8x1')
%!error<parts.washer.plain: ISO 7090 defines no washer for M4.> ...
%! parts.washer.plain ('solid', 'M4', 'Chamfer', true)
%!error<parts.washer.plain: no M7 plain washer in the catalogue.> ...
%! parts.washer.plain ('data', 'M7')
%!error<parts.washer.plain: no M8 chamfered washer, normal series, by ACME in the catalogue.> ...
%! parts.washer.plain ('data', 'M8', 'Series', 'normal', 'Chamfer', true, ...
%!                     'Maker', 'ACME')
