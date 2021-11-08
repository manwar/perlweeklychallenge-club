#!/usr/bin/perl
use 5.020;
use warnings;

sub circle {
    my ($radius, $c) = @_;
    my $widthScale = 6;
    my $width = 3 + int(0.5 + $widthScale * $radius);
    my $radius2 = $radius ** 2;

    for my $y (-$radius .. $radius) {
        my $x = (0.5 + ($widthScale * int($radius2 - $y ** 2)) ** 0.5);
        if ($x < 2) {
            $x = 2;
        }
        say ' ' x (($width / 2) - $x), $c, ' ' x (2 * $x - 4), $c;
    }
}

sub cross {
    my ($height, $c) = @_;
    my $widthScale = 6;
    my $width = 3 + int(0.5 + $widthScale * $height);
    my $height2 = $height ** 2;

    for my $y (0 .. $height) {
        if ($y == int ($height * 2 / 3)) {
            my $x = (0.5 + ($widthScale * int($height2 - $y ** 2)) ** 0.5);
            say ' ' x ($width / 3 - 2), $c x int(3 * $x / 2);
        } else {
            say ' ' x ($width / 2), $c;
        }
    }
}

circle(5, '*');
cross(5, '*');

