#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

sub disjoint_sets ($seq1, $seq2) {
   my %flag = map { $_ => 1 } $seq1->@*;
   for my $e ($seq2->@*) { return 0 if exists $flag{$e} }
   return 1;
}

say disjoint_sets(map { [split m{\D+}mxs] } @ARGV);
