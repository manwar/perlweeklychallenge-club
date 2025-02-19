//# https://theweeklychallenge.org/blog/perl-weekly-challenge-309/
/*#

Task 2: Min Diff

Submitted by: [41]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to find the minimum difference between any two elements.

Example 1

Input: @ints = (1, 5, 8, 9)
Output: 1

1, 5 => 5 - 1 => 4
1, 8 => 8 - 1 => 7
1, 9 => 9 - 1 => 8
5, 8 => 8 - 5 => 3
5, 9 => 9 - 5 => 4
8, 9 => 9 - 8 => 1

Example 2

Input: @ints = (9, 4, 1, 7)
Output: 2

9, 4 => 9 - 4 => 5
9, 1 => 9 - 1 => 8
9, 7 => 9 - 7 => 2
4, 1 => 4 - 1 => 3
4, 7 => 7 - 4 => 3
1, 7 => 7 - 1 => 6
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 23^rd February
   2025.
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

func diff(a, b int) int {
	return max(a, b) - min(a, b)
}

type ints []int

func (is ints) minDiff() int {
	l := len(is) - 1 // last index
	mn := diff(is[l], is[l-1])
	for i := range l - 2 {
		j := i + 1
		for j <= l {
			mni := diff(is[i], is[j])
			if mn > mni {
				mn = mni
			}
			j++
		}
	}
	return mn
}

func main() {
	for _, data := range []struct {
		input  ints
		output int
	}{
		{ints{1, 5, 8, 9}, 1},
		{ints{9, 4, 1, 7}, 2},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.minDiff(), data.output)) // blank if ok, otherwise show the difference
	}
}
