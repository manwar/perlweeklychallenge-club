#!/usr/bin/env perl6

# Task: Write a script to print first 10 Sexy Prime Pairs. Sexy primes are prime numbers that differ from each other by 6.

say (1 .. Inf).map( { $_, $_+6 } ).flat.grep( { $^a.is-prime && $^b.is-prime } ).head(10).join("\n");
