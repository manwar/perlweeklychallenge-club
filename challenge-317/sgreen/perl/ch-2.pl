#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'any';

sub main ( $str1, $str2 ) {
    # Check strings are the same length
    if ( length($str1) != length($str2) ) {
        say 'false';
        return;
    }

    if ( $str1 eq $str2 ) {
        # We can still swap two characters if there are any letters that
        #  appear two or more times
        my %freq = ();
        foreach my $i ( 0 .. length($str1) - 1 ) {
            ++$freq{ substr( $str1, $i, 1 ) };
        }
        if ( any { $_ > 1 } values(%freq) ) {
            say 'true';
        }
        else {
            say 'false';
        }
        return;
    }

    # Find characters that are different
    my @differences =
      ( grep { substr( $str1, $_, 1 ) ne substr( $str2, $_, 1 ) }
          ( 0 .. length($str1) - 1 ) );

    if ( $#differences == 1 ) {
        # Check that the letters at each position were switched
        my ( $pos1, $pos2 ) = @differences;
        if (    substr( $str1, $pos1, 1 ) eq substr( $str2, $pos2, 1 )
            and substr( $str2, $pos1, 1 ) eq substr( $str1, $pos2, 1 ) )
        {
            say 'true';
            return;
        }
    }

    say 'false';
}

main( $ARGV[0], $ARGV[1] );