#!/usr/bin/perl

use strict;
use warnings;

my @list = ("unicode", "xml", "raku", "perl");
my $count = 0;

foreach my $elements (@list){
	$elements = lc($elements);
	if ($elements =~ /^[aeiou]/i || $elements =~ /[aeiou]$/i){
		$count++;
	}
}

print $count;
