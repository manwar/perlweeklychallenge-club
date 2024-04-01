//# https://theweeklychallenge.org/blog/perl-weekly-challenge-262/
/*#

Task 2: Count Equal Divisible

Submitted by: [47]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints and an integer $k.

   Write a script to return the number of pairs (i, j) where
a) 0 <= i < j < size of @ints
b) ints[i] == ints[j]
c) i x j is divisible by k

Example 1

Input: @ints = (3,1,2,2,2,1,3) and $k = 2
Output: 4

(0, 6) => ints[0] == ints[6] and 0 x 6 is divisible by 2
(2, 3) => ints[2] == ints[3] and 2 x 3 is divisible by 2
(2, 4) => ints[2] == ints[4] and 2 x 4 is divisible by 2
(3, 4) => ints[3] == ints[4] and 3 x 4 is divisible by 2

Example 2

Input: @ints = (1,2,3) and $k = 1
Output: 0
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 31st March
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type ints []int

func (is ints) ced(k int) int {
	c := 0
	l := len(is)
	for i := 0; i < l-1; i++ {
		for j := i + 1; j < l; j++ {
			if is[i] == is[j] && (i*j)%2 == 0 {
				c++
			}
		}
	}
	return c
}

func main() {
	for _, data := range []struct {
		nums      ints
		k, output int
	}{
		{ints{3, 1, 2, 2, 2, 1, 3}, 2, 4},
		{ints{1, 2, 3}, 1, 0},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.nums.ced(data.k), data.output)) // blank if ok, otherwise show the difference
	}
}
