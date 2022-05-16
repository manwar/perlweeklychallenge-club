#!/usr/bin/env raku

use SVG;

my $input = <333,129  39,189 140,156 292,134 393,52  160,166 362,122  13,193
             341,104 320,113 109,177 203,152 343,100 225,110  23,186 282,102
             284,98  205,133 297,114 292,126 339,112 327,79  253,136  61,169
             128,176 346,72  316,103 124,162  65,181 159,137 212,116 337,86
             215,136 153,137 390,104 100,180  76,188  77,181  69,195  92,186
             275,96  250,147  34,174 213,134 186,129 189,154 361,82  363,89>;

my (@x, @y, @points);

for $input.split(/\s+/)
{
    my (\x, \y) = .split(',');
    @x.push: +x;
    @y.push: +y;
    @points.push: .item with circle => [ :cx(x), :cy(y), :r(3), :fill<red> ];
}

my \sum_x    = [+] @x;
my \sum_y    = [+] @y;
my \sum_xy   = [+] @x >>*<< @y;
my \sum_x_sq = [+] @x >>**>> 2;

my \n    = $input.elems;
my \rise = n * sum_xy - sum_x * sum_y;
my \run  = n * sum_x_sq - sum_x**2;
my \b    = (sum_y - rise/run * sum_x) / n;
my $line = line => [ :x1(0), :y1(b), :x2(run), :y2(b+rise), :stroke<blue> ];

print SVG.serialize(svg => [ :width(400), :height(400), |@points, $line ]);
