#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use autodie;
use feature qw(say signatures);
no warnings 'experimental::signatures';
#
# You are given a positive number $N.
#
# Write a script to count the total numbrer of set bits of the binary
# representations of all numbers from 1 to $N and return
# $total_count_set_bit % 1000000007.

my ($N) = @ARGV;

say count_set_bits($N) % 1000000007;

sub count_set_bits($n) {
    my $count = 0;
    my $i     = 0;

    while ( (1 << $i) <= $n ) {
        my $set          = 0;
        my $change_after = 1 << $i;
        for ( 0 .. $n ) {
            $count += $set;
            if ( $change_after == 1 ) {
                $set          = !$set;
                $change_after = 1 << $i;
            }
            else {
                $change_after--;

            }
        }
        $i++;
    }

    return $count;
}
