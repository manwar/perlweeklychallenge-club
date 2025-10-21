//# https://theweeklychallenge.org/blog/perl-weekly-challenge-344/
/*#

Task 2: Array Formation

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two list: @source and @target.

   Write a script to see if you can build the exact @target by putting
   these smaller lists from @source together in some order. You cannot
   break apart or change the order inside any of the smaller lists in
   @source.

Example 1

Input: @source = ([2,3], [1], [4])
       @target = (1, 2, 3, 4)
Output: true

Use in the order: [1], [2,3], [4]

Example 2

Input: @source = ([1,3], [2,4])
       @target = (1, 2, 3, 4)
Output: false

Example 3

Input: @source = ([9,1], [5,8], [2])
       @target = (5, 8, 2, 9, 1)
Output: true

Use in the order: [5,8], [2], [9,1]

Example 4

Input: @source = ([1], [3])
       @target = (1, 2, 3)
Output: false

Missing number: 2

Example 5

Input: @source = ([7,4,6])
       @target = (7, 4, 6)
Output: true

Use in the order: [7, 4, 6]
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 26th October
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"iter"
	"os"
	"slices"

	"github.com/google/go-cmp/cmp"
)

func permutations[E any](s []E, r int) iter.Seq[[]E] {
	return func(yield func([]E) bool) {
		n := len(s)
		if r == 0 || n == 0 || r > n {
			return
		}
		if !yield(s[:r]) {
			return
		}
		res := make([]E, r)
		idx := make([]int, n)
		for v := range n {
			idx[v] = v
		}
		cyc := append(idx[n-r+1:], n)
		slices.Reverse(cyc)
		for {
			i := r
			for i > 0 {
				i--
				cyc[i]--
				if cyc[i] == 0 {
					copy(idx[i:], append(idx[i+1:], idx[i]))
					cyc[i] = n - i
				} else {
					j := cyc[i]
					idx[i], idx[n-j] = idx[n-j], idx[i]
					for i, v := range idx[:r] {
						res[i] = s[v]
					}
					if !yield(res) {
						return
					}
					break
				}
				if i > 0 {
					continue
				}
				return
			}
		}
	}
}

type ints []int

func af(source []ints, target ints) bool {
	l := len(target)
	for pmt := range permutations(source, len(source)) {
		t := make(ints, l)
		i := 0
		for _, p := range pmt {
			i += copy(t[i:], p)
		}
		if i != l {
			return false
		}
		if cmp.Diff(target, t) == "" {
			return true
		}
	}
	return false
}

func main() {
	for _, data := range []struct {
		source []ints
		target ints
		output bool
	}{
		{[]ints{ints{2, 3}, ints{1}, ints{4}}, ints{1, 2, 3, 4}, true},
		{[]ints{ints{1, 3}, ints{2, 4}}, ints{1, 2, 3, 4}, false},
		{[]ints{ints{9, 1}, ints{5, 8}, ints{2}}, ints{5, 8, 2, 9, 1}, true},
		{[]ints{ints{1}, ints{3}}, ints{1, 2, 3}, false},
		{[]ints{ints{7, 4, 6}}, ints{7, 4, 6}, true},
	} {
		//fmt.Println(data.source, data.target, data.output)
		io.WriteString(os.Stdout, cmp.Diff(af(data.source, data.target), data.output)) // blank if ok, otherwise show the difference
	}
}
