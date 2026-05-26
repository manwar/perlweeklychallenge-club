#!/usr/bin/env perl

# You are given a number and a digit (k).

# Write a script to find the K-Beauty of the given number. The K-Beauty of
# an integer number is defined as the number of substrings of given number
# when it is read as a string has length of ‘k’ and is a divisor of
# given number.

use 5.018;
use strict;
use warnings;
use File::JSON::Slurper qw(read_json);
use Data::Printer;

use Test2::V0;
plan tests => 5;

my $json_ref = read_json( __FILE__ =~ s/pl$/json/r )
    or die "ERROR: could not read test data from json file\n";
my $challenge_ref  = $json_ref->{ challenge };
my $input_vars_ref = $json_ref->{ input_vars };
my $examples_ref   = $json_ref->{ examples };

printf qq{Challenge: %s Task %s: %s\n\n},
    $challenge_ref->{ week },
    $challenge_ref->{ task },
    $challenge_ref->{ name };

is( find_k_beauty( $_->{ in } ), $_->{ out }, $_->{ name } )
    for @{ $examples_ref };

sub find_k_beauty {
    my $num = $_[0]->[0];
    my $k   = $_[0]->[1];
    printf qq{Input: %s = %s, %s = %s\n},
        $input_vars_ref->[0], $num,
        $input_vars_ref->[1], $k;
    my $result = q{0};

    for ( 0 .. length($num) - $k ) {
        my $subst = substr( $num, $_, $k );
        $result++ if $num % $subst == 0;
    }

    printf qq{Output: %s\n}, $result;
    return $result;
}
