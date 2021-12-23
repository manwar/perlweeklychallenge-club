#!/usr/bin/env raku

sub sieve-of-atkin(Int $limit --> List){
    my @sieve;
    my @prime-list = (2,3);
    
    my $x = 1;
    while $x ** 2 < $limit {
	my $y = 1;
	while $y ** 2 < $limit {

	    my $n = 4 * $x ** 2 + $y ** 2;
	    
	    if $n <= $limit && ($n % 12 == 1 || $n % 12 == 5) {
		@sieve[$n] = @sieve[$n] ?? False !! True;
	    }

	    $n = 3 * $x ** 2 + $y ** 2;
	    if $n <= $limit && $n % 12 == 7 {
		@sieve[$n] = @sieve[$n] ?? False !! True;
	    }

	    $n = (3 * $x ** 2 ) - $y ** 2;
	    if $n <= $limit && $x > $y && $n % 12 == 11 {
		@sieve[$n] = @sieve[$n] ?? False !! True;
	    }
	    $y++;
	}
	$x++;
    }
    # Mark all multiples of squares as non-prime
    my $r = 5;
    while $r ** 2 < $limit {
	if @sieve[$r] {
	    loop ( my $i = $r**2; $i < $limit; $i += $r**2 ) {
		@sieve[$i] = False;
	    }
	}
	$r++;
    }

    for @sieve.kv -> $index, $is-prime {
	@prime-list.append($index) if $is-prime;
    }

    return @prime-list;
}


sub MAIN() {
    my @prime-list := sieve-of-atkin(100);
    my @combinations = (|@prime-list xx 2 ).flat.combinations(2);
    
    my %semi-primes;
    for @combinations -> @comb {
	my $candidate = @comb[0]*@comb[1];
	%semi-primes{$candidate} = (@comb[0],@comb[1]) if $candidate < 100;
    }
    
    for %semi-primes.keys.sort {
	say "$_ is Semiprime as $_ = {%semi-primes{$_}.join(' x ')}";
    }
    
}
