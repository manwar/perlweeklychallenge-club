#!/usr/bin/env perl

# You are given a string $str consisting of lowercase English letters, and
# an integer $k.

# Write a script to convert a lowercase string into numbers using
# alphabet positions (a=1 … z=26), concatenate them to form an integer,
# then compute the sum of its digits repeatedly $k times, returning the
# final value.

use 5.018;
use strict;
use warnings;
use Test2::V0;

plan tests => 5;

sub alpha_2_num {
    my $alpha = shift;
    return unless ( $alpha =~ m/[a-z]/ );
    return ord($alpha) - ord('a') + 1;
}

sub sum_digits {
    my $anum = shift;
    my $sum  = 0;
    return $anum if $anum < 10;
    while ( $anum =~ m|(\d)|g ) { $sum += $1; }
    return $sum;
}

sub alphabet_index_digit_sum {
    my $str    = $_[0]->[0];
    my $k      = $_[0]->[1];
    printf qq{ Input: $str = "%s", $k = %d\n }, $str, $k;

    my $alphanum = q{};

    while ( $str =~ m|(.)|g ) {
        my $letter = $1;
        $alphanum .= alpha_2_num($letter);
    }

    while ( $k > 0 ) {
        $alphanum = sum_digits($alphanum);
        $k--;
    }

    printf qq{Output: %d\n}, $alphanum;
    return $alphanum;
}

my @examples = (
                 { in => [ "abc",  1 ], out => 6, name => 'example 1' },
                 { in => [ "az",   2 ], out => 9, name => 'example 2' },
                 { in => [ "cat",  1 ], out => 6, name => 'example 3' },
                 { in => [ "dog",  2 ], out => 8, name => 'example 4' },
                 { in => [ "perl", 3 ], out => 6, name => 'example 5' },
               );

is( alphabet_index_digit_sum( $_->{ in } ), $_->{ out }, $_->{ name } )
    for @examples;
