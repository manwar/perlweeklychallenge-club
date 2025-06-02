#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-06-02
use utf8;     # Week 324 - task 2 - Total xor
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;
use Algorithm::Combinatorics 'subsets';

total_xor(5, 1, 6);
total_xor(3, 4, 5, 6, 7, 8);
total_xor(1, 3, 6, 8, 9, 15);
total_xor(7, 8, 9, 10, 11, 12);
total_xor(2, 4, 6, 8, 10, 12);

# bigger example
my @array;
push @array, int(rand(2000)) for 0 .. 16;
total_xor(@array);

sub total_xor {
	
	my (@array, $total, $iter, $subtotal, $s, $i);
	
	# initialise
	@array = @_;
	$total = 0;
	$iter = subsets(\@array);
	
	# iterate over subsets
	while ($s = $iter->next) {
		$subtotal = 0;
		$subtotal = $subtotal ^ $_ for @$s;
		$total += $subtotal;
	}
	
	# report
	say qq[\nInput:  \@array = (] . join(', ', @array) . ')';
	say qq[Output: $total];
}
