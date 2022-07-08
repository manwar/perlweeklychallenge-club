#!/usr/bin/raku

#real	0m17.645s
#user	0m17.812s
#sys	0m0.232s

use Math::Primesieve;

our $p=Math::Primesieve.new();
our $MAXPRIME=100_000;
our @primes=$p.primes($MAXPRIME); #-- save a few primes to avoid repeated recursive calls to $p.primes

multi sub prime-partition (Int $m where ($m > 0), Int $n where ($n==2)) {
#-- for n = 2: for each prime i, check if m-i is also prime.
	($m < 2) && return ();
	if ($m > $MAXPRIME) { 
		push @primes,$p.primes($MAXPRIME, $m);
		$MAXPRIME=$m;
	}

	my @pp=();

	for (@primes) -> $i {
		($m - $i).is-prime && (append @pp,(BagHash.new: $i, $m - $i) );
		last if $i > $m div 2;
	}
	@pp = @pp.unique(as => BagHash, with => &[eqv]);
	return @pp;
}

multi sub prime-partition (Int $m where ($m > 0), Int $n where ( $n > 2) ) {
#-- this recursive approach is fast when n == 3, even for large m
# but speed worsens exponentially with each further increment in n. 
# Computations such as m >= 1000,n >= 4 are prohibitively slow.
# For smaller m, say m = 200, n is the constraint. n >= 5 is 
# too slow for m >= 200 (e.g., time goes up to 2+m vs current ~18s 
# if I change prime-partition(200,5) to prime-partition(200,6) 
# in this script).
# 

	($n > ($m div 2)) && return ();

	($m < 2) && return ();

	if ($m > $MAXPRIME) { 
		push @primes,$p.primes($MAXPRIME, $m);
		$MAXPRIME=$m;
	}

	my @pp=();


	PRIMES: for (@primes) -> $i {
		my @p1 = &prime-partition($m - $i, $n - 1);
		if (@p1) { for (@p1) -> $v {$v.add($i)}; @pp.append(@p1);}
		last PRIMES if $i > $m div $n;
	}
	
	@pp = @pp.unique(as => BagHash, with => &[eqv]);

	return @pp;
}


say &prime-partition(18,2);
#(BagHash(13 5) BagHash(11 7))

say &prime-partition(19,3);
#(BagHash(13 3(2)) BagHash(11 3 5) BagHash(5 7(2)))


say &prime-partition(200,3);
#(BagHash(193 2 5) BagHash(191 2 7) BagHash(17 181 2) BagHash(179 19 2)
# BagHash(167 2 31) BagHash(157 2 41) BagHash(151 2 47) BagHash(139 2 59)
# BagHash(137 2 61) BagHash(131 2 67) BagHash(127 2 71) BagHash(109 2 89)
# BagHash(101 2 97))

say &prime-partition(200,4);
#[BagHash(193 2(2) 3) BagHash(191 2(2) 5) BagHash(17 179 2(2)) 
#BagHash(173 2(2) 23) BagHash(167 2(2) 29) BagHash(149 2(2) 47) 
#BagHash(137 2(2) 59) BagHash(113 2(2) 83) BagHash(107 2(2) 89) 
# ...


say &prime-partition(1000,3);
#[BagHash(2 7 991) BagHash(2 31 967) BagHash(2 61 937) BagHash(2 79 919)
#BagHash(139 2 859) BagHash(2 211 787) BagHash(2 229 769) BagHash(2 241 757)
#BagHash(2 271 727) BagHash(2 307 691) BagHash(2 337 661) 
# ...

say &prime-partition(10000,3);
#[BagHash(2 31 9967) BagHash(2 67 9931) BagHash(2 97 9901) 
#BagHash(127 2 9871) BagHash(139 2 9859) BagHash(181 2 9817) 
#BagHash(2 211 9787) BagHash(2 229 9769) BagHash(2 277 9721) 
# ...

say &prime-partition(80000,3);
#[BagHash(11 2 79987) BagHash(19 2 79979) BagHash(2 31 79967) 
#BagHash(2 59 79939) BagHash(2 79901 97) BagHash(109 2 79889) 
# BagHash(131 2 79867) BagHash(137 2 79861) BagHash(151 2 79847)
# ...

say &prime-partition(200,5);
#[BagHash(191 2(3) 3) BagHash(13 181 2(3)) BagHash(163 2(3) 31) 
#BagHash(157 2(3) 37) BagHash(151 2(3) 43) BagHash(127 2(3) 67) 
#BagHash(2(3) 97(2)) BagHash(11 181 2 3(2)) BagHash(13 179 2 3(2))
# ...




