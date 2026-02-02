#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($input_string) {
    my $changes = 1;
    while ($changes) {
        $changes = ( $input_string =~ s/(.)\1+//g );
    }

    say "'$input_string'";
}

main( $ARGV[0] );
