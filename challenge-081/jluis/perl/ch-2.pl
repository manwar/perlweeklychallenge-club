#!/usr/bin/env perl 
use strict;
use warnings;
use 5.010;
say(<<USAGE)  and exit  if @ARGV;
finds the frequency of all the words of input

ch-2.pl must be called without any parameters it operates on a file caled input on the current dir

USAGE

open(my $input,'<','input') or die "Can't open input: $!";

my %freq;
while(<$input>){
	chomp;
	s/\.|"|\(|\)|,|'s|--/ /g;
	while (/(\w+)/g) {
		$freq{$1} = 0 unless defined $freq{$1};
		$freq{$1} += 1;
	}
}

my @results;
for my $key (sort keys %freq) {
    $results[$freq{$key}] = "$freq{$key}" unless defined $results[$freq{$key}];
    $results[$freq{$key}] .= " $key";
}

defined($_) and say for @results;
