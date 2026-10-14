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
package, which this one depends on.

## Install

To install the latest release, you need Octave (>=11.1.0) and the
[`drafting`](https://github.com/pr0m1th3as/drafting) package (>=0.2.2)
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

Each part comes two ways from one call. With `'data'` it is a struct array of
the catalogue's dimensions and ratings, one entry per article or size, for a
calculation; with `'solid'` it is a `solid.Shape` of the part, placed by a
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

  scalar structure containing the fields:

    designation = 6205
    d = 25
    D = 52
    B = 15
    r = 1
    da = 30.600
    Da = 46.400
    ra = 1
    C = 14800
    C0 = 7800
    nlim = 18000
    mass = 0.1300
    source = SKF 17000, p. 272
```

Its solid, the two rings and the balls:

```
>> S = parts.bearing.deepgroove ('solid', '6205')
S =

  solid.Shape: 10 solids, 29 faces, 62 edges
```

Every article sold as an M5 x 20 socket head cap screw:

```
>> screws = parts.screw.cap ('data', 'M5', 20)
screws =

  1x10 struct array containing the fields:

    designation
    standard
    d
    P
    l
    b
    dk
    k
    drive
    tool
    class
    finish
    maker
    article
    source
```

The screw's solid, with its socket and thread:

```
>> S = parts.screw.cap ('solid', 'M5', 20, 'Detailed', true)
S =

  solid.Shape: 1 solid, 43 faces, 111 edges, named
```

A heat-set insert's sizes and the hole it needs:

```
>> insert = parts.insert.heatset ('data', 'M4', 8.1)
insert =

  scalar structure containing the fields:

    designation = M4 x 8.1
    thread = M4
    d = 4
    L = 8.1000
    d1 = 6.3000
    d2 = 5.5000
    d3 = 5.6000
    t = 9.1000
    w = 2.1000
    makers =
    {
      [1,1] = ruthex
      [1,2] = CNC Kitchen
    }

    source =
    {
      [1,1] = ruthex, RX series product data sheet, 15.08.2022, p. 1
      [1,2] = CNC Kitchen, Dimensions & Design Guidelines, 2025-06
    }
```
