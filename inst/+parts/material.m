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
## as a struct array.  @code{@var{M} = parts.material (@var{NAME})} returns the
## one named, such as @qcode{'C45'}.  For a metal, whose strength depends on
## the size of the section, @code{@var{M} = parts.material (@var{NAME},
## @var{SIZE})} returns the strength for a section @var{SIZE} millimetres
## across, the diameter of a bar or the thickness of a plate; without
## @var{SIZE} it returns the smallest section's.
##
## Each material is a struct with these fields, stresses in megapascals:
##
## @multitable @columnfractions 0.16 0.84
## @item @code{name} @tab the name it is asked for by
## @item @code{class} @tab @qcode{'metal'}, @qcode{'machined polymer'} or
## @qcode{'printed polymer'}
## @item @code{E} @tab Young's modulus
## @item @code{nu} @tab Poisson's ratio
## @item @code{Rp} @tab yield strength, 0.2 per cent proof stress or tensile
## stress at yield; empty where the source gives none
## @item @code{Rm} @tab tensile strength; empty where the source gives none
## @item @code{A} @tab elongation at break, per cent; empty where the source
## gives none
## @item @code{rho} @tab density, kilograms per cubic metre
## @item @code{sizes} @tab for a metal, the rows @code{[@var{up to}, Rp, Rm,
## A]} the strength is tabulated in; empty for a polymer
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
  M = cell2struct (T, {'name', 'class', 'E', 'nu', 'Rp', 'Rm', 'A', 'rho', ...
                       'sizes', 'source'}, 2);
  if (nargin == 0)
    return;
  endif

  if (! ischar (NAME) || ! isrow (NAME))
    error ("parts.material: NAME must be a character vector.");
  endif
  k = find (strcmp (NAME, {M.name}));
  if (isempty (k))
    error ("parts.material: no material '%s' in the catalogue.", NAME);
  endif
  M = M(k);

  if (nargin > 1)
    if (! isnumeric (SIZE) || ! isreal (SIZE) || ! isscalar (SIZE)
        || ! (SIZE > 0))
      error ("parts.material: SIZE must be a positive real scalar.");
    endif
    if (! isempty (M.sizes))
      r = find (SIZE <= M.sizes(:,1), 1);
      if (isempty (r))
        error ("parts.material: %s is tabulated only up to %g mm.", ...
               M.name, M.sizes(end,1));
      endif
      M.Rp = M.sizes(r,2);
      M.Rm = M.sizes(r,3);
      M.A = M.sizes(r,4);
    endif
  endif

endfunction

%!test  # the whole catalogue
%! M = parts.material ();
%! assert_equal ({M.name}, {'C45', 'EN AW-6082-T6', 'CuSn12', 'PETG', ...
%!                          'PETG-CF', 'PA6-CF', 'Ertalon 6 SA'});
%!test  # every material has a modulus, a Poisson's ratio and a density
%! M = parts.material ();
%! assert_equal (all ([M.E] > 0 & [M.nu] > 0 & [M.rho] > 0), true);
%!test  # and a strength, yield or tensile
%! M = parts.material ();
%! ok = arrayfun (@(m) ! isempty (m.Rp) || ! isempty (m.Rm), M);
%! assert_equal (all (ok), true);
%!test  # C45 normalised, as EN 10083-2 Table 10 gives it by diameter
%! M = parts.material ('C45', 17);
%! assert_equal ([M.Rp, M.Rm, M.A], [305, 580, 16]);
%!test  # the smallest section without a size
%! M = parts.material ('C45');
%! assert_equal ([M.Rp, M.Rm], [340, 620]);
%!test  # 6082-T6 round bar by diameter
%! M = parts.material ('EN AW-6082-T6', 160);
%! assert_equal ([M.Rp, M.Rm], [240, 280]);
%!test  # a polymer's strength does not depend on size
%! M1 = parts.material ('PETG', 5);
%! M2 = parts.material ('PETG', 50);
%! assert_equal (M1.Rp, M2.Rp);
%!test  # the printed nylon is wet and loaded across its layers
%! M = parts.material ('PA6-CF');
%! assert_equal ([M.E, M.Rm, M.A], [1056.1, 25.5, 6.7]);
%! assert_equal (M.Rp, []);

%!error<parts.material: NAME must be a character vector.> parts.material (1)
%!error<parts.material: no material 'steel' in the catalogue.> ...
%! parts.material ('steel')
%!error<parts.material: SIZE must be a positive real scalar.> ...
%! parts.material ('C45', 0)
%!error<parts.material: C45 is tabulated only up to 250 mm.> ...
%! parts.material ('C45', 300)
