#!/usr/bin/env perl
use strict;
use warnings;
use List::Util;

for (100..999) {
	my @conSubs=contiguousSubs("$_");
	if (@conSubs == List::Util::uniq @conSubs) {
		print "$_ is Colourful\n";
	}
}

sub contiguousSubs {
	my ($string)=@_;
	my $len= length $string;
	map { 
		my $subLen=$_; 
		map { 
			my @d=split "",substr ($string, $_, $subLen);
			List::Util::reduce {$a * $b} @d} 
			0..$len-$subLen
		}
	1..$len
}	
