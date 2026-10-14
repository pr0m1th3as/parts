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
## @deftypefn  {parts} {@var{M} =} parts.material ()
## @deftypefnx {parts} {@var{M} =} parts.material (@var{NAME})
## @deftypefnx {parts} {@var{M} =} parts.material (@var{NAME}, @var{SIZE})
##
## Properties of the materials parts are made of.
##
## @code{@var{M} = parts.material ()} returns every material in the catalogue
## as a table, one row for each material and range of section sizes.  A
## metal's strength depends on the size of the section, the diameter of a bar
## or the thickness of a plate, so its source tabulates it by ranges, a row
## each; a polymer's does not, and it has one row.  @code{@var{M} =
## parts.material (@var{NAME})} returns the rows of the one named, such as
## @qcode{'C45'}, and @code{@var{M} = parts.material (@var{NAME},
## @var{SIZE})} the one row for a section @var{SIZE} millimetres across.
##
## The table has these variables, each with its unit and its description,
## which @code{summary (@var{M})} lists; stresses are in megapascals:
##
## @multitable @columnfractions 0.16 0.84
## @item @code{name} @tab name it is asked for by
## @item @code{class} @tab @qcode{'metal'}, @qcode{'machined polymer'} or
## @qcode{'printed polymer'}
## @item @code{section} @tab sizes of section the row holds for, over the
## first up to the second, two columns; 0 to @code{Inf} for a polymer
## @item @code{E} @tab Young's modulus
## @item @code{nu} @tab Poisson's ratio
## @item @code{Rp} @tab yield strength, 0.2 per cent proof stress or tensile
## stress at yield; @code{NaN} where the source gives none
## @item @code{Rm} @tab tensile strength; @code{NaN} where the source gives
## none
## @item @code{A} @tab elongation at break, per cent; @code{NaN} where the
## source gives none
## @item @code{rho} @tab density, kilograms per cubic metre
## @item @code{source} @tab where the values come from
## @end multitable
##
## Values are minimums where the source states minimums.  A printed polymer
## carries the weaker of the orientations its datasheet gives, since a printed
## part is loaded across its layers somewhere.
##
## @subheading The catalogue
##
## @multitable @columnfractions 0.20 0.80
## @headitem Name @tab Source
## @item @qcode{'C45'} @tab EN 10083-2:2006, Table 10, normalised (+N), by
## diameter up to 250 mm; modulus, Poisson's ratio and density from Ovako's
## C45 data sheet (2025).  The standard is withdrawn for EN ISO 683-1:2018.
## @item @qcode{'EN AW-6082-T6'} @tab EN 755-2, extruded round bar, T6, by
## diameter up to 250 mm, as tabulated by Bikar Metals; Poisson's ratio from
## EN 1999-1-1, 3.2.5.
## @item @qcode{'CuSn12'} @tab CuSn12-C, EN 1982, continuously cast (GC), as
## tabulated by the Deutsches Kupferinstitut (2005).
## @item @qcode{'PETG'} @tab Prusament PETG, technical datasheet 1.1 (2022),
## ISO 527-1 on printed specimens.
## @item @qcode{'PETG-CF'} @tab Prusament PETG Carbon Fiber, technical
## datasheet 1.0 (2022), ISO 527-1 on printed specimens.
## @item @qcode{'PA6-CF'} @tab Polymaker Fiberon PA6-CF20, technical datasheet
## 1.1 (2024): wet, after 48 hours in water at 60 degrees Celsius, 5.3 per cent
## moisture, loaded across the layers (Z).  It gives no yield strength.
## @item @qcode{'Ertalon 6 SA'} @tab Machined PA6 stock: conditioned at 23
## degrees Celsius and 50 per cent humidity, from an older undated product sheet
## that calls these values mostly derived from literature; density from the
## Mitsubishi Chemical Advanced Materials sheet of 2024.  It gives no tensile
## strength.
## @end multitable
##
## No datasheet of the polymers, nor of CuSn12, gives a Poisson's ratio:
## the nylons take 0.40, conditioned polyamide in Bayer's design guide
## @cite{Engineering Polymers: Part and Mold Design} (2000), Table 3-1; the
## PETGs 0.40, DuPont's rule for plastics of modulus 500 to 2500 MPa in
## @cite{General Design Principles}, Module I; CuSn12 0.35, as tabulated for
## centrifugally cast CuSn12 by Gruender et al., IOP Conf. Ser.: Mater. Sci.
## Eng. 1190 (2021) 012006, Table 3.
##
## @seealso{parts.bearing.deepgroove, parts.dowel}
## @end deftypefn

