#!/usr/bin/perl -s

use v5.16;
use warnings;
use List::UtilsBy 'count_by';

my %freq = count_by {$_} split /\s+/, join ' ', <>;
while (my ($word, $count) = each %freq) {
    say "$word\t$count";
}
