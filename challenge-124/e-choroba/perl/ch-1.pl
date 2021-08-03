#!/usr/bin/perl
use warnings;
use strict;

use GD;

my @SHADES = ("\N{LIGHT SHADE}", "\N{MEDIUM SHADE}", "\N{DARK SHADE}");

my $image = 'GD::Image'->new(20, 30);
my $white = $image->colorAllocate(255, 255, 255);
my $black = $image->colorAllocate(0, 0, 0);
$image->stringFT($black,
                 'arial',
                 20, 0, 0, 21, "\N{FEMALE SIGN}",
                 {charmap => 'Unicode'});
my @grid;
my $max = 0;
for my $y (0 .. 27) {
    for my $x (0 .. 20) {
        $grid[$x][$y] = $image->getPixel($x, $y);
        $max = $grid[$x][$y] if $grid[$x][$y] > $max;
    }
}
binmode *STDOUT, ':encoding(UTF-8)';
for my $y (0 .. 27) {
    for my $x(0 .. 20) {
        my $pixel = $grid[$x][$y];
        print $pixel
            ? $SHADES[3 * ($pixel - 1) / $max]
            : ' ';
    }
    print "\n";
}
