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
## @deftypefn  {parts} {@var{C} =} parts.insert.heatset (@qcode{'data'})
## @deftypefnx {parts} {@var{C} =} parts.insert.heatset (@qcode{'data'}, @var{NAME})
## @deftypefnx {parts} {@var{C} =} parts.insert.heatset (@qcode{'data'}, @var{NAME}, @var{L})
## @deftypefnx {parts} {@var{S} =} parts.insert.heatset (@qcode{'solid'}, @var{NAME}, @var{L})
## @deftypefnx {parts} {@dots{} =} parts.insert.heatset (@dots{}, @var{Name}, @var{Value})
##
## Heat-set threaded inserts: knurled brass inserts with a metric thread,
## pressed hot into a hole in a 3D-printed or other thermoplastic part.
##
## @code{@var{C} = parts.insert.heatset (@qcode{'data'})} returns every insert
## in the catalogue as a table, one row for each insert and maker that sells
## it, sorted by thread, length and outside diameter.
## @code{@var{C} = parts.insert.heatset (@qcode{'data'}, @var{NAME})} returns
## those of the thread @var{NAME}, as @qcode{'M4'}, and
## @code{@var{C} = parts.insert.heatset (@qcode{'data'}, @var{NAME}, @var{L})}
## those @var{L} millimetres long, each with the hole it needs.  Nothing is
## built.
##
## @code{@var{S} = parts.insert.heatset (@qcode{'solid'}, @var{NAME}, @var{L})}
## builds the insert as a @code{solid.Shape}: its top face, where the screw
## enters, on the @math{xy} plane, the insert below it to @math{z} =
## -@var{L}, its axis on the @math{z} axis.  Placed at the mouth of a hole
## drilled along -@math{z}, it sits flush with the surface, as it is set.
## @code{@var{S}.Name} holds the designation, as
## @qcode{'Heat-set insert M4 x 8.1'}.  Only inserts in the catalogue are
## built, to ruthex's dimensions where ruthex sells the insert, else to CNC
## Kitchen's.
##
## No function cuts or sizes the hole, here or in @code{drafting}: a printed
## hole comes out a different size with each printer, material and setting,
## so the designer makes it.  A row's @var{d3} is its maker's recommendation
## to start from; its @var{t} and @var{w} are the depth and wall the part
## must leave for the insert.
##
## Name/Value pairs:
##
## @table @asis
## @item @qcode{'Maker'}
## For @qcode{'data'}: only that maker's rows, @qcode{'ruthex'} or
## @qcode{'CNC Kitchen'}, in any case.
##
## @item @qcode{'Diameter'}
## Only the insert of that outside diameter @var{d1}.  Two inserts are M3 x
## 4, one 4.6 and one 5 across, the second made for the Voron printers, and a
## solid of either needs it.
##
## @item @qcode{'Detailed'}
## For @qcode{'solid'}: @code{true} knurls the two bands, chamfers the end
## of the pilot and cuts the thread through by @code{solid.Shape.thread}.  By
## default (@code{false}) the insert has its outline, the bands plain at
## @var{d1}, a groove after each and the pilot, with a bore of the thread's
## nominal diameter.
## @end table
##
## The table has these variables, each with its unit and its description,
## which @code{summary (@var{C})} lists; lengths are in millimetres:
##
## @multitable @columnfractions 0.16 0.84
## @item @code{designation} @tab thread by length, as @qcode{'M4 x 8.1'},
## and by outside diameter between them where two inserts share both, as
## @qcode{'M3 x 5 x 4'}
## @item @code{thread} @tab thread, as @qcode{'M4'}
## @item @code{d} @tab nominal diameter of the thread
## @item @code{L} @tab length, nominal
## @item @code{d1} @tab outside diameter, over the knurl
## @item @code{d2} @tab diameter of the pilot at the lower end; @code{NaN}
## where the maker gives none
## @item @code{d3} @tab diameter of the hole the maker recommends
## @item @code{t} @tab depth of a blind hole, smallest: @var{L} + 1
## @item @code{w} @tab wall round the hole, smallest
## @item @code{maker} @tab maker
## @item @code{article} @tab maker's article number; empty where the maker's
## document gives none
## @item @code{source} @tab document the insert was read from
## @end multitable
##
## @subheading The form
##
## The makers' inserts differ only in their knurls, which no fit depends on,
## so every insert is built to one form from its own @var{L},
## @var{d1} and @var{d2}, in proportions read from the makers' models.  This
## form is a modelling choice; no maker dimensions it.  Where no maker gives
## @var{d2}, the pilot is 0.1 smaller than the hole, as ruthex's are.  With
## @math{h = (d1 - d2) / 2}, from the top down:
##
## @multitable @columnfractions 0.24 0.38 0.38
## @headitem Feature @tab From the top @tab Diameter
## @item upper band @tab 0 to 0.29 @var{L} @tab @var{d1}, knurled
## left-hand at 50 degrees
## @item groove @tab 0.29 @var{L} to 0.40 @var{L} @tab @var{d2} - 0.75
## @math{h}
## @item lower band @tab 0.40 @var{L} to 0.75 @var{L} @tab @var{d1},
## knurled right-hand at 45 degrees
## @item groove @tab 0.75 @var{L} to 0.85 @var{L} @tab @var{d2} - 1.25
## @math{h}
## @item pilot @tab 0.85 @var{L} to @var{L} @tab @var{d2}, chamfered
## @var{L}/50 at 45 degrees at its end when detailed
## @end multitable
##
## The bands are knurled only when detailed.  The knurls have the teeth of
## 90 degrees of DIN 82, cut to full depth with their roots at @var{d2}: a
## pitch of @math{2 h}, fitted by @code{solid.Shape.knurl} to a whole number
## of teeth.
##
## @subheading The catalogue
##
## Every insert ruthex or CNC Kitchen sells with a metric thread, a row for
## each maker with its own values.  Where both sell an insert they agree,
## except that CNC Kitchen recommends holes 0.1 larger from M4 to M8, gives
## M8 x 12.7 an outside diameter of 10.2 against 10.1, and gives the M3 x 5
## x 4 a wall of 1.6 against 1.3.
##
## ruthex: the @cite{RX series product data sheet}, metric ISO thread, status
## 15.08.2022, page 1, dimensions and order numbers, for every insert but two
## sold since, read from the drawings and item numbers on their packets as
## ruthex.de shows them: M6 x 6.8 (RX-M6Sx6.8) and M10 x 12.7
## (RX-M10x12.7).
##
## CNC Kitchen: @cite{Dimensions & Design Guidelines}, metric inserts, June
## 2025.  It gives no pilot diameter and no article numbers.
##
## The depth of a blind hole, @var{L} + 1, is drawn by both.  The proportions
## of the form come from the makers' own published STEP models,
## measured: ruthex's ten metric models and CNC Kitchen's twelve.
##
## @seealso{parts.screw.cap, parts.nut.hex}
## @end deftypefn

