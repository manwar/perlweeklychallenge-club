//# https://theweeklychallenge.org/blog/perl-weekly-challenge-276/
/*#

Task 2: Maximum Frequency

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of positive integers, @ints.

   Write a script to return the total number of elements in the given
   array which have the highest frequency.

Example 1

Input: @ints = (1, 2, 2, 4, 1, 5)
Ouput: 4

The maximum frequency is 2.
The elements 1 and 2 has the maximum frequency.

Example 2

Input: @ints = (1, 2, 3, 4, 5)
Ouput: 5

The maximum frequency is 1.
The elements 1, 2, 3, 4 and 5 has the maximum frequency.
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 7th July 2024.
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

type intCount struct {
	int, count int
}

type ints []int

func (is ints) uniqInts() ints {
	seen := make(map[int]bool)
	var s ints
	for _, v := range is {
		if seen[v] {
			continue
		}
		seen[v] = true
		s = append(s, v)
	}
	return s
}

func (is ints) intCounts() []intCount {
	var s []intCount
	for _, v := range is.uniqInts() {
		c := 0
		for _, e := range is {
			if e == v {
				c++
			}
		}
		s = append(s, intCount{v, c})
	}
	return s
}

func (is ints) maxFreq() int {
	intCounts := is.intCounts()
	mx := intCounts[0].count
	for _, v := range intCounts[1:] {
		mx = max(mx, v.count)
	}
	c := 0
	for _, v := range intCounts {
		if v.count == mx {
			c += mx
		}
	}
	return c
}

func main() {
	for _, data := range []struct {
		input  ints
		output int
	}{
		{ints{1, 2, 2, 4, 1, 5}, 4},
		{ints{1, 2, 3, 4, 5}, 5},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.maxFreq(), data.output)) // blank if ok, otherwise show the difference
	}
}
