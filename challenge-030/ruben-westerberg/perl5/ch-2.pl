#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw<sum>;

my %s;
for (2,4,6,8,10) {
	my $e=$_;
	my $r=12-$e;
	for (1..$r-1) {
		my @val=sort($e,$_,$r-$_);
		my $key=join ",", @val;
		$s{$key}=\@val if sum(@val) == 12;
	} 
} 

for (sort keys %s) {
	print join(",", @{$s{$_}}),"\n";
}
