//# https://theweeklychallenge.org/blog/perl-weekly-challenge-264/
/*#

Task 2: Target Array

Submitted by: [48]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two arrays of integers, @source and @indices. The
   @indices can only contains integers 0 <= i < size of @source.

   Write a script to create target array by insert at index $indices[i]
   the value $source[i].

Example 1

Input: @source  = (0, 1, 2, 3, 4)
       @indices = (0, 1, 2, 2, 1)
Output: (0, 4, 1, 3, 2)

@source  @indices  @target
0        0         (0)
1        1         (0, 1)
2        2         (0, 1, 2)
3        2         (0, 1, 3, 2)
4        1         (0, 4, 1, 3, 2)

Example 2

Input: @source  = (1, 2, 3, 4, 0)
       @indices = (0, 1, 2, 3, 0)
Output: (0, 1, 2, 3, 4)

@source  @indices  @target
1        0         (1)
2        1         (1, 2)
3        2         (1, 2, 3)
4        3         (1, 2, 3, 4)
0        0         (0, 1, 2, 3, 4)

Example 3

Input: @source  = (1)
       @indices = (0)
Output: (1)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 14th April
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

func target(source, indices ints) ints {
	res := make(ints, len(source))
	var i, j, v int
	for i, v = range source {
		j = indices[i]
		if j < i {
			copy(res[j+1:], res[j:])
		}
		res[j] = v
	}
	return res
}

func main() {
	for _, data := range []struct {
		source, indices, target ints
	}{
		{ints{0, 1, 2, 3, 4}, ints{0, 1, 2, 2, 1}, ints{0, 4, 1, 3, 2}},
		{ints{1, 2, 3, 4, 0}, ints{0, 1, 2, 3, 0}, ints{0, 1, 2, 3, 4}},
		{ints{1}, ints{0}, ints{1}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(target(data.source, data.indices), data.target)) // blank if ok, otherwise show the difference
	}
}
