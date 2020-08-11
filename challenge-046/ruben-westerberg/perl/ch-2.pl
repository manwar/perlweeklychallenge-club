#!/usr/bin/env perl
use strict;
use warnings;
use v5.26;
my @doors=(0) x 500;
$doors[$_]= $doors[$_]?0:1 for 0..499;
for my $i (2..500) {
	my $j=$i;
	while ($j <= 500) {
		$doors[$j-1]=$doors[$j-1]?0:1;
		$j+=$i;
	}
}
print @doors;
