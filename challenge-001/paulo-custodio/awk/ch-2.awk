#!/usr/bin/env gawk

# Perl Weekly Challenge 001 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-001/

BEGIN {
    num = ARGV[1] ? ARGV[1] : 20;
    for (i=1; i<=num; i++)
        print (i%15)==0 ? "fizzbuzz" : (i%3)==0 ? "fizz" : (i%5)==0 ? "buzz" : i;
    exit 0;
}
