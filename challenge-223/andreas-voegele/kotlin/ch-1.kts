#!/usr/bin/env kotlin

/*
 * You are given a positive integer, $n.  Write a script to find the total
 * count of primes less than or equal to the given integer.
 */

fun isPrime(n: Long) =
    n > 1 && (2 until n).none { n % it == 0L }

fun primeNumbers(n: Long): List<Long> =
    (2..n).filter { isPrime(it) }

println(primeNumbers(10L).size);
println(primeNumbers(1L).size);
println(primeNumbers(20L).size);
