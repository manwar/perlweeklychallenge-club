#!/bin/env perl6

my $euc = (^∞).grep: *.is-prime;

my $prod = 1;
for 0 .. ∞ -> Int $i {
    $prod *= $euc[$i];
    print $euc[$i], ' ';
    last unless ($prod + 1).is-prime;

    LAST { say $prod + 1 }
}
