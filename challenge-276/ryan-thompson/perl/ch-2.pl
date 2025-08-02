#!/usr/bin/env perl
#
# ch-2.pl - Maximum Frequency
#
# 2024 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';
use List::Util qw< sum0 max >;

# First identify which number(s) appear most often in the list,
# then return the count of all such numbers. Ex. 1, 2, 2, 4, 1, 5
# should return 4, because the matching numbers are 1,1,2,2 (freq:2)
sub max_freq {
    my %freq; # Frequency table
    $freq{$_}++ for @_;

    my $max_freq = max values %freq; # Maximal frequency
    
    $max_freq * grep { $_ == $max_freq } values %freq;
}

use Test::More;

is max_freq(qw< 1 2 2 4 1 5 >), 4       => 'Example 1';
is max_freq(qw< 1 2 3 4 5 >), 5         => 'Example 2';
is max_freq(qw< 1 2 2 4 6 1 5 6 >), 6   => 'Example 3';
is max_freq(qw< a a b a b b c >), 6     => 'Non-numeric';
is max_freq(3.1415926), 1               => 'Single';
is max_freq(), 0                        => 'Empty';

done_testing;
