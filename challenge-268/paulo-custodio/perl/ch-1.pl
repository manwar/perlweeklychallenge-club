#!/usr/bin/env perl

# Challenge 268
#
# Input: @x = (3, 7, 5)
#        @y = (9, 5, 7)
# Output: 2
#
# The magic number is 2.
# @x = (3, 7, 5)
#    +  2  2  2
# @y = (5, 9, 7)
#
# Example 2
#
# Input: @x = (1, 2, 1)
#        @y = (5, 4, 4)
# Output: 3
#
# The magic number is 3.
# @x = (1, 2, 1)
#    +  3  3  3
# @y = (5, 4, 4)
#
# Example 3
#
# Input: @x = (2)
#        @y = (5)
# Output: 3

use Modern::Perl;

my($x, $y) = split /,/, "@ARGV";
my @x = split ' ', $x;
my @y = split ' ', $y;

say magic_number(\@x, \@y);

sub magic_number {
    my($x, $y) = @_;

    my @x = sort {$a <=> $b} @$x;
    my @y = sort {$a <=> $b} @$y;

    return -1 if scalar(@x) != scalar(@y);

    my $delta = $y[0]-$x[0];
    for (0 .. $#x) {
        return -1 if $y[$_]-$x[$_] != $delta;
    }
    return $delta;
}
