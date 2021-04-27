#!/usr/bin/perl

use warnings;
use strict;
use Data::Dumper;
use List::Util qw(sum);
use feature qw(switch);

#part 1
my $max = 1000;
my @seq = (0)x$max;
vanEckSeq();	# building pre compiled seq

print "@seq[0..10]\n";
sub vanEckSeq{
	for my $i (0..$max-1){
		for my $j (reverse 0..$i-1){
			if($seq[$j] == $seq[$i]){
				$seq[$i+1] = $i-$j;
				last;
			}	
		}
	}
}
