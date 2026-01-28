#!/usr/bin/env perl

# Challenge 303
#
# Task 1: 3-digits Even
# Submitted by: Mohammad Sajid Anwar
# You are given a list (3 or more) of positive integers, @ints.
#
# Write a script to return all even 3-digits integers that can be formed using the integers in the given list.
#
# Example 1
# Input: @ints = (2, 1, 3, 0)
# Output: (102, 120, 130, 132, 210, 230, 302, 310, 312, 320)
# Example 2
# Input: @ints = (2, 2, 8, 8, 2)
# Output: (222, 228, 282, 288, 822, 828, 882)

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";

my @nums = find_nums(@ARGV);
say join ", ", @nums;

sub find_nums {
    my(@digits) = @_;
    my @nums;
    my %seen;

    my $find_nums;
    $find_nums = sub {
        my($prefix, $pending) = @_;

        # find out if we have a numbermatching the criteria
        if ($prefix ne '' && $prefix >= 100 && $prefix < 1000 && $prefix % 2 == 0) {
            push @nums, 0+$prefix unless $seen{0+$prefix}++;
        }

        return if @$pending == 0 || ($prefix||0) >= 1000;

        for my $i (0 .. $#$pending) {
            my $new_prefix = $prefix . $pending->[$i];
            my @new_pending = @$pending;
            splice(@new_pending, $i, 1);
            $find_nums->($new_prefix, \@new_pending);
        }
    };

    $find_nums->("", \@digits);

    return sort {$a<=>$b} @nums;
}
