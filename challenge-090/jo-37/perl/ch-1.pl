#!/usr/bin/perl

use Test2::V0;

# Count nucleotides and generate complement
sub complement_dna {
	local $_ = shift;

	# Create the complement (providing the count) and return this as
	# the final return value.
	(y/TAGC/ATCG/, $_);
}


is [complement_dna(
		'GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG')],
	[67, 'CATTTGGGGAAAAGTAAATCTGTCTAGCTGAGGAATAGGTAAGAGTCTCTACACAACGACCAGCGGC'],
	'count and complement';
	
is complement_dna(
		'GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG'),
	'CATTTGGGGAAAAGTAAATCTGTCTAGCTGAGGAATAGGTAAGAGTCTCTACACAACGACCAGCGGC',
	'complement only';


done_testing;
