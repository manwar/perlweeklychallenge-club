#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my @N = @_;

    # Sanity check
    die "You must specify one or more numbers\n" unless @N;
    die "One or more values is not a number\n" if grep { !/^[0-9]+(?:\.[0-9]+)?$/ } @N;

    my $cnt = my $sum = 0;
    say join ' ', map { ++$cnt; $sum += $_; $sum / $cnt } @N;
}

main(@ARGV);
