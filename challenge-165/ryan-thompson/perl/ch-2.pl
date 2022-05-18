#!/usr/bin/env perl
#
# ch-2.pl - Line of best fit
#
# 2022 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';
use List::Util qw< sum max >;
use Getopt::Long;

# Syntactic sugar. sum map { $_->[0] } @_
#              --> sum map      X,     @_
sub X() { $_->[0] }
sub Y() { $_->[1] }

my @points = map { [ split /[\s,]+/ ] } <>;
my $width  = max map X, @points;
my ($m,$b) = best_fit(@points);

# Standard equation for a line gives us this:
my $line = [ 0, $b, $width, $m*$width + $b ];

say join ',', @$_ for @points;
printf "%d,%.4f,%d,%.4f\n", @$line;

# Find the line of best fit using least squares method
sub best_fit {
    my $mean_x = (sum map X, @_)  / @_;
    my $mean_y = (sum map Y, @_)  / @_;
    my $sum_sq =  sum map { X * X } @_;
    my $sum_xy =  sum map { X * Y } @_;

    my $m = ($sum_xy / @_ - $mean_x * $mean_y) / 
            ($sum_sq / @_ - $mean_x * $mean_x);
    my $b =  $mean_y - $m * $mean_x;

    ($m, $b, $mean_x, $mean_y);
}
