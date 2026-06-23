#!/usr/bin/env perl

# You are given an alphanumeric string.

# Write a script to find the second largest distinct digit in the given
# string. Return -1 if none found.

use Dev::Util::Syntax;
use Test2::V0;
plan tests => 5;

use lib '.';
use PWC;
my $json_data = get_json_data();

is( second_largest_digit( $_->{ in } ), $_->{ out }->[0], $_->{ name } )
    for $json_data->{examples}->@*;

sub second_largest_digit {
    my $str = $_[0]->[0];
    print_inputs($json_data->{input_vars}, @_);
    my $result = q{-1};

    my %seen;
    my @uniq = grep { !$seen{ $_ }++ } sort { $b <=> $a } ( $str =~ m/(\d)/g );
    $result = $uniq[1] if exists $uniq[1];

    print_outputs($result);
    return $result;
}
