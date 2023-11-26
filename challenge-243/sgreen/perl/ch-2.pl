#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'sum';
use POSIX 'floor';

sub main (@ints) {
    my $solution = 0;
    foreach my $i (@ints) {
        $solution += sum( map { floor( $i / $_ ) } @ints );
    }

    say $solution;
}

main(@ARGV);