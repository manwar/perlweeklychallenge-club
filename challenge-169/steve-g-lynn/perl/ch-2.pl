#!/usr/bin/perl

#-- generate 1st 20 achilles numbers A where
#-- A = (a ** k) * (b ** m) * j
#-- a,b prime, k,m,j, uint
#-- and r=A**(1/p) is not a uint for p uint

use Math::Prime::Util qw(factor);

my ($a,@achilles);

@achilles=();

A: for $a (2 .. 10000) {
	my @factor = factor ($a);
	
	my %factor=();
	
	foreach $factor (@factor){
		$factor{$factor}++;
	}
	
	scalar (keys %factor) > 1 || next;
	
	foreach (keys %factor){
		($factor{$_} < 2) && next A;
	}
	
	for $i (2,3) { #-- check square and cube roots
			#-- other powers not needed for 1st 20
		my $root = $a ** (1/$i);		
		($root =~ /\./) || next A; 
		# $root == int($root) fails for cube roots (bad bug!)
		# so use a regex instead (look for decimal point)	
	}
	 
	push @achilles, $a;
	@achilles >= 20 && last;
}

foreach (sort{$a<=>$b} @achilles){
	print "$_ ";
}

print "\n";


1;

