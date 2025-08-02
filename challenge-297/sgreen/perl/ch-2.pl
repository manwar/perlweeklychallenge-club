#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util      qw(max min);
use List::MoreUtils qw(first_index last_index);

sub main (@ints) {
    # Find the position of the first minimum and last maximum
    my $min_index = first_index { min(@ints) == $_ } @ints;
    my $max_index = last_index { max(@ints) == $_ } @ints;

    # If the maximum is before the minimum remove one
    my $offset = $max_index < $min_index ? 1 : 0;
    say $min_index + $#ints - $max_index - $offset;
}

main(@ARGV);