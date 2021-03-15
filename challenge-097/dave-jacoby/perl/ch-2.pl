#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use Getopt::Long;
use List::Util qw{min};

my $S = 3;
my $B = '101100101';
GetOptions(
    'binary=s' => \$B,
    'size=i'   => \$S,
);

# binary_substrings($B,$S);

binary_substrings( '101100101', 3 );
binary_substrings( '10110111',  4 );
binary_substrings( '111100000000',  4 );

sub binary_substrings ( $B, $S ) {

    # we're comparing everything to the first substring in B
    # of size S, so let's pull it out here.
    # also copy B so it's unmodified when done.
    my $base = substr $B, 0, $S;
    my $C    = $B;

    my $total = 0;
    my @list;

    while ($C) {
        my $sub = substr( $C, 0, $S );
        substr( $C, 0, $S ) = '';

        # I feel there MUST be a bitwise operator that
        # would be perfect for this, but I never deal with
        # bitwise operators, and we dealt with edit distance
        # just last week
        my $d = levenshtein_distance( $base, $sub );
        $total += $d;

        # d < 1 is a bit of belt-and-suspenders thinking,
        # because coming from levenshtein, it will only be
        # a non-negative integer, but still...

        # and the examples distinguished between "1 flip" 
        # and "2 flips", so to handle singular and plural,
        # we move to three cases. 

        if    ( $d < 1 ) { push @list, qq{"$sub": 0 flip}; }
        elsif ( $d == 1 ) {
            push @list, qq{"$sub": 1 flip to make it "$base"};
        }
        else { push @list, qq{"$sub": $d flips to make it "$base"}; }
    }
    say qq{INPUT: \$B = "$B", \$S = $S};
    say qq{Output: $total};
    say join "\n\t", 'Binary Substrings:', @list;
    say '';
}

# -------------------------------------------------------------------
# straight copy of Wikipedia's "Levenshtein Distance"
sub levenshtein_distance {
    my ( $f, $g ) = @_;
    my @a = split //, $f;
    my @b = split //, $g;

    # There is an extra row and column in the matrix. This is the
    # distance from the empty string to a substring of the target.
    my @d;
    $d[$_][0] = $_ for ( 0 .. @a );
    $d[0][$_] = $_ for ( 0 .. @b );

    for my $i ( 1 .. @a ) {
        for my $j ( 1 .. @b ) {
            $d[$i][$j] = (
                  $a[ $i - 1 ] eq $b[ $j - 1 ]
                ? $d[ $i - 1 ][ $j - 1 ]
                : 1 + min(
                    $d[ $i - 1 ][$j],
                    $d[$i][ $j - 1 ],
                    $d[ $i - 1 ][ $j - 1 ]
                )
            );
        }
    }
    return $d[@a][@b];
}

