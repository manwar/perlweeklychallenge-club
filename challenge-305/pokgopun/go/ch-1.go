//# https://theweeklychallenge.org/blog/perl-weekly-challenge-305/
/*#

Task 1: Binary Prefix

Submitted by: [40]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a binary array.

   Write a script to return an array of booleans where the partial binary
   number up to that point is prime.

Example 1

Input: @binary = (1, 0, 1)
Output: (false, true, true)

Sub-arrays (base-10):
(1): 1 - not prime
(1, 0): 2 - prime
(1, 0, 1): 5 - prime

Example 2

Input: @binary = (1, 1, 0)
Output: (false, true, false)

Sub-arrays (base-10):
(1): 1 - not prime
(1, 1): 3 - prime
(1, 1, 0): 6 - not prime

Example 3

Input: @binary = (1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1)
Output: (false, true, true, false, false, true, false, false, false, false, fals
e, false, false, false, false, false, false, false, false, true)

Task 2: Alien Dictionary
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"math/big"
	"os"

	"github.com/google/go-cmp/cmp"
)

type bools []bool

type bin int

func (b bin) isprime() bool {
	return big.NewInt(int64(b)).ProbablyPrime(0)
}

type bins []bin

func (bs bins) bp() bools {
	s := make(bools, len(bs))
	c := bs[0]
	s[0] = c.isprime()
	for i, v := range bs[1:] {
		c = c*2 + v
		s[i+1] = c.isprime()
	}
	return s
}

func main() {
	for _, data := range []struct {
		input  bins
		output bools
	}{
		{bins{1, 0, 1}, bools{false, true, true}},
		{bins{1, 1, 0}, bools{false, true, false}},
		{bins{1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1}, bools{false, true, true, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, true}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.bp(), data.output)) // blank if ok, otherwise show the difference
	}
}
