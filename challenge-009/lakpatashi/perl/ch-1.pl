#!/usr/bin/perl

use warnings;
use strict;

#part 1

my ($i,$count) = (1,0);
for (;;){
	my $n = $i**2;
	if(uniqDigCount($n) > 4){
		print "$i**2 ==> $n\n";
		$count++;
	}	
	$i++;
	last if $count == 1;
}

sub uniqDigCount{
	my @list = split '', shift;
	my %seen = ();
	my @uniqu = grep { ! $seen{$_} ++ } @list;
	return $#uniqu+1;
}

