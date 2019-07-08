#!/usr/bin/env perl
use v5.22;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use autodie;

use bignum;
use List::Util qw(max sum);

my @slices;
for my $i (1..100) {
    push @slices, [ $i, (1.0 - (sum(seconds(@slices)) // 0)) * $i / 100.0 ];
}

print "Largest piece goes to guest # ";
my $max = max seconds(@slices);
say join " ", firsts(grep { $_->[1] == $max } @slices);

printf("Slice size: %.2f%% of the pie\n", $max * 100.0);

sub firsts(@array)  { return map { $_->[0] } @array }
sub seconds(@array) { return map { $_->[1] } @array }

