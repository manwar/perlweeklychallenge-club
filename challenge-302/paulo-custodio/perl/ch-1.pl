#!/usr/bin/env perl

# Challenge 302
#
# Task 1: Ones and Zeroes
# Submitted by: Mohammad Sajid Anwar
# You are given an array of binary strings, @str, and two integers, $x and $y.
#
# Write a script to return the size of the largest subset of @str such that there are at most $x 0’s and $y 1’s in the subset.
#
# A set m is a subset of n if all elements of m are also elements of n.
# Example 1
# Input: @str = ("10", "0001", "111001", "1", "0")
#        $x = 5
#        $y = 3
# Output: 4
#
# The largest subset with at most five 0's and three 1's:
# ("10", "0001", "1", "0")
# Example 2
# Input: @str = ("10", "1", "0")
#        $x = 1
#        $y = 1
# Output: 2
#
# The largest subset with at most one 0's and one 1's:
# ("1", "0")

use Modern::Perl;

my @str = split ' ', <>;
my($x, $y) = split ' ', <>;
say find_largest_subset($x, $y, @str);

sub find_largest_subset {
    my($x, $y, @str) = @_;
    my $largest_size = 0;

    my $find_largest_subset;
    $find_largest_subset = sub {
        my($prefix, $pending) = @_;

        # check if prefix is a valid subset
        my $prefix_str = join '', @$prefix;
        my $num_zeros = $prefix_str =~ tr/0/0/;
        my $num_ones  = $prefix_str =~ tr/1/1/;
        if ($num_zeros <= $x && $num_ones <= $y) {
            my $subset_size = scalar(@$prefix);
            $largest_size = $subset_size if $largest_size < $subset_size;
        }

        if (@$pending == 0) {
            return;
        }
        else {
            for my $i (0 .. $#$pending) {
                my @new_prefix = (@$prefix, $pending->[$i]);
                my @new_pending = @$pending;
                splice(@new_pending, $i, 1);
                $find_largest_subset->(\@new_prefix, \@new_pending);
            }
        }
    };
    $find_largest_subset->([], \@str);
    return $largest_size;
}
