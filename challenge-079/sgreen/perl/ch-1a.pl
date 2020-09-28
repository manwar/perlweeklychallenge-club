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

    foreach my $i ( 1 .. $N ) {
        my $str = sprintf '%b', $i;
        $count += $str =~ tr/1//;
    }

    printf qq(%d %% %d = %d\n), $count, 1000000007, $count % 1000000007;
}

main(@ARGV);
