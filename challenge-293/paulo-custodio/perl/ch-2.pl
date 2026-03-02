#!/usr/bin/env perl

use Modern::Perl;

@ARGV==3 or die "usage: $0 'n n' 'n n' 'n n'\n";
my @points = @ARGV;
for (@points) {
    $_ = [split ' ', $_];
}

# make the syntax easier to reads
my ($x1,$y1) = @{ $points[0] };
my ($x2,$y2) = @{ $points[1] };
my ($x3,$y3) = @{ $points[2] };

# compute the area of the triangle
my $double_area = abs($x1*($y2-$y3)+$x2*($y3-$y1)+$x3*($y1-$y2));

# if area > 0, points are a boomerang
say $double_area > 0 ? "true" : "false";
