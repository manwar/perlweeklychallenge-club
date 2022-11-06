#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@array) {
    # The last value is the target
    my $target = pop(@array);

    # Find items greater than the target
    @array = sort( grep { $_ gt $target } @array );

    # Print the first value if there is one.
    if ( scalar(@array) ) {
        say $array[0];
    }
    else {
        # else print the target
        say $target;
    }
}

main(@ARGV);