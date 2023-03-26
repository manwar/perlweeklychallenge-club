#!/usr/bin/perl

# Challenge 195
#
# Task 2: Most Frequent Even
# Submitted by: Mohammad S Anwar
# You are given a list of numbers, @list.
#
# Write a script to find most frequent even numbers in the list. In case you
# get more than one even numbers then return the smallest even integer. For all
# other case, return -1.
#
# Example 1
# Input: @list = (1,1,2,6,2)
# Output: 2 as there are only 2 even numbers 2 and 6 and of those 2 appears
# the most.
# Example 2
# Input: @list = (1,3,5,7)
# Output: -1 since no even numbers found in the list
# Example 3
# Input: @list = (6,4,4,6,1)
# Output: 4 since there are only two even numbers 4 and 6. They both appears
# the equal number of times, so pick the smallest.

use Modern::Perl;

sub most_freq_even {
    my(@n)=@_;
    my %hist;
    $hist{$_}++ for grep {$_%2==0} @n;
    my $most_freq=0;
    my $most_freq_num=-1;
    while (my($num, $freq)=each %hist) {
        if ($freq>$most_freq) {
            ($most_freq_num, $most_freq) = ($num, $freq);
        }
        elsif ($freq==$most_freq && $num<$most_freq_num) {
            ($most_freq_num, $most_freq) = ($num, $freq);
        }
    }
    return $most_freq_num;
}

@ARGV or die "usage: ch-2.pl nums...\n";
my @n=@ARGV;
say most_freq_even(@n);
