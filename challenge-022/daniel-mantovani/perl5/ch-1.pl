# Write a script to print first 10 Sexy Prime Pairs.
# Sexy primes are prime numbers that differ from each other by 6.
# For example, the numbers 5 and 11 are both sexy primes, because 11 - 5 = 6.
# The term “sexy prime” is a pun stemming from the Latin word for six: sex.
# For more information, please checkout wiki page.

use strict;
use warnings;

# just reusing comments and code from previous challenges:

# we will need a function to test primality. As this is a
# challenge and so far not very concerned about performance,
# I will go for the "regex" primality test.
# you can find more information at
# https://iluxonchik.github.io/regular-expression-check-if-number-is-prime/
# but let just say that to test if some n number is prime, we build a string
# of n characters (with <char> x n), and let the regex engine try to divide
# it in more than one equal parts of at least 2 chars. So if
# we are not successful on that it means it is prime.
# we use a digit as the char as we don't have to quote it. Any digit will
# do, so we just pick "7"

sub is_prime {
    return ( 7 x shift ) !~ /^(77+)\1+$/;
}

# note that we should ensure that argument is greater than 1 before
# calling this sub, because it will uncorrectly return 1 for both 0 and 1

my $q = shift // 10; # this is the amount of sexy primes we are printing

my $candidate = 3; # first number that makes sense to check

while ($q) { # i.e. while $q is > 0
    if (is_prime($candidate) && is_prime($candidate+6)) {
        printf "Found sexy primes: %u and %u\n", $candidate, $candidate+6;
        $q--;   # one less to go
    }
    $candidate+= 2; # skip even candidates as they dont make sense
}
