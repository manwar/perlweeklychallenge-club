//# https://theweeklychallenge.org/blog/perl-weekly-challenge-339/
/*#

Task 1: Max Diff

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers having four or more elements.

   Write a script to find two pairs of numbers from this list (four
   numbers total) so that the difference between their products is as
   large as possible.

   In the end return the max difference.

     With Two pairs (a, b) and (c, d), the product difference is (a * b)
     - (c * d).

Example 1

Input: @ints = (5, 9, 3, 4, 6)
Output: 42

Pair 1: (9, 6)
Pair 2: (3, 4)
Product Diff: (9 * 6) - (3 * 4) => 54 - 12 => 42

Example 2

Input: @ints = (1, -2, 3, -4)
Output: 8

Pair 1: (3, 1)
Pair 2: (-2, -4)

Example 3

Input: @ints = (-3, -1, -2, -4)
Output: 10

Pair 1: (-1, -2)
Pair 2: (-3, -4)

Example 4

Input: @ints = (10, 2, 0, 5, 1)
Output: 50

Pair 1: (10, 5)
Pair 2: (0, 1)

Example 5

Input: @ints = (7, 8, 9, 10, 10)
Output: 44

Pair 1: (10, 10)
Pair 2: (7, 8)

Task 2: Peak Point
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

type pair [2]int

func (pr pair) prod() int {
	return pr[0] * pr[1]
}

func (pr pair) diff(p pair) int {
	d1, d2 := pr.prod(), p.prod()
	return max(d1, d2) - min(d1, d2)
}

func (pr pair) uniq(p pair) bool {
	s := []int{pr[0], pr[1], p[0], p[1]}
	slices.Sort(s)
	return len(slices.Compact(s)) == 4
}

type pairs []pair

func indexPairSeq(l int) iter.Seq[pair] {
	return func(yield func(p pair) bool) {
		for i := 0; i < l-1; i++ {
			for j := i + 1; j < l; j++ {
				if !yield(pair{i, j}) {
					return
				}
			}
		}
	}
}

type ints []int

func (in ints) process() int {
	idxPrs := slices.Collect(indexPairSeq(len(in)))
	l := len(idxPrs)
	var (
		init bool
		mx   int
		ps   pairs
	)
	for i := range indexPairSeq(l) {
		i1, i2 := idxPrs[i[0]], idxPrs[i[1]]
		if i1.uniq(i2) == false {
			continue
		}
		v1, v2 := pair{in[i1[0]], in[i1[1]]}, pair{in[i2[0]], in[i2[1]]}
		d := v1.diff(v2)
		if init == false || mx < d {
			init = true
			mx = d
			ps = pairs{v1, v2}
		}
	}
	//fmt.Println(ps, mx)
	r, _ := mx, ps
	return r
}

func main() {
	for _, data := range []struct {
		input  ints
		output int
	}{
		{ints{5, 9, 3, 4, 6}, 42},
		{ints{1, -2, 3, -4}, 10},
		{ints{-3, -1, -2, -4}, 10},
		{ints{10, 2, 0, 5, 1}, 50},
		{ints{7, 8, 9, 10, 10}, 44},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
