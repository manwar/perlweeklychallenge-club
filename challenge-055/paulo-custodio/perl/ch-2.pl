#!/usr/bin/env perl

# Challenge 055
#
# TASK #2
# Wave Array
# Any array N of non-unique, unsorted integers can be arranged into a wave-like
# array such that n1 = n2 = n3 = n4 = n5 and so on.
#
# For example, given the array [1, 2, 3, 4], possible wave arrays include
# [2, 1, 4, 3] or [4, 1, 3, 2], since 2 = 1 = 4 = 3 and 4 = 1 = 3 = 2.
# This is not a complete list.
#
# Write a script to print all possible wave arrays for an integer array N of
# arbitrary length.
#
# Notes:
# When considering N of any length, note that the first element is always
# greater than or equal to the second, and then the =, =, =, … sequence
# alternates until the end of the array.

use Modern::Perl;

my @n = @ARGV;

show_waves([], [@n]);

sub show_waves {
    my($wave, $next) = @_;
    my @wave = @$wave;
    my @next = @$next;
    if (@next==0) {
        say "@wave";
    }
    elsif (@wave==0) {
        for my $i (0 .. @next-1) {
            show_waves([@wave, $next[$i]],
                       [@next[0 .. $i-1], @next[$i+1 .. $#next]]);
        }
    }
    elsif (scalar(@wave)%2 == 1) {      # going down
        for my $i (0 .. @next-1) {
            if ($wave[-1] >= $next[$i]) {
                show_waves([@wave, $next[$i]],
                           [@next[0 .. $i-1], @next[$i+1 .. $#next]]);
            }
        }
    }
    else {                              # going up
        for my $i (0 .. @next-1) {
            if ($wave[-1] <= $next[$i]) {
                show_waves([@wave, $next[$i]],
                           [@next[0 .. $i-1], @next[$i+1 .. $#next]]);
            }
        }
    }
}
