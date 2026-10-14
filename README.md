# parts

A catalogue of standard (off-the-shelf) machine parts for GNU Octave, in the
sizes their makers' catalogues list. It offers:

- **Bearings:** `parts.bearing.deepgroove`, deep groove ball bearings of the
  series 618, 619, 60 and 62.
- **Screws:** `parts.screw.cap`, `lowcap`, `countersunk`, `raisedcountersunk`,
  `button`, `pan`, `cheese`, `hex`, `shoulder` and `set`, one function per
  head, in every drive the head comes with.
- **Nuts:** `parts.nut.hex`, regular, thin and locking hexagon nuts, and
  `parts.nut.flange`, flange nuts, plain or locking.
- **Washers:** `parts.washer.plain`, plain washers of the normal, small and
  large series.
- **Retaining rings:** `parts.ring.retaining`, for shafts and bores, with the
  groove each needs.
- **Heat-set inserts:** `parts.insert.heatset`, threaded inserts for
  3D-printed parts, M2 to M10.
- **Pins and keys:** `parts.dowel`, hardened parallel pins, and `parts.key`,
  parallel keys with their keyways.
- **Materials:** `parts.material`, the properties of seven engineering
  materials.

The solids come from the [`drafting`](https://github.com/pr0m1th3as/drafting)
package and the tables from the
[`datatypes`](https://github.com/pr0m1th3as/datatypes) package, which this one
depends on.

## Install

To install the latest release, you need Octave (>=11.1.0), the
[`drafting`](https://github.com/pr0m1th3as/drafting) package (>=0.2.2) and the
[`datatypes`](https://github.com/pr0m1th3as/datatypes) package (>=1.5.0)
installed on your system. Install the **parts** package by typing:

  `pkg install parts`

You can automatically download and install the latest development version of
the **parts** package found [here](https://github.com/pr0m1th3as/parts/archive/refs/heads/main.zip)
by typing:

  `pkg install "https://github.com/pr0m1th3as/parts/archive/refs/heads/main.zip"`

After installation, type:
- `pkg load parts` to load the **parts** package.
- `news parts` to review all the user visible changes since last version.
- `pkg test parts` to run its test suite and check that it works on your system.

## Usage

Each part comes two ways from one call. With `'data'` it is a table of the
catalogue's dimensions and ratings, one row per article or size, for a
calculation, each variable with its unit and description, which `summary`
lists; with `'solid'` it is a `solid.Shape` of the part, placed by a
fixed convention, for an assembly, an interference check or a STEP or 3MF
file, plain by default or with `'Detailed', true` its finer form, threads
included. Every value is read from a maker's published catalogue or the
part's standard, and each function's help names the document, edition and
pages it comes from.

The help of every function is also online, in the
[package documentation](https://pr0m1th3as.github.io/parts/).

The catalogue entry of a 6205 bearing:

```
>> bearing = parts.bearing.deepgroove ('data', '6205')
bearing =
  1x13 table

    designation    d     D     B     r     da      Da     ra      C       C0     nlim     mass           source
    ___________    __    __    __    _    ____    ____    __    _____    ____    _____    ____    _____________________

    {'6205'   }    25    52    15    1    30.6    46.4     1    14800    7800    18000    0.13    {'SKF 17000, p. 272'}
```

Its solid, the two rings and the balls:

```
>> S = parts.bearing.deepgroove ('solid', '6205')
S =

  solid.Shape: 10 solids, 29 faces, 62 edges
```

Every article sold as an M5 x 20 socket head cap screw, by class and finish:

```
>> screws = parts.screw.cap ('data', 'M5', 20);
>> screws(:, {'article', 'class', 'finish'})
ans =
  10x3 table

       article          class                 finish
    _____________    ___________    __________________________

    {'04762.800'}    {'8.8'    }    {'plain'                 }
    {'04762.810'}    {'8.8'    }    {'zinc plated'           }
    {'04762.317'}    {'8.8'    }    {'zinc plated 8 TLP'     }
    {'04762.428'}    {'8.8'    }    {'zinc plated 8 TLP + SL'}
    {'04762.100'}    {'10.9'   }    {'plain'                 }
    {'04762.110'}    {'10.9'   }    {'zinc plated, baked'    }
    {'04762.200'}    {'12.9'   }    {'plain'                 }
    {'04762.920'}    {'A2-70'  }    {'plain'                 }
    {'04762.940'}    {'A4-70'  }    {'plain'                 }
    {'04762.941'}    {'BUMAX88'}    {'plain'                 }
```

The screw's solid, with its socket and thread:

```
>> S = parts.screw.cap ('solid', 'M5', 20, 'Detailed', true)
S =

  solid.Shape: 1 solid, 43 faces, 111 edges, named
```

A heat-set insert from each maker that sells it, with the hole it needs:

```
>> insert = parts.insert.heatset ('data', 'M4', 8.1)
insert =
  2x12 table

    designation     thread    d     L     d1     d2     d3      t      w          maker             article                                   source
    ____________    ______    _    ___    ___    ___    ___    ___    ___    _______________    ________________    __________________________________________________________

    {'M4 x 8.1'}    {'M4'}    4    8.1    6.3    5.5    5.6    9.1    2.1    {'ruthex'     }    {'GE-M4x81-001'}    {'ruthex, RX series product data sheet, 15.08.2022, p. 1'}
    {'M4 x 8.1'}    {'M4'}    4    8.1    6.3    NaN    5.7    9.1    2.1    {'CNC Kitchen'}    {''            }    {'CNC Kitchen, Dimensions & Design Guidelines, 2025-06'  }
```
