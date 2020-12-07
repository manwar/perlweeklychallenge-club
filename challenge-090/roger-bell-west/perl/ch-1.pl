#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is_deeply(gs('GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG'),[67,'CATTTGGGGAAAAGTAAATCTGTCTAGCTGAGGAATAGGTAAGAGTCTCTACACAACGACCAGCGGC'],'example 1');

sub gs {
  my $bs=shift;
  (my $cs=$bs) =~ s/G/X/g;
  $cs =~ s/C/G/g;
  $cs =~ s/X/C/g;
  $cs =~ s/A/X/g;
  $cs =~ s/T/A/g;
  $cs =~ s/X/T/g;
  return [length($bs),$cs];
}
