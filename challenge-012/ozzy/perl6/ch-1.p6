#!/usr/bin/env perl6

my @primes = lazy gather {                              # Define a lazy array with prime numbers
    my $a=0;
    loop { take $a if (++$a).is-prime };
}

for 1..100 -> $i {
    my $Euclid = ([*] @primes[0..($i-1)]) +1;           # Calculate the $i-th Euclid number.
    say "E_$i = $Euclid";                               # For inspection: show the numbers...

    if ! $Euclid.is-prime {                             # Print number and exit if it is not-prime.
        say "$Euclid is not prime!";
        exit;
    }
}
