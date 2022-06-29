/*
https://theweeklychallenge.org/blog/perl-weekly-challenge-171/
Task 1: Abundant Number
Submitted by: Mohammad S Anwar
Write a script to generate first 20 Abundant Odd Numbers.

According to wikipedia,


A number n for which the sum of divisors σ(n) > 2n, or, equivalently, the sum of proper divisors (or aliquot sum) s(n) > n.


For example, 945 is the first Abundant Odd Number.

Sum of divisors:
1 + 3 + 5 + 7 + 9 + 15 + 21 + 27 + 35 + 45 + 63 + 105 + 135 + 189 + 315 = 975
*/
package main

import (
	"fmt"

	"github.com/pokgopun/go/abundant"
)

func main() {
	fmt.Println(abundant.OddAbundant(20))
}
