#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use List::Util qw(max min);

sub main (@ints) {
    # Find the minimum and maximum value
    my $min_value = min(@ints);
    my $max_value = max(@ints);

    # Count the number of items in the array that are not the min or max
    my $count = grep { $_ != $min_value && $_ != $max_value } @ints;
    say $count;
}

main(@ARGV);
