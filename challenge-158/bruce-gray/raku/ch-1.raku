sub up-thru ( @a, $n ) { gather for @a { $_ <= $n ?? .take !! last } }

constant @additive_primes = grep { .is-prime and .comb.sum.is-prime }, ^Inf;

say @additive_primes.&up-thru(100).join: ', ';
