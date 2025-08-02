//# https://theweeklychallenge.org/blog/perl-weekly-challenge-268/
/*#

Task 1: Magic Number

Submitted by: [47]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two arrays of integers of same size, @x and @y.

   Write a script to find the magic number that when added to each
   elements of one of the array gives the second array. Elements order is
   not important.

Example 1

Input: @x = (3, 7, 5)
       @y = (9, 5, 7)
Output: 2

The magic number is 2.
@x = (3, 7, 5)
   +  2  2  2
@y = (5, 9, 7)

Example 2

Input: @x = (1, 2, 1)
       @y = (5, 4, 4)
Output: 3

The magic number is 3.
@x = (1, 2, 1)
   +  3  3  3
@y = (5, 4, 4)

Example 3

Input: @x = (2)
       @y = (5)
Output: 3

Task 2: Number Game
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"slices"

	"github.com/google/go-cmp/cmp"
)

type ints []int

type Answer struct {
	Val  int
	None bool
}

func magicNumber(x, y ints) Answer {
	l := len(x)
	if l == 0 || l != len(y) {
		return Answer{None: true}
	}
	slices.Sort(x)
	slices.Sort(y)
	l--
	d := y[l] - x[l]
	for i := range l {
		if d != y[i]-x[i] {
			return Answer{None: true}
		}
	}
	return Answer{Val: d}
}

func main() {
	for _, data := range []struct {
		x, y ints
		ans  Answer
	}{
		{ints{3, 7, 5}, ints{9, 5, 7}, Answer{Val: 2}},
		{ints{1, 2, 1}, ints{5, 4, 4}, Answer{Val: 3}},
		{ints{1, 2, 2}, ints{5, 4, 4}, Answer{None: true}},
		{ints{2}, ints{5}, Answer{Val: 3}},
		{ints{2}, ints{5, 4}, Answer{None: true}},
		{ints{}, ints{}, Answer{None: true}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(magicNumber(data.x, data.y), data.ans)) // blank if ok, otherwise show the difference
	}
}
