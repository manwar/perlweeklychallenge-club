#!/usr/bin/env raku

sub MAIN(Int $m, Int $n) {
    my @divisors = ();
    for 1..floor($m/2)+1 {
	@divisors.append($_) if ($m % $_ == 0) && ($_ % 10 == $n);
    }

    say "Found {@divisors.elems} divisors of $m that have the last digit $n: {@divisors}";
}
