//# https://theweeklychallenge.org/blog/perl-weekly-challenge-268/
/*#

Task 2: Number Game

Submitted by: [48]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints, with even number of
   elements.

   Write a script to create a new array made up of elements of the given
   array. Pick the two smallest integers and add it to new array in
   decreasing order i.e. high to low. Keep doing until the given array is
   empty.

Example 1

Input: @ints = (2, 5, 3, 4)
Output: (3, 2, 5, 4)

Round 1: we picked (2, 3) and push it to the new array (3, 2)
Round 2: we picked the remaining (4, 5) and push it to the new array (5, 4)

Example 2

Input: @ints = (9, 4, 1, 3, 6, 4, 6, 1)
Output: (1, 1, 4, 3, 6, 4, 9, 6)

Example 3

Input: @ints = (1, 2, 2, 3)
Output: (2, 1, 3, 2)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 12th May 2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
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
	Arr  ints
	None bool
}

func numberGame(is ints) Answer {
	l := len(is)
	if l%2 != 0 {
		return Answer{None: true}
	}
	slices.Sort(is)
	for l > 0 {
		is[l-1], is[l-2] = is[l-2], is[l-1]
		l -= 2
	}
	return Answer{Arr: is}
}

func main() {
	for _, data := range []struct {
		input  ints
		output Answer
	}{
		{ints{2, 5, 3, 4}, Answer{Arr: ints{3, 2, 5, 4}}},
		{ints{9, 4, 1, 3, 6, 4, 6, 1}, Answer{Arr: ints{1, 1, 4, 3, 6, 4, 9, 6}}},
		{ints{1, 2, 2, 3}, Answer{Arr: ints{2, 1, 3, 2}}},
		{ints{1, 2, 3}, Answer{None: true}},
		{ints{}, Answer{Arr: ints{}}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(numberGame(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
