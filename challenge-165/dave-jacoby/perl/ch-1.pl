#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use SVG;

my $config = <<'END';

53,10
53,10,23,30
23, 30 

END

my @config = grep { /\d/ } split /\n/, $config;
my $svg    = SVG->new(
    height => 100,
    width  => 100,
);

for my $entry (@config) {
    my @coords = map { int $_ } split /,/, $entry;
    add_line( $svg, \@coords )         if scalar @coords == 4;
    add_point( $svg, \@coords, 'red' ) if scalar @coords == 2;
}

my $output = $svg->xmlify;
say $output;
exit;

sub add_line ( $svg, $coords, $color = 'black' ) {
    $svg->line(
        x1    => $coords->[0],
        y1    => $coords->[1],
        x2    => $coords->[2],
        y2    => $coords->[3],
        style => {
            stroke         => $color,
            'stroke-width' => 0.5,
            fill           => $color,
        }
    );

}

sub add_point ( $svg, $coords, $color = 'black' ) {
    $svg->circle(
        cx    => $coords->[0],
        cy    => $coords->[1],
        r     => 0.5,
        style => {
            stroke         => $color,
            'stroke-width' => 0.5,
            fill           => $color,
        }
    );
}

