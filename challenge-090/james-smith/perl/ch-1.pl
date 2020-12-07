#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

## Ah! The day job....
## Both these we've always used `tr` for as the fastest way to compute the
## DNA count and to get reverse complement of sequence

my $seq = 'GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG';

is( revcomp($seq), 'CGGCGACCAGCAACACATCTCTGAGAATGGATAAGGAGTCGATCTGTCTAAATGAAAAGGGGTTTAC' );
is_deeply( counts($seq), { 'T' => 22, 'A' => 14, 'C' => 18, 'G' => 13 } );

done_testing();

sub counts {
  return { 'T' => $_[0] =~ tr/T/T/, 'A' => $_[0] =~ tr/A/A/,
           'C' => $_[0] =~ tr/C/C/, 'G' => $_[0] =~ tr/G/G/, };
}

sub revcomp {
  return reverse $_[0] =~ tr/ATCG/TAGC/r;
}

