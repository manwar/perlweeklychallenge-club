//# https://theweeklychallenge.org/blog/perl-weekly-challenge-298/
/*#

Task 2: Right Interval

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of @intervals, where $intervals[i] = [starti,
   endi] and each starti is unique.

   The right interval for an interval i is an interval j such that startj
   >= endi and startj is minimized. Please note that i may equal j.

   Write a script to return an array of right interval indices for each
   interval i. If no right interval exists for interval i, then put -1 at
   index i.

Example 1

Input: @intervals = ([3,4], [2,3], [1,2])
Output: (-1, 0, 1)

There is no right interval for [3,4].
The right interval for [2,3] is [3,4] since start0 = 3 is the smallest start tha
t is >= end1 = 3.
The right interval for [1,2] is [2,3] since start1 = 2 is the smallest start tha
t is >= end2 = 2.

Example 2

Input: @intervals = ([1,4], [2,3], [3,4])
Output: (-1, 2, -1)

There is no right interval for [1,4] and [3,4].
The right interval for [2,3] is [3,4] since start2 = 3 is the smallest start tha
t is >= end1 = 3.

Example 3

Input: @intervals = ([1,2])
Output: (-1)

There is only one interval in the collection, so it outputs -1.

Example 4

Input: @intervals = ([1,4], [2, 2], [3, 4])
Output: (-1, 1, -1)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 8th December
   2024.
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

type interval struct {
	start, end int
}

type intervals []interval

func (is intervals) rightIntervals() []int {
	l := len(is)
	ri := make([]int, l)
	for i := range l {
		j := 0
		for j < l {
			if is[i].end == is[j].start {
				ri[i] = j
				break
			}
			j++
		}
		if j == l {
			ri[i] = -1
		}
	}
	return ri
}

func main() {
	for _, data := range []struct {
		input  intervals
		output []int
	}{
		{intervals{interval{3, 4}, interval{2, 3}, interval{1, 2}}, []int{-1, 0, 1}},
		{intervals{interval{1, 4}, interval{2, 3}, interval{3, 4}}, []int{-1, 2, -1}},
		{intervals{interval{1, 2}}, []int{-1}},
		{intervals{interval{1, 4}, interval{2, 2}, interval{3, 4}}, []int{-1, 1, -1}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.rightIntervals(), data.output)) // blank if ok, otherwise show the difference
	}
}
