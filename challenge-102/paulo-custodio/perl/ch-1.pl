#!/usr/bin/perl

# TASK #1 › Rare Numbers
# Submitted by: Mohammad S Anwar
# 
# You are given a positive integer $N.
# 
# Write a script to generate all Rare numbers of size $N if exists. Please 
# checkout the page for more information about it.
# Examples
# 
# (a) 2 digits: 65
# (b) 6 digits: 621770
# (c) 9 digits: 281089082

use strict;
use warnings;
use 5.030;

my($N) = @ARGV or die "Usage: ch-1.pl N\n";
print_rare($N);

sub print_rare {
	my($n) = @_;
	for my $r (10**($n-1) .. 10**($n)-1) {
		my $r1=0+(join('', reverse split('', $r)));
		if (perfect_square($r+$r1)) {
			if ($r>=$r1) {
				if (perfect_square($r-$r1)) {
					say $r;
				}
			}
		}
	}
}

sub perfect_square {
	my($n) = @_;
	my $x = sqrt($n);
	return ($x == int($x));
}
