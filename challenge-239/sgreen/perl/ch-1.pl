#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@lists) {
    # Remove everything that isn't a letter
    $lists[0] =~ s/[^a-z]//gi;
    $lists[1] =~ s/[^a-z]//gi;

    # Compare the results
    say $lists[0] eq $lists[1] ? 'true' : 'false';
}

main(@ARGV);