function OUT = heatset (MODE, varargin)

  if (nargin < 1 || ! ischar (MODE)
      || ! any (strcmp (MODE, {'data', 'solid'})))
    error ("parts.insert.heatset: MODE must be 'data' or 'solid'.");
  endif

  ## A thread NAME, then a length L, lead the Name/Value pairs
  args = varargin;
  NAME = '';
  L = [];
  if (! isempty (args) && ischar (args{1})
      && ! isempty (regexp (args{1}, '^M\d', 'once')))
    NAME = args{1};
    args(1) = [];
    if (isempty (regexp (NAME, '^M\d+(\.\d+)?$', 'once')))
      error ("parts.insert.heatset: invalid thread name '%s'.", NAME);
    endif
    if (! isempty (args) && ! ischar (args{1}))
      L = args{1};
      args(1) = [];
      if (! isnumeric (L) || ! isreal (L) || ! isscalar (L)
          || ! isfinite (L) || L <= 0)
        error ("parts.insert.heatset: L must be a positive length.");
      endif
    endif
  endif
  if (strcmp (MODE, 'solid') && (isempty (NAME) || isempty (L)))
    error ("parts.insert.heatset: a solid needs a thread NAME and a length L.");
  endif

  maker = '';
  D1 = [];
  detailed = false;
  if (mod (numel (args), 2) != 0)
    error ("parts.insert.heatset: Name/Value arguments must come in pairs.");
  endif
  for ii = 1:2:numel (args)
    name = args{ii};
    val = args{ii+1};
    if (! ischar (name) || ! isrow (name))
      error ("parts.insert.heatset: option names must be character vectors.");
    endif
    switch (lower (name))
      case 'maker'
        if (strcmp (MODE, 'solid'))
          error ("parts.insert.heatset: 'Maker' applies to 'data' only.");
        endif
        if (! ischar (val) || ! isrow (val))
          error ("parts.insert.heatset: 'Maker' must be a character vector.");
        endif
        maker = val;
      case 'diameter'
        if (! isnumeric (val) || ! isreal (val) || ! isscalar (val)
            || ! isfinite (val) || val <= 0)
          error (strcat ("parts.insert.heatset: 'Diameter' must be a", ...
                         " positive diameter."));
        endif
        D1 = val;
      case 'detailed'
        if (strcmp (MODE, 'data'))
          error ("parts.insert.heatset: 'Detailed' applies to 'solid' only.");
        endif
        if (! islogical (val) || ! isscalar (val))
          error ("parts.insert.heatset: 'Detailed' must be true or false.");
        endif
        detailed = val;
      otherwise
        error ("parts.insert.heatset: unknown option '%s'.", name);
    endswitch
  endfor

  C = catalogue (NAME, L, D1, maker);
  if (strcmp (MODE, 'data'))
    OUT = C;
    return;
  endif
  n = numel (unique (C.designation));
  if (n > 1)
    error (strcat ("parts.insert.heatset: %d %s x %g inserts in the", ...
                   " catalogue; choose one by 'Diameter'."), n, NAME, L);
  endif
  ## ruthex's dimensions where ruthex sells the insert
  k = find (strcmp (C.maker, 'ruthex'), 1);
  if (isempty (k))
    k = 1;
  endif
  OUT = shape (C(k,:), detailed);

