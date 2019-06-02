#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';
use List::Util qw(sum);

# Write a script to find Jaro-Winkler distance between two strings.

sub max ( $a, $b ) { ( $a > $b ) ? $a : $b }
sub min ( $a, $b ) { ( $a < $b ) ? $a : $b }

sub jaro {
    my ( $s1, $s2 ) = @_;
    my ( $len1, $len2 ) = ( length($s1), length($s2) );
    my @s1 = split //, uc($s1);
    my @s2 = split //, uc($s2);
    return 0 if ( $len1 == 0 || $len2 == 0 );

    # Find matching characters from s1 in s2
    my $match_dist = int( max( $len1, $len2 ) / 2 ) - 1;
    my ( @s1_matches, @s2_matches );

    for ( my $i = 0; $i < @s1; ++$i ) {
        my $win_start = max( 0, $i - $match_dist );
        my $win_stop = min( $len2, $i + $match_dist + 1 );

        for ( my $j = $win_start; $j < $win_stop; ++$j ) {
            next if ( $s2_matches[$j] );
            if ( $s1[$i] eq $s2[$j] ) {
                $s1_matches[$i] = 1;
                $s2_matches[$j] = 1;
                last;
            }
        }
    }

    # Now count transpositions
    # Get only the matching characters from each string.
    @s1_matches = @s1[ grep { $s1_matches[$_] } 0 .. @s1_matches ];
    @s2_matches = @s2[ grep { $s2_matches[$_] } 0 .. @s2_matches ];
    my $matches = @s1_matches;

    # Score is 0 if there are no matches
    return 0 unless $matches;

    my $transpositions;

    # If sequence of characters is not the same, a transposition occurred
    for ( my $i = 0; $i < @s1_matches; ++$i ) {
        $transpositions += ( $s1_matches[$i] ne $s2_matches[$i] );
    }

    $transpositions /= 2;
    return ( ( $matches / $len1 )
        + ( $matches / $len2 )
            + ( ( $matches - $transpositions ) / $matches ) ) / 3;
}

sub jaro_winkler {
    my ( $s1, $s2 ) = @_;
    my $sim_j = jaro( $s1, $s2 );
    return 0 if $sim_j == 0;

    my $p = 0.1;
    my $max_len = max( length($s1), length($s2) );

    # Find length of common prefix
    my $l = 1;
    while ( $l <= min( 4, $max_len ) ) {
        last if ( substr( $s1, 0, $l ) ne substr( $s2, 0, $l ) );
        ++$l;
    }

    $l--;

    return $sim_j + $l * $p * ( 1 - $sim_j );
}

# Some test strings:
my @set1 = qw(RICK DWAYNE MARTHA DIXON JELLYFISH);
my @set2 = qw(RICK DUANE MARHTA DICKSONX SMELLYFISH);

for ( my $i = 0; $i < @set1; ++$i ) {
    say "$set1[$i]\t$set2[$i]\t" . (1-jaro_winkler( $set1[$i], $set2[$i] ));
}
