#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use List::Util 'any';

sub same_letters ( $str1, $str2 ) {
    # Compare two strings to see if they contain the same letters
    my %freq = ();
    for my $letter ( split //, $str1 ) {
        $freq{$letter}++;
    }
    for my $letter ( split //, $str2 ) {
        $freq{$letter}--;
    }
    if ( any { $_ } values(%freq) ) {
        return undef;
    }
    return 1;
}

sub scramble_string ( $str1, $str2 ) {
    # Check each string has the same frequency of letters
    if ( not same_letters( $str1, $str2 ) ) {
        # If they don't, there is no possible solution
        return undef;
    }

    # If there are one or two letters, they are identical or swapped
    if ( length($str1) < 3 ) {
        return 1;
    }

    foreach my $split_pos ( 1 .. length($str1) - 1 ) {
        # Consider scrambling letters each side of split_pos
        if (
            scramble_string(
                substr( $str1, 0, $split_pos ),
                substr( $str2, 0, $split_pos )
            )
            and scramble_string(
                substr( $str1, $split_pos ),
                substr( $str2, $split_pos )
            )
          )
        {
            return 1;
        }

        # Consider swapping the split parts before scrambling letters
        if (
            scramble_string(
                substr( $str1, 0, $split_pos ),
                substr( $str2, -$split_pos )
            )
            and scramble_string(
                substr( $str1, $split_pos ),
                substr( $str2, 0, -$split_pos )
            )
          )
        {
            return 1;
        }
    }

    return undef;
}

sub main ( $str1, $str2 ) {
    my $result = scramble_string( $str1, $str2 );
    say $result ? 'true' : 'false';
}

main(@ARGV);
