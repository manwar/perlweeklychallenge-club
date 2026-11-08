#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use List::Util "sum";

sub main (@ints) {
    # Eligible integers are divisible by 6.
    my @eligible_ints = grep { $_ % 6 == 0 } @ints;

    if ( scalar(@eligible_ints) ) {
        # Return the closest integer
        say sprintf "%.0f", sum(@eligible_ints) / scalar(@eligible_ints);
    }
    else {
        # No eligible integers found
        say 0;
    }
}

main(@ARGV);
