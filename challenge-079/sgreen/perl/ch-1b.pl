#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my $N     = shift;
    my $count = 0;

    # Sanity check
    die "Please enter a positive integer\n" unless $N;
    die "The value '$N' is not a positive integer\n"
      unless $N =~ /^[1-9][0-9]*$/;

    my $b = 1;
    while ( $b < $N ) {
        foreach my $i ( 1 .. $N ) {
            $count++ if $i & $b;
        }
        $b *= 2;
    }

    printf qq(%d %% %d = %d\n), $count, 1000000007, $count % 1000000007;
}

main(@ARGV);

