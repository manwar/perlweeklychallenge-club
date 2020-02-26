#!/usr/bin/env perl
use strict;
use warnings;

my $target=200;
my @moves;
my $d=$target;
while ($d!=1) {
	if ($d%2==0) {
		push @moves, "Double";
		$d/=2;
	}
	else {
		push @moves, "Add 1";
		$d-=1;
	}
}
my $t=1;
printf "Start: \t\t%3d\n",$t;
for (reverse @moves) {
	$t+=1 if /^A/;
	$t*=2 if /^D/;
	printf "Move:\t%s:\t%3d\n",$_, $t;
}
