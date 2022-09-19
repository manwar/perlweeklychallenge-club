#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ max min product sum0 };
use SVG;
use Getopt::Long;

my $verbose = 0;
GetOptions( 'verbose' => \$verbose, );

my $config = <<'END';
333,129  39,189 140,156 292,134 393,52  160,166 362,122  13,193
341,104 320,113 109,177 203,152 343,100 225,110  23,186 282,102
284,98  205,133 297,114 292,126 339,112 327,79  253,136  61,169
128,176 346,72  316,103 124,162  65,181 159,137 212,116 337,86
215,136 153,137 390,104 100,180  76,188  77,181  69,195  92,186
275,96  250,147  34,174 213,134 186,129 189,154 361,82  363,89
END

# invert Y axis
my $w      = 400;
my $h      = 200;
my @config = map {
    [ map { int } split /,/, $_ ]
} grep { /\d/ } split /\s+/, $config;

say STDERR join "\n", map { join ',', $_->@* }
    sort { $a->[0] <=> $b->[0] } @config
    if $verbose;

# transform the Y axis because with SVG, 0 is in the
# upper left corner, but for traditional mathematics,
# it is in the lower left corner.
@config = map { $_->[1] = $h - $_->[1]; $_ } @config;

# a good next step might be to scale and orient the 
# graph to a hardcoded maybe 500x500 plot size

my $svg = SVG->new(
    height => $h,
    width  => $w,
);

# outline the box
add_line( $svg, [ 0, 0, 0, $h ],   'gray', 3 );
add_line( $svg, [ 0, 0, $w, 0 ],   'gray', 3 );
add_line( $svg, [ $w, $h, 0, $h ], 'gray', 3 );
add_line( $svg, [ $w, $h, $w, 0 ], 'gray', 3 );

# plot every entry
for my $entry (@config) {
    my @coords = $entry->@*;
    add_point( $svg, \@coords, 'red', 2 );
}

# lots of math
my $maxx = max map { $_->[0] } @config;
my $minx = min map { $_->[0] } @config;

my $N     = scalar @config;
my $sumx  = sum0 map { $_->[0] } @config;
my $sumx2 = sum0 map { $_->[0]**2 } @config;
my $sumy  = sum0 map { $_->[1] } @config;
my $sumxy = sum0 map { product $_->@* } @config;

my $m = sprintf '%.2f',
    ( $N * $sumxy - ( $sumx * $sumy ) ) / ( $N * $sumx2 - ( $sumx**2 ) );
my $bi = sprintf '%.2f', ( $sumy - ( $m * $sumx ) ) / $N;

my $miny = $m * $minx + $bi;
my $maxy = $m * $maxx + $bi;

say STDERR <<"END" if $verbose;
    N:     $N
    sumx:  $sumx
    sumx2: $sumx2
    sumy:  $sumy
    sumxy: $sumxy
    m:     $m
    b:     $bi
    maxx: $maxx
    maxy: $maxy
    minx: $minx
    miny: $miny
  y = ${m}x + $bi

END

# plot the 
add_line( $svg, [ $maxx, $maxy, $minx, $miny ], 'blue' );

my $output = $svg->xmlify;
say $output;
exit;

sub add_line ( $svg, $coords, $color = 'black', $width = 0.5 ) {
    $svg->line(
        x1    => $coords->[0],
        y1    => $coords->[1],
        x2    => $coords->[2],
        y2    => $coords->[3],
        style => {
            stroke         => $color,
            'stroke-width' => $width,
            fill           => $color,
        }
    );

}

sub add_point ( $svg, $coords, $color = 'black', $width = 0.5 ) {
    $svg->circle(
        cx    => $coords->[0],
        cy    => $coords->[1],
        r     => 0.7,
        style => {
            stroke         => $color,
            'stroke-width' => $width,
            fill           => $color,
        }
    );
}

