#!/usr/bin/raku

use Math::Primesieve;

our $MAXPRIMES = 100_000;
our $p = Math::Primesieve.new;
our @primes = $p.primes($MAXPRIMES);

say &prime-partition(18,2);
say &prime-partition(19,3);
say &prime-partition(20,4);

multi sub prime-partition (Int $m where $m > 0, Int $n where $n==2) {
	($n > ($m div 2)) && (return ());
	
	my @pp=();
	
	if ($m > $MAXPRIMES) {
		push @primes, $p.primes($MAXPRIMES,$m);
		$MAXPRIMES = $m;		
	}	

	for (@primes) -> $prime {
		if ( ($m - $prime).is-prime ) {
			push @pp, BagHash.new($prime,$m-$prime);
		}
		last if ($prime > ($m div 2));  
	}
	return @pp.unique(as => BagHash, with => &[eqv] );
}


multi sub prime-partition (Int $m where $m > 0, Int $n where $n > 2) {

	($n > ($m div 2)) && (return ());
	
	my @pp=();
	
	if ($m > $MAXPRIMES) {
		push @primes, $p.primes($MAXPRIMES,$m);
		$MAXPRIMES = $m;		
	}	

	for (@primes) -> $prime {
		my @p1 = &prime-partition($m - $prime, $n - 1);

		if (@p1.elems > 0) {
			for (@p1) -> $baghash {
				$baghash.add($prime);
			}
		}
		@pp.append(@p1);
		last if ($prime > ($m div 3));	
	}
	return @pp.unique(as => BagHash, with => &[eqv] );
}
