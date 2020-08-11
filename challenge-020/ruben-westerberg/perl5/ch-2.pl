#!/usr/bin/env perl
use strict;
use warnings;
use v5.26;
use List::Util qw<sum>;

my ($n1,$n2)=(1,0);
while ( 1 ) {
	$n2=proper(++$n1);
	my $n1test=proper($n2);
	next if $n2 == $n1;
	last if $n1test == $n1;
}

sub proper {
	my $n=shift; 
	sum 0, map  { $n % $_ == 0 ? $_: () } 1..$n-1  ;
};
printf "Smallest Amicable Numbers: ($n1, $n2)\n";

