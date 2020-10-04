#! /usr/bin/env perl

use Perl6::Junction 'all';
use List::MoreUtils qw(uniq);
use Getopt::Long;
use feature 'say';
use strict;

my $verbose = 0;

GetOptions("verbose"  => \$verbose);

my @A = @ARGV;

die "Please specify at least one element" unless @A;

die "Integers only" unless all(@A) == qr/^\d+$/;

my @positively_sorted = uniq sort { $a <=> $b } grep { $_ > 0 } @A;

say ": Positively Sorted: " . join(", ", @positively_sorted) if $verbose;

my $expected = 1;

for my $current (@positively_sorted)
{
  say ": Current value: $current - expected $expected" if $verbose;
  last if $current != $expected;
  $expected++;
}

say $expected;