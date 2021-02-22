#!/usr/bin/perl

# Challenge 026
#
# Task #2
# Create a script that prints mean angles of the given list of angles in degrees.
# Please read wiki page that explains the formula in details with an example.

use strict;
use warnings;
use 5.030;
use Math::Trig;

say mean(@ARGV);

sub mean {
    my(@a) = @_;

    # convert to radians
    map {$_ = deg2rad($_)} @a;

    # compute sum of sin and cos
    my $x = sum( map {cos($_)} @a );
    my $y = sum( map {sin($_)} @a );

    # compute mean
    my $a = atan2($y, $x);

    # convert back to degrees
    $a = rad2deg($a);
    return $a;
}

sub sum {
    my($sum, @a) = @_;
    $sum += $_ for @a;
    return $sum;
}
