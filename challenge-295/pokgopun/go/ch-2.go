//# https://theweeklychallenge.org/blog/perl-weekly-challenge-295/
/*#

Task 2: Jump Game

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to find the minimum number of jumps to reach the last
   element. $ints[$i] represents the maximum length of a forward jump from
   the index $i. In case last element is unreachable then return -1.

Example 1

Input: @ints = (2, 3, 1, 1, 4)
Output: 2

Jump 1 step from index 0 then 3 steps from index 1 to the last element.

Example 2

Input: @ints = (2, 3, 0, 4)
Output: 2

Example 3

Input: @ints = (2, 0, 0, 4)
Output: -1
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 17th November
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

func (is ints) jg() int {
	l := len(is)
	if l == 1 {
		return 0
	}
	count := -1
	for i := min(is[0], l-1); i > 0; i-- {
		n := is[i:].jg()
		if n == -1 {
			continue
		}
		if count == -1 {
			count = 1 + n
		} else {
			count = min(count, 1+n)
		}
	}
	return count
}

func main() {
	for _, data := range []struct {
		input  ints
		output int
	}{
		{ints{2, 3, 1, 1, 4}, 2},
		{ints{2, 3, 0, 4}, 2},
		{ints{2, 0, 0, 4}, -1},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.jg(), data.output)) // blank if ok, otherwise show the difference
	}
}
