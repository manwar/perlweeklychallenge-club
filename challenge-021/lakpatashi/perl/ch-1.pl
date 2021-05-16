#!/usr/bin/perl

use warnings;
use strict;
use Data::Dumper;
use List::Util qw(max min sum);
use feature qw(switch);
use Memoize;
memoize qw( factorial );
#part 1
my $e;
my $iterLimit = 100;
for my $i (0..$iterLimit){
	$e += exponTerm( $i );	
	if( $i == $iterLimit ){
		print "value of e after $iterLimit iteration => $e\n" 
	}
}

sub exponTerm{
	my ($n) = @_;
	return 1/factorial($n);
}

sub factorial{
	my ($n) = @_;
	if( $n < 2 ){
		return 1;
	}
	return $n * factorial($n-1);
}


