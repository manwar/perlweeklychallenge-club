#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use List::Util qw(any max sum);

sub main (@ints) {
    # Calculate the average
    my $average = sum(@ints) / scalar(@ints);

    # The first possible answer is one more than the average or 1, whichever
    #  is greater.
    my $result = max( 1, int($average) + 1 );

    ++$result while ( any { $_ == $result } @ints );

    say $result;
}

main(@ARGV);
