use v5.38;
my @primes = (2);

sub is_prime($num) {
    for my $p (@primes) {
	if ($p < $num) {
	    return 0 if ($num % $p == 0);
	}
	else {
	    last;
	}
    }
    1
}

sub fill_more_primes($lim) {
    my $i = $primes[$#primes];
    while ($primes[$#primes] < $lim) {
	$i++;
	my $cnt = scalar grep { $i % $_ == 0 } @primes;
	push @primes, $i if ($cnt == 0);
    }
}

sub fill_primes_bycnt($num) {
    my $i = 2;
    while (@primes < $num) {
	$i++;
	my $cnt = scalar grep { $i % $_ == 0 } @primes;
	push @primes, $i if ($cnt == 0);
    }
}

sub primorial($n) {
    my $p = 1;
    while ($n > 0) {
	$n--;
	$p *= $primes[$n];
    }
    $p
}

sub proc($n) {
    fill_primes_bycnt($n);
    my @primorials = map primorial($_), (1 .. $n);
    fill_more_primes(sqrt $primorials[$#primorials]);
    say "Euclid numbers:";
    foreach my $prim (@primorials) {
	if (!is_prime($prim+1)) {
	    say $prim+1," <- not prime!";
	    last;
	}
	say $prim+1;
    }
}

proc(7);

