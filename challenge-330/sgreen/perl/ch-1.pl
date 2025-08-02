#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($input_string) {
    my $solution = $input_string;

    my $changes = 1;
    while ($changes) {
        # See if there are any letter / digit pairs to remove
        $changes = ( $solution =~ s/[a-z][0-9]// );
    }

    say '"', $solution, '"';
}

main( $ARGV[0] );
