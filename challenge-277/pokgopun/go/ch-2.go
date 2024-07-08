//# https://theweeklychallenge.org/blog/perl-weekly-challenge-277/
/*#

Task 2: Strong Pair

Submitted by: [54]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to return the count of all strong pairs in the given
   array.

     A pair of integers x and y is called strong pair if it satisfies: 0
     < |x - y| < min(x, y).

Example 1

Input: @ints = (1, 2, 3, 4, 5)
Ouput: 4

Strong Pairs: (2, 3), (3, 4), (3, 5), (4, 5)

Example 2

Input: @ints = (5, 7, 1, 7)
Ouput: 1

Strong Pairs: (5, 7)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 14th July 2024.
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

func (is ints) removeDuplicate() ints {
	m := make(map[int]int)
	for _, v := range is {
		m[v]++
	}
	var r ints
	for k := range m {
		r = append(r, k)
	}
	return r
}

func strongPair(is ints) int {
	is = is.removeDuplicate()
	c := 0
	l := len(is)
	for i := 0; i < l-1; i++ {
		for j := i + 1; j < l; j++ {
			if is[i] == is[j] {
				continue
			}
			if max(is[i], is[j]) < 2*min(is[i], is[j]) {
				c++
			}
		}
	}
	return c
}

func main() {
	for _, data := range []struct {
		ints  ints
		count int
	}{
		{ints{1, 2, 3, 4, 5}, 4},
		{ints{5, 7, 1, 7}, 1},
	} {
		io.WriteString(os.Stdout, cmp.Diff(strongPair(data.ints), data.count)) // blank if ok, otherwise show the difference
	}
}
