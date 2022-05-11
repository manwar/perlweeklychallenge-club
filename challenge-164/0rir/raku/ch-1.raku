#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6.d;

=begin comment
Task 1: Prime Palindrome
Submitted by: Mohammad S Anwar
Find all prime numbers less than 1000, which are also palindromes in base
10. Palindromic numbers are numbers whose digits are the same in reverse.
=end comment

say palindromic-primes( 1 ... 1000  );
say palindromic-primes( 1 .. 1000);
say palindromic-primes( ( 1 ... 1000 ).List );
say palindromic-primes( ( 1 ... 1000 ).Array );
say palindromic-primes( 2  );

sub palindromic-primes( Any $x --> Seq ) {
    grep { .flip ~~ $_ }, grep { .is-prime }, $x.Seq ;
}
