//# https://theweeklychallenge.org/blog/perl-weekly-challenge-324/
/*#

Task 2: Total XOR

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to return the sum of total XOR for every subset of given
   array.

Example 1

Input: @ints = (1, 3)
Output: 6

Subset [1],    total XOR = 1
Subset [3],    total XOR = 3
Subset [1, 3], total XOR => 1 XOR 3 => 2

Sum of total XOR => 1 + 3 + 2 => 6

Example 2

Input: @ints = (5, 1, 6)
Output: 28

Subset [5],       total XOR = 5
Subset [1],       total XOR = 1
Subset [6],       total XOR = 6
Subset [5, 1],    total XOR => 5 XOR 1 => 4
Subset [5, 6],    total XOR => 5 XOR 6 => 3
Subset [1, 6],    total XOR => 1 XOR 6 => 7
Subset [5, 1, 6], total XOR => 5 XOR 1 XOR 6 => 2

Sum of total XOR => 5 + 1 + 6 + 4 + 3 + 7 + 2 => 28

Example 3

Input: @ints = (3, 4, 5, 6, 7, 8)
Output: 480
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 8th June 2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"iter"
	"os"

	"github.com/google/go-cmp/cmp"
)

type ints []int

func (in ints) process() int {
	var tx, x int
	for r := range len(in) {
		for cmb := range Combinations(in, uint(r+1)) {
			x = cmb[0]
			for _, v := range cmb[1:] {
				x ^= v
			}
			tx += x
		}
	}
	return tx
}

func main() {
	for _, data := range []struct {
		input  ints
		output int
	}{
		{ints{1, 3}, 6},
		{ints{5, 1, 6}, 28},
		{ints{3, 4, 5, 6, 7, 8}, 480},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}

// transcribed from https://docs.python.org/3/library/itertools.html#itertools.combinations
func Combinations[E any](s []E, r uint) iter.Seq[[]E] {
	return func(yield func([]E) bool) {
		n := uint(len(s))
		if r == 0 || r > n {
			return
		}
		result := make([]E, r)
		copy(result, s)
		if !yield(result) {
			return
		}
		idx := make([]uint, r)
		for i := range r {
			idx[i] = uint(i)
		}
		var i, j uint
		for {
			i = r
			for {
				i--
				if idx[i] != i+n-r {
					break
				}
				if i > 0 {
					continue
				}
				return
			}
			idx[i]++
			j = i + 1
			for j < r {
				idx[j] = idx[j-1] + 1
				j++
			}
			result := make([]E, r)
			for i, v := range idx {
				result[i] = s[v]
			}
			if !yield(result) {
				return
			}
		}
	}
}
