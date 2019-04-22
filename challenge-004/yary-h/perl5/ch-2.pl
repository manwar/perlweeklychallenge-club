#!/usr/bin/env perl -n

# run as "ch-2.pl words.txt"

use strict;
use warnings;
use feature 'state','say';

state $letters = [split '', 'nnaaabpepl']; # letter bag, in any order

chomp;
my $orig = $_;
for my $letter (@$letters) {
    next unless s/$letter//i;
    say $orig unless $_;
}