endfunction

function C = catalogue (NAME, L, D1, maker)

  ## Built on the first call, kept for the session
  persistent E;
  if (isempty (E))
    E = entries ();
  endif

  keep = true (height (E), 1);
  if (! isempty (NAME))
    keep &= strcmp (E.thread, NAME);
  endif
  if (! isempty (L))
    keep &= abs (E.L - L) < 1e-9;
  endif
  if (! isempty (D1))
    keep &= abs (E.d1 - D1) < 1e-9;
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
    if (! isempty (D1))
      what = sprintf ("%s%g mm ", what, D1);
    endif
    how = '';
    if (! isempty (maker))
      how = sprintf (" by %s", maker);
    endif
    error ("parts.insert.heatset: no %sheat-set insert%s in the catalogue.", ...
           what, how);
  endif

endfunction

## Every insert of the catalogue, a row for each maker that sells it, sorted
## by thread, length and diameter, ruthex's first
function E = entries ()

  ## Designation, thread, L, d1, d2, d3, w, maker, article, document: R
  ## ruthex's data sheet, R6 and R10 its packets, K CNC Kitchen's guidelines
  A = {'M2 x 3', 'M2', 3, 3.6, NaN, 3.2, 1.3, 'K', '', 'K';
       'M2 x 4', 'M2', 4, 3.6, 3.1, 3.2, 1.3, 'R', 'GE-M2x04-001', 'R';
       'M2.5 x 4', 'M2.5', 4, 4.6, NaN, 4, 1.6, 'K', '', 'K';
       'M2.5 x 5.7', 'M2.5', 5.7, 4.6, 3.9, 4, 1.6, 'R', 'GE-M25x57-001', 'R';
       'M3 x 3', 'M3', 3, 4.6, NaN, 4, 1.6, 'K', '', 'K';
       'M3 x 4', 'M3', 4, 4.6, 3.9, 4, 1.6, 'R', 'GE-M3Sx40-002', 'R';
       'M3 x 5 x 4', 'M3', 4, 5, 4.25, 4.4, 1.3, 'R', 'GE-M3x5x4-001', 'R';
       'M3 x 5 x 4', 'M3', 4, 5, NaN, 4.4, 1.6, 'K', '', 'K';
       'M3 x 5.7', 'M3', 5.7, 4.6, 3.9, 4, 1.6, 'R', 'GE-M3x57-001', 'R';
       'M3 x 5.7', 'M3', 5.7, 4.6, NaN, 4, 1.6, 'K', '', 'K';
       'M4 x 4', 'M4', 4, 6.3, 5.5, 5.6, 2.1, 'R', 'GE-M4Sx04-1', 'R';
       'M4 x 4', 'M4', 4, 6.3, NaN, 5.7, 2.1, 'K', '', 'K';
       'M4 x 8.1', 'M4', 8.1, 6.3, 5.5, 5.6, 2.1, 'R', 'GE-M4x81-001', 'R';
       'M4 x 8.1', 'M4', 8.1, 6.3, NaN, 5.7, 2.1, 'K', '', 'K';
       'M5 x 5.8', 'M5', 5.8, 7.1, 6.3, 6.4, 2.6, 'R', 'GE-M5Sx58-001', 'R';
       'M5 x 5.8', 'M5', 5.8, 7.1, NaN, 6.5, 2.6, 'K', '', 'K';
       'M5 x 9.5', 'M5', 9.5, 7.1, 6.3, 6.4, 2.6, 'R', 'GE-M5x95-001', 'R';
       'M5 x 9.5', 'M5', 9.5, 7.1, NaN, 6.5, 2.6, 'K', '', 'K';
       'M6 x 6.8', 'M6', 6.8, 8.7, 7.9, 8, 3.3, 'R', 'GE-M6X68-001', 'R6';
       'M6 x 12.7', 'M6', 12.7, 8.7, 7.9, 8, 3.3, 'R', 'GE-M6x127-002', 'R';
       'M6 x 12.7', 'M6', 12.7, 8.7, NaN, 8.1, 3.3, 'K', '', 'K';
       'M8 x 12.7', 'M8', 12.7, 10.1, 9.5, 9.6, 4.5, 'R', 'GE-M8x127-001', 'R';
       'M8 x 12.7', 'M8', 12.7, 10.2, NaN, 9.7, 4.5, 'K', '', 'K';
       'M10 x 12.7', 'M10', 12.7, 12.6, 11.8, 12, 6, 'R', 'GE-M10X127-001', ...
       'R10';
       'M10 x 12.7', 'M10', 12.7, 12.6, NaN, 12, 6, 'K', '', 'K'};

  sheet = "ruthex, RX series product data sheet, 15.08.2022, p. 1";
  docs = struct ('R', sheet, ...
                 'R6', "ruthex, RX-M6Sx6.8 packet, ruthex.de", ...
                 'R10', "ruthex, RX-M10x12.7 packet, ruthex.de", ...
                 'K', "CNC Kitchen, Dimensions & Design Guidelines, 2025-06");
  source = cellfun (@(k) docs.(k), A(:,10), 'UniformOutput', false);
  maker = repmat ({'ruthex'}, rows (A), 1);
  maker(strcmp (A(:,8), 'K')) = {'CNC Kitchen'};
  d = cellfun (@(s) str2double (s(2:end)), A(:,2));
  V = cell2mat (A(:,3:7));
  E = table (A(:,1), A(:,2), d, V(:,1), V(:,2), V(:,3), V(:,4), V(:,1) + 1, ...
             V(:,5), maker, A(:,9), source);
  E.Properties.VariableNames = {'designation', 'thread', 'd', 'L', 'd1', ...
                                'd2', 'd3', 't', 'w', 'maker', 'article', ...
                                'source'};
  E.Properties.VariableUnits = {'', '', 'mm', 'mm', 'mm', 'mm', 'mm', 'mm', ...
                                'mm', '', '', ''};
  E.Properties.VariableDescriptions = {...
    ['thread by length, and by outside diameter', ...
     ' where two inserts share both'], ...
    'thread', ...
    'nominal diameter of the thread', ...
    'length, nominal', ...
    'outside diameter, over the knurl', ...
    'diameter of the pilot at the lower end', ...
    'diameter of the hole the maker recommends', ...
    'depth of a blind hole, smallest', ...
    'wall round the hole, smallest', ...
    'maker', ...
    "maker's article number", ...
    'document the insert was read from'};
  E.Properties.Description = 'Heat-set threaded inserts';
  E = sortrows (E, {'d', 'L', 'd1', 'maker'}, ...
                {'ascend', 'ascend', 'ascend', 'descend'});