function M = material (NAME, SIZE)

  M = catalogue ();
  if (nargin == 0)
    return;
  endif

  if (! ischar (NAME) || ! isrow (NAME))
    error ("parts.material: NAME must be a character vector.");
  endif
  M = M(strcmp (M.name, NAME), :);
  if (height (M) == 0)
    error ("parts.material: no material '%s' in the catalogue.", NAME);
  endif

  if (nargin > 1)
    if (! isnumeric (SIZE) || ! isreal (SIZE) || ! isscalar (SIZE)
        || ! (SIZE > 0))
      error ("parts.material: SIZE must be a positive real scalar.");
    endif
    r = find (SIZE <= M.section(:,2), 1);
    if (isempty (r))
      error ("parts.material: %s is tabulated only up to %g mm.", NAME, ...
             M.section(end,2));
    endif
    M = M(r,:);
  endif

endfunction

## The catalogue as a table, built on the first call and kept for the session
function M = catalogue ()

  persistent C;
  if (! isempty (C))
    M = C;
    return;
  endif

  ## Name, class, E, nu, Rp, Rm, A, rho; sizes as [up to, Rp, Rm, A]
  T = {
    'C45', 'metal', 210000, 0.3, 340, 620, 14, 7800, ...
      [16, 340, 620, 14; 100, 305, 580, 16; 250, 275, 560, 16], ...
      "EN 10083-2:2006 Table 10 (+N); E, nu, rho: Ovako C45 (2025)";
    'EN AW-6082-T6', 'metal', 70000, 0.3, 250, 295, 8, 2700, ...
      [20, 250, 295, 8; 150, 260, 310, 8; 200, 240, 280, 6; ...
       250, 200, 270, 6], ...
      "EN 755-2 round bar T6 (Bikar Metals); nu: EN 1999-1-1 3.2.5";
    'CuSn12', 'metal', 97000, 0.35, 150, 300, 6, 8720, ...
      [Inf, 150, 300, 6], ...
      ["CuSn12-C GC, EN 1982 (Deutsches Kupferinstitut 2005);", ...
       " nu: Gruender et al. 2021"];
    'PETG', 'printed polymer', 1500, 0.40, 47, [], [], 1270, [], ...
      "Prusament PETG TDS 1.1 (2022), ISO 527-1, weaker orientation";
    'PETG-CF', 'printed polymer', 1700, 0.40, 47, [], [], 1270, [], ...
      ["Prusament PETG Carbon Fiber TDS 1.0 (2022), ISO 527-1,", ...
       " weaker orientation"];
    'PA6-CF', 'printed polymer', 1056.1, 0.40, [], 25.5, 6.7, 1170, [], ...
      "Polymaker Fiberon PA6-CF20 TDS 1.1 (2024), wet, Z";
    'Ertalon 6 SA', 'machined polymer', 1425, 0.40, 45, [], 100, 1140, [], ...
      "Ertalon 6 SA, conditioned, older product sheet; rho: MCAM (2024)"
  };
  ## One row for each range of sections, a polymer's from 0 to Inf
  P = T(:,3:8);
  P(cellfun (@isempty, P)) = {NaN};
  P = cell2mat (P);
  S = T(:,9);
  none = cellfun (@isempty, S);
  S(none) = num2cell ([Inf(sum (none), 1), P(none,3:5)], 2);
  n = cellfun (@rows, S);
  k = repelem ((1:rows (T))', n);
  S = cell2mat (S);
  lo = [0; S(1:end-1,1)];
  lo(cumsum (n) - n + 1) = 0;
  C = table (T(k,1), T(k,2), [lo, S(:,1)], P(k,1), P(k,2), S(:,2), S(:,3), ...
             S(:,4), P(k,6), T(k,10));
  C.Properties.VariableNames = {'name', 'class', 'section', 'E', 'nu', 'Rp', ...
                                'Rm', 'A', 'rho', 'source'};
  C.Properties.VariableUnits = {'', '', 'mm', 'MPa', '', 'MPa', 'MPa', '%', ...
                                'kg/m^3', ''};
  C.Properties.VariableDescriptions = {...
    'name it is asked for by', ...
    'metal, machined polymer or printed polymer', ...
    ['sizes of section the row holds for,', ...
     ' over the first up to the second'], ...
    "Young's modulus", ...
    "Poisson's ratio", ...
    ['yield strength, 0.2 per cent proof stress or', ...
     ' tensile stress at yield'], ...
    'tensile strength', ...
    'elongation at break', ...
    'density', ...
    'where the values come from'};
  C.Properties.Description = 'Properties of the materials parts are made of';
  M = C;

endfunction

%!test  # the whole catalogue
%! M = parts.material ();
%! assert_equal (unique (M.name, 'stable')', ...
%!               {'C45', 'EN AW-6082-T6', 'CuSn12', 'PETG', ...
%!                'PETG-CF', 'PA6-CF', 'Ertalon 6 SA'});
%!test  # one row for each range of sections
%! M = parts.material ();
%! assert_equal (height (M), 12);
%!test  # every material has a modulus, a Poisson's ratio and a density
%! M = parts.material ();
%! assert_equal (all (M.E > 0 & M.nu > 0 & M.rho > 0), true);
%!test  # and a strength, yield or tensile
%! M = parts.material ();
%! assert_equal (all (! isnan (M.Rp) | ! isnan (M.Rm)), true);
%!test  # a metal's ranges, over one size up to the next
%! M = parts.material ('C45');
%! assert_equal (M.section, [0, 16; 16, 100; 100, 250]);
%!test  # C45 normalised, as EN 10083-2 Table 10 gives it by diameter
%! M = parts.material ('C45', 17);
%! assert_equal ([M.Rp, M.Rm, M.A], [305, 580, 16]);
%!test  # a size on a boundary takes the smaller range
%! M = parts.material ('C45', 16);
%! assert_equal ([M.Rp, M.Rm], [340, 620]);
%!test  # 6082-T6 round bar by diameter
%! M = parts.material ('EN AW-6082-T6', 160);
%! assert_equal ([M.Rp, M.Rm], [240, 280]);
%!test  # a polymer has one row, whatever the size
%! M = parts.material ('PETG');
%! assert_equal ([height(M), M.section], [1, 0, Inf]);
%!test  # the same row at any size
%! assert_equal (isequaln (parts.material ('PETG', 50), ...
%!                        parts.material ('PETG', 5)), true);
%!test  # the printed nylon is wet and loaded across its layers
%! M = parts.material ('PA6-CF');
%! assert_equal ([M.E, M.Rp, M.Rm, M.A], [1056.1, NaN, 25.5, 6.7]);
%!test  # each variable carries its unit and description
%! M = parts.material ('C45', 17);
%! assert_equal (M.Properties.VariableUnits([4, 9]), {'MPa', 'kg/m^3'});
%! assert_equal (M.Properties.VariableDescriptions{5}, "Poisson's ratio");

%!error<parts.material: NAME must be a character vector.> parts.material (1)
%!error<parts.material: no material 'steel' in the catalogue.> ...
%! parts.material ('steel')
%!error<parts.material: SIZE must be a positive real scalar.> ...
%! parts.material ('C45', 0)
%!error<parts.material: C45 is tabulated only up to 250 mm.> ...
%! parts.material ('C45', 300)
