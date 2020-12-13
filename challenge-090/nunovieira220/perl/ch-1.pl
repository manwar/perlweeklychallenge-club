#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);
use Data::Dumper;

# Input
my $sequence = "GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG";

# DNA Sequence
my %convert = ('T', 'A', 'A', 'T', 'G', 'C', 'C', 'G');
my %counters = ('A', 0, 'C', 0, 'G', 0, 'T', 0);
my $complementary = '';

for (split('', $sequence)) {
  $counters{$_}++;
  $complementary .= $convert{$_};
}

# Output
say "Adenine: ".$counters{'A'};
say "Cytosine: ".$counters{'C'};
say "Guanine: ".$counters{'G'};
say "Thymine: ".$counters{'T'};
say "Complementary: ".$complementary;