#! /usr/bin/perl6

use Test;
plan 1;

is-deeply(gs('GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG'),(67,'CATTTGGGGAAAAGTAAATCTGTCTAGCTGAGGAATAGGTAAGAGTCTCTACACAACGACCAGCGGC'),'example 1');

sub gs($bs) {
  (my $cs=$bs) ~~ s:g/G/X/;
  $cs ~~ s:g/C/G/;
  $cs ~~ s:g/X/C/;
  $cs ~~ s:g/A/X/;
  $cs ~~ s:g/T/A/;
  $cs ~~ s:g/X/T/;
  return (chars($bs),$cs);
}
