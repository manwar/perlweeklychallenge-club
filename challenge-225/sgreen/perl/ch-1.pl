#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'max';

sub main (@sentences) {
    # Count the number of spaces + 1
    my @words = map { tr/ / / + 1 } @sentences;

    # Display the maximum number of words
    say max(@words);
}

main(@ARGV);