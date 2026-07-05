#!/usr/bin/env perl

# You are given a string.

# Write a script to find the reverse degree of the given string.

#     For each character, multiply its position in the reversed alphabet
#     (‘a’ = 26, ‘b’ = 25, …, ‘z’ = 1) with its position in
#     the string. Sum these products for all characters in the string to
#     get the reverse degree.

use Dev::Util::Syntax;
use Test2::V0;
plan tests => 5;

use lib '.';
use PWC;
my $json_data = get_json_data();

my %char_to_num;
@char_to_num{ "a" .. "z" } = map { 27 - $_ } ( 1 .. 26 );

is( reverse_degree( $_->{ in } ), $_->{ out }->[0], $_->{ name } )
    for $json_data->{ examples }->@*;

sub reverse_degree {
    my $str = $_[0]->[0];
    print_inputs( $json_data->{ input_vars }, @_ );
    my $result = 0;

    $result += $_ * $char_to_num{ substr( $str, $_ - 1, 1 ) }
        for ( 1 .. length($str) );

    print_outputs($result);
    return $result;
}
