#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'all';

sub main (@words) {
    # The last value is the 'allowed' list
    my $allowed = pop(@words);
    my %allowed = map { $_, 1 } split(//, $allowed);
    my $count = 0;

    # Count the number of words that match this regular expression
    foreach my $word (@words) {
        $count++ if all { exists $allowed{$_} } split(//, $word);
    }

    say $count;
}

main(@ARGV);