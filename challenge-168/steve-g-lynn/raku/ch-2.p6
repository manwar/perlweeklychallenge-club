#!/usr/bin/raku

#time (bash command): 
#real	0m0.312s
#user	0m0.382s
#sys	0m0.054s


use Prime::Factor;

say homeprime(10);
#773
say homeprime(16);
#31636373
say homeprime(20);
#3318308475676071413

#-- sub for home prime

sub homeprime(Int $n where ($n > 1)) returns Int {
	$n.Int.is-prime && return $n;
	return homeprime(([~] prime-factors($n)).Int);
}


