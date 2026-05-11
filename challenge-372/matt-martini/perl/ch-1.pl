#!/usr/bin/env perl

# You are given a string text of words that are placed among number
# of spaces.

# Write a script to rearrange the spaces so that there is an equal number
# of spaces between every pair of adjacent words and that number is
# maximised. If you can’t distribute, place the extra spaces at the end.
# Finally return the string.

use 5.018;
use strict;
use warnings;
use utf8;
use open qw(:std :utf8);
use File::JSON::Slurper qw(read_json);
use Data::Printer;

use Test2::V0;
plan tests => 5;

my $json_ref       = read_json( __FILE__ =~ s/pl$/json/r );
my $challenge_ref  = $json_ref->{ challenge };
my $input_vars_ref = $json_ref->{ input_vars };
my $examples_ref   = $json_ref->{ examples };

printf qq{Challenge: %s Task %s: %s\n\n},
    $challenge_ref->{ week },
    $challenge_ref->{ task },
    $challenge_ref->{ name };

is( rearrange_spaces( $_->{ in } ), $_->{ out }->[0], $_->{ name } )
    for @{ $examples_ref };

sub rearrange_spaces {
    my $str = $_[0]->[0];
    printf qq{ Input: %s = "%s"\n }, $input_vars_ref->[0], $str;
    my $result = q{};

    my @words      = split ' ', $str;
    my $num_words  = scalar @words;
    my $num_spaces = () = $str =~ m{\s}g;

    if ( $num_words == 1 ) {
        $result = $words[0] . q{ } x $num_spaces;
    }
    else {
        my ( $between, $at_end ) = div_mod( $num_spaces, $num_words - 1 );
        $result = join( q{ } x $between, @words ) . q{ } x $at_end;
    }

    printf qq{Output: "%s"\n}, $result;
    return $result;
}

sub div_mod { # return result of division and modulus
    return int( $_[0] / $_[1] ), ( $_[0] % $_[1] );
}
