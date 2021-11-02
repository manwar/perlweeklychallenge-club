#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my $n = shift;

    # Sanity check
    die "You must specify a number"               unless defined $n;
    die "The value does not look like a number\n" unless $n =~ /^[0-9]+$/;
    die "The value must be between 10 and 1,000"  unless $n >= 10 and $n <= 1000;

    my $lychrel = 1;
    my $count   = 0;
    my $i       = $n;

    while ( ++$count <= 500 and $i <= 10_000_000 ) {
        my $r = reverse($i);
        if ( $i == $r ) {
            # The number is not lychrel-al (is that a word?)
            $lychrel = 0;
            last;
        }

        # Add the reverse to the original number, and repeat the test
        $i += $r;
    }

    say $lychrel;
}

main(@ARGV);
