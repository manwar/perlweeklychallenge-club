//# https://theweeklychallenge.org/blog/perl-weekly-challenge-284/
/*#

Task 2: Relative Sort

Submitted by: [41]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two list of integers, @list1 and @list2. The elements in
   the @list2 are distinct and also in the @list1.

   Write a script to sort the elements in the @list1 such that the
   relative order of items in @list1 is same as in the @list2. Elements
   that is missing in @list2 should be placed at the end of @list1 in
   ascending order.

Example 1

Input: @list1 = (2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5)
       @list2 = (2, 1, 4, 3, 5, 6)
Ouput: (2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9)

Example 2

Input: @list1 = (3, 3, 4, 6, 2, 4, 2, 1, 3)
       @list2 = (1, 3, 2)
Ouput: (1, 3, 3, 3, 2, 2, 4, 4, 6)

Example 3

Input: @list1 = (3, 0, 5, 0, 2, 1, 4, 1, 1)
       @list2 = (1, 0, 3, 2)
Ouput: (1, 1, 1, 0, 0, 3, 2, 4, 5)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 1st September
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"cmp"
	"io"
	"os"
	"slices"

	gcmp "github.com/google/go-cmp/cmp"
)

type ints []int

func (is ints) breakDiff(is2 ints) (r1, r2 ints) {
	m := make(map[int]bool)
	for _, v := range is2 {
		if !m[v] {
			m[v] = true
		}
	}
	for _, v := range is {
		if m[v] {
			r1 = append(r1, v)
		} else {
			r2 = append(r2, v)
		}
	}
	return r1, r2
}

func (is ints) rs(is2 ints) ints {
	m := make(map[int]int)
	for i, v := range is2 {
		m[v] = i
	}
	r1, r2 := is.breakDiff(is2)
	slices.SortFunc(r1, func(a, b int) int {
		return cmp.Compare(m[a], m[b])
	})
	slices.Sort(r2)
	return append(r1, r2...)
}

func main() {
	for _, data := range []struct {
		ints1, ints2, output ints
	}{
		{ints{2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5}, ints{2, 1, 4, 3, 5, 6}, ints{2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9}},
		{ints{3, 3, 4, 6, 2, 4, 2, 1, 3}, ints{1, 3, 2}, ints{1, 3, 3, 3, 2, 2, 4, 4, 6}},
		{ints{3, 0, 5, 0, 2, 1, 4, 1, 1}, ints{1, 0, 3, 2}, ints{1, 1, 1, 0, 0, 3, 2, 4, 5}},
	} {
		io.WriteString(os.Stdout, gcmp.Diff(data.ints1.rs(data.ints2), data.output)) // blank if ok, otherwise show the difference
	}
}
