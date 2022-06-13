#!/usr/bin/env raku

#`{
Task 2: HOME PRIME
You are given an integer greater than 1.
Write a script to find the home prime of the given number.

In number theory, the home prime HP(n) of an integer n greater than 1 is the
    prime number obtained by repeatedly factoring the increasing concatenation
    of prime factors including repetitions.

REFERENCE
https://en.wikipedia.org/wiki/Home_prime
https://oeis.org/A037274

EXAMPLE
HP(10) = 773,  as
    10 factors as 2×5 yielding HP10(1) = 25,
    25 factors as 5×5 yielding HP10(2) = HP25(1) = 55,
    55 = 5×11 implies HP10(3) = HP25(2) = HP55(1) = 511,
    511 = 7×73 gives HP10(4) = HP25(3) = HP55(2) = HP511(1) = 773, a prime number.

}

sub MAIN(Int $n where $n > 1) {
    say factor($n);
}

sub factor(Int $n, $hpn = '') {
    my Int $f1;
    my Int $f2;
    my $hp = $hpn;
    for 2 ..^ $n -> $i {
        if $n %% $i {
            $f1 = $i;
            $f2 = Int($n/$i);
            last;
        }
    }
    if $f1.defined {
        $hp ~= $f1;
        if $f2.is-prime {
            $hp ~= $f2;
            factor(Int($hp));
        } else {
            factor($f2, $hp);
        }
    } else {
        return $n;
    }
}
