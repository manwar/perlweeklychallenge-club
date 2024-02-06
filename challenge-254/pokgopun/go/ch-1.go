//# https://theweeklychallenge.org/blog/perl-weekly-challenge-254/
/*#

Task 1: Three Power

Submitted by: [47]Mohammad S Anwar
     __________________________________________________________________

   You are given a positive integer, $n.

   Write a script to return true if the given integer is a power of three
   otherwise return false.

Example 1

Input: $n = 27
Output: true

27 = 3 ^ 3

Example 2

Input: $n = 0
Output: true

0 = 0 ^ 3

Example 3

Input: $n = 6
Output: false

Task 2: Reverse Vowels
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"math"
	"os"

	"github.com/google/go-cmp/cmp"
)

func isPowerOfThree(n int) bool {
	r := int(math.Pow(float64(n), 1./3))
	return r*r*r == n || (r+1)*(r+1)*(r+1) == n
}

func main() {
	for _, data := range []struct {
		input  int
		output bool
	}{
		{27, true},
		{0, true},
		{6, false},
	} {
		io.WriteString(os.Stdout, cmp.Diff(isPowerOfThree(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
