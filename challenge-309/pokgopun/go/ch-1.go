//# https://theweeklychallenge.org/blog/perl-weekly-challenge-309/
/*#

Task 1: Min Gap

Submitted by: [40]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints, increasing order.

   Write a script to return the element before which you find the smallest
   gap.

Example 1

Input: @ints = (2, 8, 10, 11, 15)
Output: 11

 8 - 2  => 6
10 - 8  => 2
11 - 10 => 1
15 - 11 => 4

11 is where we found the min gap.

Example 2

Input: @ints = (1, 5, 6, 7, 14)
Output: 6

 5 - 1 => 4
 6 - 5 => 1
 7 - 6 => 1
14 - 7 => 7

6 and 7 where we found the min gap, so we pick the first instance.

Example 3

Input: @ints = (8, 20, 25, 28)
Output: 28

 8 - 20 => 14
25 - 20 => 5
28 - 25 => 3

28 is where we found the min gap.

Task 2: Min Diff
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type keep struct {
	gap, n int
}

func newKeep(a, b int) keep {
	return keep{b - a, b}
}

type output struct {
	Err bool
	Val int
}

type ints []int

func (is ints) minGap() output {
	l := len(is)
	if l < 2 {
		return output{Err: true}
	}
	k := newKeep(is[0], is[1])
	i := 1
	for i < l-1 {
		ki := newKeep(is[i], is[i+1])
		if ki.gap < k.gap {
			k = ki
		}
		i++
	}
	return output{Val: k.n}
}

func main() {
	for _, data := range []struct {
		input  ints
		output output
	}{
		{ints{2, 8, 10, 11, 15}, output{Val: 11}},
		{ints{1, 5, 6, 7, 14}, output{Val: 6}},
		{ints{8, 20, 25, 28}, output{Val: 28}},
		{ints{8}, output{Err: true}},
		{ints{}, output{Err: true}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.minGap(), data.output)) // blank if ok, otherwise show the difference
	}
}