endfunction

function S = shape (C, detailed)

  ## The section turned about z, its y the world z: the bands at d1, the
  ## grooves and the pilot; detailed, the pilot chamfered L/50 and the bore
  ## drilled for the thread, else the bore at the nominal diameter
  L = C.L;
  r1 = C.d1 / 2;
  d2 = C.d2;
  if (isnan (d2))
    d2 = C.d3 - 0.1;
  endif
  h = (C.d1 - d2) / 2;
  g1 = d2 / 2 - 0.375 * h;
  g2 = d2 / 2 - 0.625 * h;
  r2 = d2 / 2;
  z = -L * [0.29, 0.40, 0.75, 0.85];
  P = [r1, 0; r1, z(1); g1, z(1); g1, z(2); r1, z(2); r1, z(3); g2, z(3);
       g2, z(4); r2, z(4)];
  if (detailed)
    T = solid.threadspec (C.thread{1});
    rb = T.drill / 2;
    c = L / 50;
    P = [P; r2, c - L; r2 - c, -L];
  else
    rb = C.d / 2;
    P = [P; r2, -L];
  endif
  R = geom.Region ([rb, 0; P; rb, -L]);
  R.UCS = geom.UCS ([0, -1, 0], [0, 0, 0]);
  S = solid.revolve (R);
  if (detailed)
    S = thread (S, [0, 0, 0], C.thread{1}, L);
    ## The bands, every face inside them left out, knurled after the thread
    q = 0.999 * r1;
    e = 1e-3;
    band = @(S, za, zb) setdiff (faces (S, 'Type', 'cylinder', 'Within', ...
                                        [-r1, -r1, za, r1, r1, zb] ...
                                        + e * [-1, -1, -1, 1, 1, 1]), ...
                                 faces (S, 'Within', [-q, -q, -L, q, q, 0]));
    S = knurl (S, band (S, z(1), 0), 2 * h, 'Pattern', 'single', ...
               'Angle', -50);
    S = knurl (S, band (S, z(3), z(2)), 2 * h, 'Pattern', 'single', ...
               'Angle', 45);
  endif
  S.Name = ["Heat-set insert ", C.designation{1}];

