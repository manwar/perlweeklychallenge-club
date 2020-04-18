#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-056/
#   
#               Task 1
#
#               You are given an array @N of positive integers (sorted) and another non negative integer k.
#               Write a script to find if there exists 2 indices i and j such that A[i] - A[j] = k and i != j.
#                It should print the pairs of indices, if any such pairs exist.
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 04/18/2020 01:59:29 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw/say/;

sub get_valid_pairs {
    my ($k, @arr) = @_;

    my $answer;

    for my $i (0 .. scalar @arr - 2) {
        my $j = $i + 1;

        while (($arr[$j] - $arr[$i] < $k) and ($j < scalar @arr -1)) {
            $j++;
        }

        $answer .= "($j,$i)" if $arr[$j] - $arr[$i] == $k;
    }

        return $answer;
}

# TESTS

use Test::More;

is(get_valid_pairs(2, 2, 7, 9), "(2,1)");
is(get_valid_pairs(2, 2, 4, 6), "(1,0)(2,1)");
is(get_valid_pairs(2, 2, 8, 9), undef);
done_testing;
