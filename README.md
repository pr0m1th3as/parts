# parts

A catalogue of standard (off-the-shelf) machine parts for GNU Octave, in the
sizes their makers' catalogues list: deep groove ball bearings; socket head
cap, low head cap, countersunk, raised countersunk, button, pan, cheese,
hexagon head, shoulder and set screws; hexagon and flange nuts; plain
washers; retaining rings; heat-set threaded inserts; dowel pins; and
parallel keys. The properties of engineering materials come with them.

Each part comes two ways from one call. With `'data'` it is a struct of the
catalogue's dimensions and ratings, for a calculation; with `'solid'` it is a
`solid.Shape` of the part, placed by a fixed convention, for an assembly, an
interference check or a STEP or 3MF file, plain by default or with
`'Detailed', true` its finer form, threads included. Every value is read from
a maker's published catalogue or the part's standard, and each function's help
names the document, edition and pages it comes from.

```
B = parts.bearing.deepgroove ('data', '6205');        % the catalogue entry
S = parts.bearing.deepgroove ('solid', '6205');       % its solid
C = parts.screw.cap ('data', 'M5', 20);               % the M5 x 20 articles
S = parts.screw.cap ('solid', 'M5', 20, 'Detailed', true);  % its thread too
I = parts.insert.heatset ('data', 'M4', 8.1);         % the hole it needs
```

The solids come from the [`drafting`](https://github.com/pr0m1th3as/drafting)
package, which this one depends on.

## Requirements

GNU Octave 11.1 or later and `drafting` 0.2.2 or later.
