//# https://theweeklychallenge.org/blog/perl-weekly-challenge-345/
/*#

Task 2: Last Visitor

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an integer array @ints where each element is either a
   positive integer or -1.

   We process the array from left to right while maintaining two lists:
@seen: stores previously seen positive integers (newest at the front)
@ans: stores the answers for each -1

   Rules:
If $ints[i] is a positive number -> insert it at the front of @seen
If $ints[i] is -1:

   Let $x be how many -1s in a row we’ve seen before this one.

   If $x < len(@seen) -> append seen[x] to @ans

   Else -> append -1 to @ans

   At the end, return @ans.

Example 1

Input: @ints = (5, -1, -1)
Output: (5, -1)

@seen = (5)
First  -1: @ans = (5)
Second -1: @ans = (5, -1)

Example 2

Input: @ints = (3, 7, -1, -1, -1)
Output: (7, 3, -1)

@seen = (3, 7)
First  -1: @ans = (7)
Second -1: @ans = (7, 3)
Third  -1: @ans = (7, 3, -1)

Example 3

Input: @ints = (2, -1, 4, -1, -1)
Output: (2, 4, 2)

Example 4

Input: @ints = (10, 20, -1, 30, -1, -1)
Output: (20, 30, 20)

Example 5

Input: @ints = (-1, -1, 5, -1)
Output: (-1, -1, 5)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 2nd November
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

type ints []int

func (in ints) process() ints {
	var seen, ans ints
	x := 0
	for _, v := range in {
		if v == -1 {
			if x < len(seen) {
				ans = append(ans, seen[len(seen)-1-x])
			} else {
				ans = append(ans, -1)
			}
			x++
		} else {
			x = 0
			seen = append(seen, v)
		}
	}
	return ans
}

func main() {
	for _, data := range []struct {
		input, output ints
	}{
		{ints{5, -1, -1}, ints{5, -1}},
		{ints{3, 7, -1, -1, -1}, ints{7, 3, -1}},
		{ints{2, -1, 4, -1, -1}, ints{2, 4, 2}},
		{ints{10, 20, -1, 30, -1, -1}, ints{20, 30, 20}},
		{ints{-1, -1, 5, -1}, ints{-1, -1, 5}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
