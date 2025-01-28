//# https://theweeklychallenge.org/blog/perl-weekly-challenge-306/
/*#

Task 2: Last Element

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a array of integers, @ints.

   Write a script to play a game where you pick two biggest integers in
   the given array, say x and y. Then do the following:
a) if x == y then remove both from the given array
b) if x != y then remove x and replace y with (y - x)

   At the end of the game, there is at most one element left.

   Return the last element if found otherwise return 0.

Example 1

Input: @ints = (3, 8, 5, 2, 9, 2)
Output: 1

Step 1: pick 8 and 9 => (3, 5, 2, 1, 2)
Step 2: pick 3 and 5 => (2, 2, 1, 2)
Step 3: pick 2 and 1 => (1, 2, 2)
Step 4: pick 2 and 1 => (1, 2)
Step 5: pick 1 and 2 => (1)

Example 2

Input: @ints = (3, 2, 5)
Output: 0

Step 1: pick 3 and 5 => (2, 2)
Step 2: pick 2 and 2 => ()
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 2^nd January
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"slices"

	"github.com/google/go-cmp/cmp"
)

type ints []int

func (is ints) lstelm() int {
	for {
		l := len(is)
		switch l {
		case 0:
			return 0
		case 1:
			return is[0]
		}
		slices.Sort(is)
		d := is[l-2] - is[l-1]
		if d == 0 {
			is = is[:l-2]
			continue
		}
		if d < 0 {
			d *= -1
		}
		is[l-2] = d
		is = is[:l-1]
	}
}

func main() {
	for _, data := range []struct {
		input  ints
		output int
	}{
		{ints{3, 8, 5, 2, 9, 2}, 1},
		{ints{3, 2, 5}, 0},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.lstelm(), data.output)) // blank if ok, otherwise show the difference
	}
}
