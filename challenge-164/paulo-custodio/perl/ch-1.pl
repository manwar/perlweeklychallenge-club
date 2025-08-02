#!/usr/bin/env perl

# Challenge 164
#
# Task 1: Prime Palindrome
# Submitted by: Mohammad S Anwar
#
# Write a script to find all prime numbers less than 1000, which are also
# palindromes in base 10. Palindromic numbers are numbers whose digits are the
# same in reverse. For example, 313 is a palindromic prime, but 337 is not, even
# though 733 (337 reversed) is also prime.

use Modern::Perl;

sub is_prime {
    my($n) = @_;
    return 0 if $n <= 1;
    return 1 if $n <= 3;
    return 0 if ($n % 2)==0 || ($n % 3)==0;
    for (my $i = 5; $i*$i <= $n; $i += 6) {
        return 0 if ($n % $i)==0 || ($n % ($i+2))==0;
    }
    return 1;
}

sub next_prime {
    my($n) = @_;
    return 2 if $n <= 1;
    my $p = $n;
    1 while !is_prime(++$p);
    return $p;
}

sub primes {
    my($n) = @_;
    my $p = 2;
    my @primes;
    while ($p <= $n) {
        push @primes, $p;
        $p = next_prime($p);
    }
    return @primes;
}

sub palindrome_primes {
    my($n) = @_;
    my @primes=primes($n);
    return grep {$_ eq reverse $_} @primes;
}

say join ", ", palindrome_primes(shift);
