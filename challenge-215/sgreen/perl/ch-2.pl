#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@array) {
    my $to_place = pop(@array);

    foreach my $i ( 1 .. $#array - 1 ) {
        # Are the number before the current one, the current one and the
        #  next one all zero?
        if (    $array[ $i - 1 ] == 0
            and $array[$i] == 0
            and $array[ $i + 1 ] == 0 )
        {
            # If so, we can put a one here
            $array[$i] = 1;
            if ( --$to_place == 0 ) {
                # We have placed all the ones
                say 1;
                return;
            }
        }
    }

    # There is no possible solution
    say 0;
}

main(@ARGV);