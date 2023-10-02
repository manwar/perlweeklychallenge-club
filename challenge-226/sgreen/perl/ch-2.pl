#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'uniq';

sub main (@ints) {
    # The solution is the number of uniq positive integers
    my $count = scalar( uniq grep { $_ != 0 } @ints );
    say $count;
}

main(@ARGV);