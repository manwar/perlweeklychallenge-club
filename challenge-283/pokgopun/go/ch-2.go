//# https://theweeklychallenge.org/blog/perl-weekly-challenge-283/
/*#

Task 2: Digit Count Value

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of positive integers, @ints.

   Write a script to return true if for every index i in the range 0 <= i
   < size of array, the digit i occurs exactly the $ints[$i] times in the
   given array otherwise return false.

Example 1

Input: @ints = (1, 2, 1, 0)
Ouput: true

$ints[0] = 1, the digit 0 occurs exactly 1 time.
$ints[1] = 2, the digit 1 occurs exactly 2 times.
$ints[2] = 1, the digit 2 occurs exactly 1 time.
$ints[3] = 0, the digit 3 occurs 0 time.

Example 2

Input: @ints = (0, 3, 0)
Ouput: false

$ints[0] = 0, the digit 0 occurs 2 times rather than 0 time.
$ints[1] = 3, the digit 1 occurs 0 time rather than 3 times.
$ints[2] = 0, the digit 2 occurs exactly 0 time.
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 25th August
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

type ints []int

func (is ints) dcv() bool {
	m := make(map[int]int)
	for i, v := range is {
		m[i] += v
		m[v] -= 1
	}
	for _, v := range m {
		if v != 0 {
			return false
		}
	}
	return true
}

func main() {
	for _, data := range []struct {
		input  ints
		output bool
	}{
		{ints{1, 2, 1, 0}, true},
		{ints{0, 3, 0}, false},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.dcv(), data.output)) // blank if ok, otherwise show the difference
	}
}
