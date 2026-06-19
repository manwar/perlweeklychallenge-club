#!/usr/bin/env perl

# You are given a string.

# Write a script to find whether any substring of length 2 is also present
# in the reverse of the given string.

use Dev::Util::Syntax;
use Test2::V0;
plan tests => 5;

use lib '.';
use PWC;
my $json_data = get_json_data();

is( reverse_existence( $_->{ in } ), $_->{ out }->[0], $_->{ name } )
    for $json_data->{examples}->@*;

sub reverse_existence {
    my $str = $_[0]->[0];
    print_inputs($json_data->{input_vars}, @_);
    my $result = false;

    my @substrs;
    $str =~ m{ # get all two char substrings
                (..)
                (?{push @substrs, $&})
                (?!)
            }x;

    my $rev = reverse $str;

    for (@substrs) {
        if ( index( $rev, $_ ) != -1 ) {
            $result = true;
            last;
        }
    }

    print_outputs($result);
    return $result;
}
