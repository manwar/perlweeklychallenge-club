#!/usr/bin/env perl

# You are given two coordinates of a square on 8x8 chessboard.

# Write a script to find the given two coordinates have the same colour.

# 8 W B W B W B W B
# 7 B W B W B W B W
# 6 W B W B W B W B
# 5 B W B W B W B W
# 4 W B W B W B W B
# 3 B W B W B W B W
# 2 W B W B W B W B
# 1 B W B W B W B W
#   a b c d e f g h

use 5.018;
use strict;
use warnings;
use File::JSON::Slurper qw(read_json);
use boolean             qw(true false);
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

is( chessboard_squares( $_->{ in } ), $_->{ out }->[0], $_->{ name } )
    for @{ $examples_ref };

sub alpha_2_num {
    my $alpha = shift;
    return unless ( $alpha =~ m/[a-z]/ );
    return ord($alpha) - ord('a') + 1;
}

sub sq_col {
    my $sq = shift;
    return ( alpha_2_num( substr( $sq, 0, 1, '' ) ) + $sq ) % 2;
}

sub chessboard_squares {
    my $c1 = $_[0]->[0];
    my $c2 = $_[0]->[1];
    printf qq{Input: %s = "%s, %s = "%s"\n},
        $input_vars_ref->[0], $c1,
        $input_vars_ref->[1], $c2;
    my $result = false;

    if ( sq_col($c1) == sq_col($c2) ) {
        $result = true;
    }

    printf qq{Output: %s\n}, $result;
    return $result;
}

