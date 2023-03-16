#!/usr/bin/perl

use strict;
use warnings;

sub jaro_winkler_distance {
    my ( $s1, $s2, $p ) = @_;
    $p ||= 0.1;    # default scaling factor

    # Step 1: Calculate the Jaro distance
    my $matches        = 0;
    my $transpositions = 0;
    my $s1_len         = length($s1);
    my $s2_len         = length($s2);
    my $match_distance = int( max( $s1_len, $s2_len ) / 2 ) - 1;
    my %s2_matches     = ();
    for ( my $i = 0 ; $i < $s1_len ; $i++ ) {
        my $c1    = substr( $s1, $i, 1 );
        my $start = max( 0, $i - $match_distance );
        my $end   = min( $i + $match_distance + 1, $s2_len );
        for ( my $j = $start ; $j < $end ; $j++ ) {
            if ( !$s2_matches{$j} && substr( $s2, $j, 1 ) eq $c1 ) {
                $matches++;
                $s2_matches{$j} = 1;
                last;
            }
        }
    }
    return 0 if ( $matches == 0 );    # no matches found
    my $jaro_distance =
      ( $matches / $s1_len +
          $matches / $s2_len +
          ( $matches - $transpositions / 2 ) / $matches ) / 3;

    # Step 2: Calculate the Jaro-Winkler distance
    my $prefix_len = 0;
    for ( my $i = 0 ; $i < min( $s1_len, $s2_len ) ; $i++ ) {
        if ( substr( $s1, $i, 1 ) eq substr( $s2, $i, 1 ) ) {
            $prefix_len++;
        }
        else {
            last;
        }
    }
    my $jaro_winkler_distance =
      $jaro_distance + $prefix_len * $p * ( 1 - $jaro_distance );
    return $jaro_winkler_distance;
}

# Helper function to find the max of two values
sub max {
    my ( $a, $b ) = @_;
    return $a > $b ? $a : $b;
}

# Helper function to find the min of two values
sub min {
    my ( $a, $b ) = @_;
    return $a < $b ? $a : $b;
}

# Test the function
my $s1       = 'MARTHA';
my $s2       = 'MARHTA';
my $distance = jaro_winkler_distance( $s1, $s2 );
print "Jaro-Winkler distance between '$s1' and '$s2' is $distance\n";
