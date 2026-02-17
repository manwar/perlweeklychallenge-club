//# https://theweeklychallenge.org/blog/perl-weekly-challenge-361/
/*#

Task 2: Find Celebrity

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a binary matrix (m x n).

   Write a script to find the celebrity, return -1 when none found.

     A celebrity is someone, everyone knows and knows nobody.

Example 1

Input: @party = (
            [0, 0, 0, 0, 1, 0],  # 0 knows 4
            [0, 0, 0, 0, 1, 0],  # 1 knows 4
            [0, 0, 0, 0, 1, 0],  # 2 knows 4
            [0, 0, 0, 0, 1, 0],  # 3 knows 4
            [0, 0, 0, 0, 0, 0],  # 4 knows NOBODY
            [0, 0, 0, 0, 1, 0],  # 5 knows 4
       );
Output: 4

Example 2

Input: @party = (
            [0, 1, 0, 0],  # 0 knows 1
            [0, 0, 1, 0],  # 1 knows 2
            [0, 0, 0, 1],  # 2 knows 3
            [1, 0, 0, 0]   # 3 knows 0
       );
Output: -1

Example 3

Input: @party = (
            [0, 0, 0, 0, 0],  # 0 knows NOBODY
            [1, 0, 0, 0, 0],  # 1 knows 0
            [1, 0, 0, 0, 0],  # 2 knows 0
            [1, 0, 0, 0, 0],  # 3 knows 0
            [1, 0, 0, 0, 0]   # 4 knows 0
       );
Output: 0

Example 4

Input: @party = (
            [0, 1, 0, 1, 0, 1],  # 0 knows 1, 3, 5
            [1, 0, 1, 1, 0, 0],  # 1 knows 0, 2, 3
            [0, 0, 0, 1, 1, 0],  # 2 knows 3, 4
            [0, 0, 0, 0, 0, 0],  # 3 knows NOBODY
            [0, 1, 0, 1, 0, 0],  # 4 knows 1, 3
            [1, 0, 1, 1, 0, 0]   # 5 knows 0, 2, 3
       );
Output: 3

Example 5

Input: @party = (
            [0, 1, 1, 0],  # 0 knows 1 and 2
            [1, 0, 1, 0],  # 1 knows 0 and 2
            [0, 0, 0, 0],  # 2 knows NOBODY
            [0, 0, 0, 0]   # 3 knows NOBODY
       );
Output: -1

Example 6

Input: @party = (
            [0, 0, 1, 1],  # 0 knows 2 and 3
            [1, 0, 0, 0],  # 1 knows 0
            [1, 1, 0, 1],  # 2 knows 0, 1 and 3
            [1, 1, 0, 0]   # 3 knows 0 and 1
      );
Output: -1
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 22nd February
   2026.
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

type party []ints

func (pt party) process() int {
	l := len(pt)
	knowns := make(ints, l)
	cid := -1
	for r := range l {
		knows := 0
		for c := range l {
			k := pt[r][c]
			knows += k
			knowns[c] += k
		}
		if knows == 0 && knowns[r] == r {
			cid = r
		}
	}
	if cid >= 0 && knowns[cid] != l-1 {
		cid = -1
	}
	return cid
}

func main() {
	for _, data := range []struct {
		input  party
		output int
	}{
		{party{
			ints{0, 0, 0, 0, 1, 0}, // 0 knows 4
			ints{0, 0, 0, 0, 1, 0}, // 1 knows 4
			ints{0, 0, 0, 0, 1, 0}, // 2 knows 4
			ints{0, 0, 0, 0, 1, 0}, // 3 knows 4
			ints{0, 0, 0, 0, 0, 0}, // 4 knows NOBODY
			ints{0, 0, 0, 0, 1, 0}, // 5 knows 4
		}, 4,
		}, {party{
			ints{0, 1, 0, 0}, // 0 knows 1
			ints{0, 0, 1, 0}, // 1 knows 2
			ints{0, 0, 0, 1}, // 2 knows 3
			ints{1, 0, 0, 0}, // 3 knows 0
		}, -1,
		}, {party{
			ints{0, 0, 0, 0, 0}, // 0 knows NOBODY
			ints{1, 0, 0, 0, 0}, // 1 knows 0
			ints{1, 0, 0, 0, 0}, // 2 knows 0
			ints{1, 0, 0, 0, 0}, // 3 knows 0
			ints{1, 0, 0, 0, 0}, // 4 knows 0
		}, 0,
		}, {party{
			ints{0, 1, 0, 1, 0, 1}, // 0 knows 1, 3, 5
			ints{1, 0, 1, 1, 0, 0}, // 1 knows 0, 2, 3
			ints{0, 0, 0, 1, 1, 0}, // 2 knows 3, 4
			ints{0, 0, 0, 0, 0, 0}, // 3 knows NOBODY
			ints{0, 1, 0, 1, 0, 0}, // 4 knows 1, 3
			ints{1, 0, 1, 1, 0, 0}, // 5 knows 0, 2, 3
		}, 3,
		}, {party{
			ints{0, 1, 1, 0}, // 0 knows 1 and 2
			ints{1, 0, 1, 0}, // 1 knows 0 and 2
			ints{0, 0, 0, 0}, // 2 knows NOBODY
			ints{0, 0, 0, 0}, // 3 knows NOBODY
		}, -1,
		}, {party{
			ints{0, 0, 1, 1}, // 0 knows 2 and 3
			ints{1, 0, 0, 0}, // 1 knows 0
			ints{1, 1, 0, 1}, // 2 knows 0, 1 and 3
			ints{1, 1, 0, 0}, // 3 knows 0 and 1
		}, -1,
		}} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
