#!/usr/bin/env perl

# You are given a number and a digit (k).

# Write a script to find the K-Beauty of the given number. The K-Beauty of
# an integer number is defined as the number of substrings of given number
# when it is read as a string has length of ‘k’ and is a divisor of
# given number.

use Dev::Util::Syntax;
use Test2::V0;
plan tests => 5;

use lib '.';
use PWC;
my $json_data = get_json_data();

is( find_k_beauty( $_->{ in } ), $_->{ out }->[0], $_->{ name } )
    for $json_data->{examples}->@*;

sub find_k_beauty {
    my $num = $_[0]->[0];
    my $k   = $_[0]->[1];
    print_inputs($json_data->{input_vars}, @_);
    my $result = q{0};

    for ( 0 .. length($num) - $k ) {
        my $subst = substr( $num, $_, $k );
        $result++ if $num % $subst == 0;
    }

    print_outputs($result);
    return $result;
}
