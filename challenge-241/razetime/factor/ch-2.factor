USING: kernel sequences math.primes.factors sorting tools.test ;
IN: pwc-341
: ch-2 ( seq -- seq' ) [ factors length ] sort-by ;

{ { 11 4 8 27 } } [ { 11 8 27 4 } ch-2 ] unit-test
