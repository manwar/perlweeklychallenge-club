#!/usr/bin/perl

# Challenge 194
#
# Task 2: Frequency Equalizer
# Submitted by: Mohammad S Anwar
# You are given a string made of alphabetic characters only, a-z.
#
# Write a script to determine whether removing only one character can make the
# frequency of the remaining characters the same.
#
# Example 1:
# Input: $s = 'abbc'
# Output: 1 since removing one alphabet 'b' will give us 'abc' where each
# alphabet frequency is the same.
# Example 2:
# Input: $s = 'xyzyyxz'
# Output: 1 since removing 'y' will give us 'xzyyxz'.
# Example 3:
# Input: $s = 'xzxz'
# Output: 0 since removing any one alphabet would not give us string with same
# frequency alphabet.

use Modern::Perl;
use List::Util qw( min max );

sub freq_equalizer {
    my($text)=@_;
    my %freq; $freq{$_}++ for split //, $text;
    my @freq=sort values %freq;
    return 0 if @freq<1;
    my $min=min(@freq);
    my $max=max(@freq);
    return 0 unless $min+1==$max;
    return 1 if 1==scalar grep {$_==$max} @freq;
    return 0;
}

say freq_equalizer($ARGV[0]);
