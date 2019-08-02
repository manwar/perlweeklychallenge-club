#!/usr/bin/env perl
#
use strict;
use warnings;
use Getopt::Long;
use v5.26;

my @lines=<STDIN>;

my @words;

for (@lines) {
	for ( split " ", $_, ) {
		push @words, $_, " ";
	}
}
my $col=80;
GetOptions("col=i" => \$col );


while (@words) {
	state $rem = $col;
	my $w =$words[0];
	if (length $w > $col) {
		print $w,"\n";
		shift @words;
		shift @words;
		next;
	}
	if (length $w <= $rem) {
		print $w;
		$rem-=length $w;
		shift @words;
	}
	else {
			print "\n";
			shift @words if $words[0] eq " ";
			$rem=$col;
	}
}
