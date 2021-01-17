#!/usr/bin/env perl

use strict;
use warnings;

use feature 'say';

sub main {
    my $N = shift;

    # Sanity check
    die "You must enter a number\n" if not defined $N;
    die "The value '$N' does not look like a number\n" unless $N =~ /^-?\d+(?:\.\d+)?$/;

    # Say 1 if the reversed string equals the number, otherwise say 0
    say $N eq reverse($N) ? 1 : 0;
}

main(@ARGV);
