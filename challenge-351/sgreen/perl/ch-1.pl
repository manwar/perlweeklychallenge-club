#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util qw(max min sum);

sub main (@ints) {
    # Remove min and maximum values
    my $min_value = min(@ints);
    my $max_value = max(@ints);
    my @short_array = grep { $_ != $min_value && $_ != $max_value } @ints;

    # If nothing left, return 0
    if ($#short_array == -1) {
        say 0;
        return;
    }

    # Return the average of the remaining values
    say sum(@short_array) / scalar(@short_array);
}

main(@ARGV);