#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@array) {
    my $missing = my $duplicate = undef;

    foreach my $i ( 1 .. $#array + 1 ) {
        # Find out how many times this number appears in the list
        my $count = scalar( grep { $_ == $i } @array );
        if ( $count == 0 ) {
            $missing = $i;
        }
        elsif ( $count > 1 ) {
            $duplicate = $i;
        }
    }

    if ( not defined $missing ) {
        say -1;
    }
    else {
        $duplicate //= '';
        say "($duplicate, $missing)";
    }
}

main(@ARGV);