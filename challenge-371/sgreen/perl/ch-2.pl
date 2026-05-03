#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main (@nums) {
    # Store the result list
    my @results = ();

    foreach my $bits ( 1 .. 2**scalar(@nums) - 2 ) {
        # Compute these values for this subset of values
        my $digit_sum = 0;
        my $pos_sum   = 0;
        my @result    = ();
        while ( my ( $pos, $value ) = each @nums ) {

            # Use bitwise operator to determine if we should consider this value
            if ( 2**$pos & $bits ) {
                $digit_sum += $value;
                $pos_sum   += $pos + 1;
                push @result, $value;
            }
        }

        if ( $digit_sum == $pos_sum and $#result > 0 ) {
            # This matches the criteria
            push @results, "(" . join( ", ", @result ) . ")";
        }
    }

    say @results ? join( ", ", @results ) : "()";
}

main(@ARGV);
