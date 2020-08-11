#!/usr/bin/env perl
use strict;
use warnings;
use List::Util;

my %letters;
while (<>) {
	chomp;
	for (split "") {
		$letters{$_}++ if /[a-zA-Z]/;
	}
}

my $m=List::Util::max map {length $letters{$_}} keys %letters;
for (sort keys %letters) {
	printf "%s: %".$m."s\n", $_, $letters{$_};
}

