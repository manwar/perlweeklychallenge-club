#!/usr/bin/env perl

# You are given an array of strings.

# Write a script to find if the two strings (str1, str2) in the given
# array such that str1 is prefix and suffix of str2. Return the total
# count of such pairs.

use Dev::Util::Syntax;
use Algorithm::Combinatorics qw(combinations);
use Test2::V0;
plan tests => 6;

use lib '.';
use PWC;
my $json_data = get_json_data();

is( prefix_suffix( $_->{ in } ), $_->{ out }->[0], $_->{ name } )
    for $json_data->{examples}->@*;

sub pre_suf {
    my ( $str1, $str2 ) = @_;

    return (    ( $str1 eq substr( $str2, 0, length $str1 ) )
             && ( $str1 eq substr( $str2, -length $str1, length $str1 ) ) );
}

sub prefix_suffix {
    my @array = $_[0]->@*;
    print_inputs($json_data->{input_vars}, @_);
    my $result = 0;

    my $iter = combinations( \@array, 2 );
    while ( my $com = $iter->next ) {
        if ( pre_suf( $com->@* ) ) {
            $result++;
        }
    }

    print_outputs($result);
    return $result;
}
