#!/usr/bin/env perl
use warnings;
use strict;
use List::Util;
use v5.26;
my $limit=15;
my %boxes;
@boxes{qw<R B G Y P>}=({c=>1,w=>1,},{c=>2, w=>1},{c=>2,w=>2},{c=>4,w=>12},{c=>10,w=>4});
 $boxes{$_}{r}=$boxes{$_}{c}/$boxes{$_}{w} for keys %boxes;

my @b= sort { $boxes{$b}{r} <=> $boxes{$a}{r}} keys %boxes;

my @selected;
my $totalWeight;
my $totalCost;
while (@b) {
	state $rem=$limit;
	my $tmp=$rem - $boxes{$b[0]}{w};
	if ($tmp < 0 ) {
		shift @b;
		next;
	}
	push @selected, $b[0];
	$rem=$tmp;
}
print "Selected boxes: @selected\n";
print "Total cost: ". List::Util::sum(map {$$_{c}} @boxes{@selected})."\n";
print "Total weight ". List::Util::sum(map {$$_{w}} @boxes{@selected})."\n";

