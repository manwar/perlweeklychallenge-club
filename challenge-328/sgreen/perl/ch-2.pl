#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($input_string) {
    my $solution = $input_string;
  O: while (1) {
        foreach my $idx ( 0 .. length($solution) - 2 ) {
            my $char = substr( $solution, $idx, 1 );

            # If the nex two letters are the same but different case, remove them
            if (
                (
                    $char eq uc($char)
                    and substr( $solution, $idx + 1, 1 ) eq lc($char)
                )
                or ( $char eq lc($char)
                    and substr( $solution, $idx + 1, 1 ) eq uc($char) )
              )
            {
                substr( $solution, $idx, 2 ) = '';
                next O;
            }
        }

        last;
    }

    say '"', $solution, '"';
}

main( $ARGV[0] );