endfunction

%!test  # the M4 x 8.1, a row for each maker
%! C = parts.insert.heatset ('data', 'M4', 8.1);
%! assert_equal (C.maker', {'ruthex', 'CNC Kitchen'});
%!test  # ruthex's values
%! C = parts.insert.heatset ('data', 'M4', 8.1, 'Maker', 'ruthex');
%! assert_equal ([C.d, C.L, C.d1, C.d2, C.d3, C.t, C.w], ...
%!               [4, 8.1, 6.3, 5.5, 5.6, 9.1, 2.1]);
%!test  # its article and source
%! C = parts.insert.heatset ('data', 'M4', 8.1, 'Maker', 'ruthex');
%! assert_equal ([C.article, C.source], ...
%!               {'GE-M4x81-001', ...
%!                ['ruthex, RX series product data sheet,', ...
%!                 ' 15.08.2022, p. 1']});
%!test  # CNC Kitchen's values: a larger hole, no pilot
%! C = parts.insert.heatset ('data', 'M4', 8.1, 'Maker', 'CNC Kitchen');
%! assert_equal ([C.d1, C.d2, C.d3, C.w], [6.3, NaN, 5.7, 2.1]);
%!test  # its source, without an article number
%! C = parts.insert.heatset ('data', 'M4', 8.1, 'Maker', 'CNC Kitchen');
%! assert_equal ([C.article, C.source], ...
%!               {'', ['CNC Kitchen, Dimensions & Design', ...
%!                     ' Guidelines, 2025-06']});
%!test  # where the makers' outside diameters differ
%! C = parts.insert.heatset ('data', 'M8', 12.7);
%! assert_equal (C.d1', [10.1, 10.2]);
%!test  # where their walls differ
%! C = parts.insert.heatset ('data', 'M3', 4, 'Diameter', 5);
%! assert_equal (C.w', [1.3, 1.6]);
%!test  # only CNC Kitchen sells the M2 x 3
%! C = parts.insert.heatset ('data', 'M2', 3);
%! assert_equal (C.maker, {'CNC Kitchen'});
%!test  # an insert read from its packet
%! C = parts.insert.heatset ('data', 'M10', 12.7, 'Maker', 'ruthex');
%! assert_equal ([C.article, C.source], ...
%!               {'GE-M10X127-001', ...
%!                'ruthex, RX-M10x12.7 packet, ruthex.de'});
%!test  # its pilot and hole depth
%! C = parts.insert.heatset ('data', 'M10', 12.7, 'Maker', 'ruthex');
%! assert_equal ([C.d2, C.t], [11.8, 13.7]);
%!test  # a thread alone gives every length
%! C = parts.insert.heatset ('data', 'M3');
%! assert_equal (unique (C.designation, 'stable')', ...
%!               {'M3 x 3', 'M3 x 4', 'M3 x 5 x 4', 'M3 x 5.7'});
%!test  # 'Maker' keeps its rows, in any case
%! C = parts.insert.heatset ('data', 'M6', 'Maker', 'cnc kitchen');
%! assert_equal (C.designation, {'M6 x 12.7'});
%!test  # the whole catalogue, a row for each insert and maker
%! C = parts.insert.heatset ('data');
%! assert_equal (height (C), 25);
%!test  # sorted by thread, then length
%! C = parts.insert.heatset ('data');
%! assert_equal (issorted ([C.d, C.L], 'rows'), true);
%!test  # each variable carries its unit and description
%! C = parts.insert.heatset ('data', 'M2', 3);
%! assert_equal (C.Properties.VariableUnits{7}, 'mm');
%! assert_equal (C.Properties.VariableDescriptions{7}, ...
%!               'diameter of the hole the maker recommends');
%!testif ; exist ('__occt__') == 3  # a plain insert: bands, grooves, pilot
%! S = parts.insert.heatset ('solid', 'M4', 8.1);
%! V = pi * 8.1 * ((3.15 ^ 2 - 4) * 0.64 + (2.6 ^ 2 - 4) * 0.11 ...
%!                 + (2.5 ^ 2 - 4) * 0.10 + (2.75 ^ 2 - 4) * 0.15);
%! assert_equal (volume (S), V, 1e-6);
%!testif ; exist ('__occt__') == 3  # its top face on the plane
%! S = parts.insert.heatset ('solid', 'M4', 8.1);
%! assert_equal (bbox (S), [-3.15, -3.15, -8.1, 3.15, 3.15, 0], 1e-6);
%!testif ; exist ('__occt__') == 3  # its name
%! S = parts.insert.heatset ('solid', 'M4', 8.1);
%! assert_equal (S.Name, {'Heat-set insert M4 x 8.1'});
%!testif ; exist ('__occt__') == 3  # 'Diameter' chooses the Voron insert
%! S = parts.insert.heatset ('solid', 'M3', 4, 'Diameter', 5);
%! assert_equal (S.Name, {'Heat-set insert M3 x 5 x 4'});
%!testif ; exist ('__occt__') == 3  # detailed: valid
%! S = parts.insert.heatset ('solid', 'M4', 8.1, 'Detailed', true);
%! assert_equal (isvalid (S), true);
%!testif ; exist ('__occt__') == 3  # detailed: knurled to d1, L long
%! S = parts.insert.heatset ('solid', 'M4', 8.1, 'Detailed', true);
%! assert_equal (bbox (S), [-3.15, -3.15, -8.1, 3.15, 3.15, 0], 1e-6);
%!testif ; exist ('__occt__') == 3  # detailed without a pilot diameter
%! S = parts.insert.heatset ('solid', 'M3', 3, 'Detailed', true);
%! assert_equal (isvalid (S), true);

%!error<parts.insert.heatset: MODE must be 'data' or 'solid'.> ...
%! parts.insert.heatset ('cad')
%!error<parts.insert.heatset: invalid thread name 'M4x'.> ...
%! parts.insert.heatset ('data', 'M4x')
%!error<parts.insert.heatset: L must be a positive length.> ...
%! parts.insert.heatset ('data', 'M4', -8.1)
%!error<parts.insert.heatset: a solid needs a thread NAME and a length L.> ...
%! parts.insert.heatset ('solid', 'M4')
%!error<parts.insert.heatset: Name/Value arguments must come in pairs.> ...
%! parts.insert.heatset ('data', 'M4', 'Maker')
%!error<parts.insert.heatset: option names must be character vectors.> ...
%! parts.insert.heatset ('data', 'M4', 8.1, 1, 2)
%!error<parts.insert.heatset: 'Maker' applies to 'data' only.> ...
%! parts.insert.heatset ('solid', 'M4', 8.1, 'Maker', 'ruthex')
%!error<parts.insert.heatset: 'Maker' must be a character vector.> ...
%! parts.insert.heatset ('data', 'M4', 'Maker', 3)
%!error<parts.insert.heatset: 'Diameter' must be a positive diameter.> ...
%! parts.insert.heatset ('data', 'M4', 'Diameter', -5)
%!error<parts.insert.heatset: 'Detailed' applies to 'solid' only.> ...
%! parts.insert.heatset ('data', 'M4', 'Detailed', true)
%!error<parts.insert.heatset: 'Detailed' must be true or false.> ...
%! parts.insert.heatset ('solid', 'M4', 8.1, 'Detailed', 'yes')
%!error<parts.insert.heatset: 'Detailed' must be true or false.> ...
%! parts.insert.heatset ('solid', 'M4', 8.1, 'Detailed', 1)
%!error<parts.insert.heatset: unknown option 'Type'.> ...
%! parts.insert.heatset ('data', 'M4', 'Type', 'A')
%!error<parts.insert.heatset: no M4 x 5 heat-set insert in the catalogue.> ...
%! parts.insert.heatset ('data', 'M4', 5)
%!error<parts.insert.heatset: no M6 x 6.8 heat-set insert by CNC Kitchen in the catalogue.> ...
%! parts.insert.heatset ('data', 'M6', 6.8, 'Maker', 'CNC Kitchen')
%!error<parts.insert.heatset: no M4 7 mm heat-set insert in the catalogue.> ...
%! parts.insert.heatset ('data', 'M4', 'Diameter', 7)
%!error<parts.insert.heatset: 2 M3 x 4 inserts in the catalogue; choose one by 'Diameter'.> ...
%! parts.insert.heatset ('solid', 'M3', 4)
