#!/usr/bin/env raku

use SVG;

my $input := ((53, 10), (53, 10, 23, 30), (23, 30));
my @points;
my @lines;

for $input
{ 
    if .elems == 2
    {
        @points.push: .item with circle => [ :cx(.[0]), :cy(.[1]), :r(3), :fill<red> ]
    }

    else
    {
        @lines.push: .item with line => [ :x1(.[0]), :y1(.[1]), :x2(.[2]), :y2(.[3]), :stroke<blue> ]
    }
}

print SVG.serialize(svg => [ :width(100), :height(100), |@points, |@lines ]);
