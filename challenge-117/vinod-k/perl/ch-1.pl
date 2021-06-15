#!/usr/bin/perl

use strict; use warnings;

use Data::Dumper;

my %hash;

while(<DATA>){
	chomp (my $line = $_);
	
	my @contents = split(/, /, $line);
	
	$hash{$contents[0]} = 1;
}

foreach my $element (1..15){
	unless( exists $hash{$element}){
		print "$element -> missing...\n";
	}
}

__DATA__
11, Line Eleven
1, Line one
9, Line Nine
13, Line Thirteen
2, Line two
6, Line Six
8, Line Eight
10, Line Ten
7, Line Seven
4, Line Four
14, Line Fourteen
3, Line three
15, Line Fifteen
5, Line Five
