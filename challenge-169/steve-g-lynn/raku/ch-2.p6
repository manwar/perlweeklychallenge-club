#!/usr/bin/raku

#-- generate 1st 20 achilles numbers A where
#-- A = (a ** k) * (b ** m) * j
#-- a,b prime, k,m,j, uint
#-- and r=A**(1/p) is not a uint for p uint

use Prime::Factor;

my ($a,@achilles);

@achilles=();

A: for (2 .. 10000) -> $a {
	my @factor = prime-factors ($a);
	
	my %factor=();

	for (@factor) -> $factor {
		%factor{$factor}++;
	}
	
	(keys %factor).elems > 1 || next;
	
	for (keys %factor) -> $key {
		(%factor{$key} < 2) && next A;
	}
	
	
	for (2,3) -> $i { #-- check square and cube roots
			#-- other powers not needed for 1st 20
		my $root = $a ** (1/$i);
		
		(abs($root - round($root)) > 0.00001) || next A;
		# checking for integer cube roots is buggy, like perl5 		
	}
		 
	push @achilles, $a;
	@achilles >= 20 && last;
}

say @achilles;



