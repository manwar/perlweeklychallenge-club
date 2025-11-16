#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'min';

sub main ($input_string) {
    # Strip all non-digit characters
    $input_string =~ s/\D//g;

    my @parts = ();
    while ($input_string) {
        # Decide length of next part
        my $l =
          length($input_string) == 4 ? 2 : min( 3, length($input_string) );
        push @parts, substr( $input_string, 0, $l, "" );
    }

    say join( "-", @parts );
}

main( $ARGV[0] );
