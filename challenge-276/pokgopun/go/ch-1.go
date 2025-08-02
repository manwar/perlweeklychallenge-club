//# https://theweeklychallenge.org/blog/perl-weekly-challenge-276/
/*#

Task 1: Complete Day

Submitted by: [41]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @hours.

   Write a script to return the number of pairs that forms a complete day.

     A complete day is defined as a time duration that is an exact
     multiple of 24 hours.

Example 1

Input: @hours = (12, 12, 30, 24, 24)
Output: 2

Pair 1: (12, 12)
Pair 2: (24, 24)

Example 2

Input: @hours = (72, 48, 24, 5)
Output: 3

Pair 1: (72, 48)
Pair 2: (72, 24)
Pair 3: (48, 24)

Example 3

Input: @hours = (12, 18, 24)
Output: 0

Task 2: Maximum Frequency
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type hour int

func (hr hour) isCompleteDay() bool {
	return hr%24 == 0
}

type hours []hour

func (hrs hours) countCompleteDayPair() int {
	c := 0
	l := len(hrs)
	for i := 0; i < l-1; i++ {
		for j := i + 1; j < l; j++ {
			if (hrs[i] + hrs[j]).isCompleteDay() {
				c++
			}
		}
	}
	return c
}

func main() {
	for _, data := range []struct {
		input  hours
		output int
	}{
		{hours{12, 12, 30, 24, 24}, 2},
		{hours{72, 48, 24, 5}, 3},
		{hours{12, 18, 24}, 0},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.countCompleteDayPair(), data.output)) // blank if ok, otherwise show the difference
	}
}
