//# https://theweeklychallenge.org/blog/perl-weekly-challenge-297/
/*#

Task 1: Contiguous Array

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of binary numbers, @binary.

   Write a script to return the maximum length of a contiguous subarray
   with an equal number of 0 and 1.

Example 1

Input: @binary = (1, 0)
Output: 2

(1, 0) is the longest contiguous subarray with an equal number of 0 and 1.

Example 2

Input: @binary = (0, 1, 0)
Output: 2

(1, 0) or (0, 1) is the longest contiguous subarray with an equal number of 0 an
d 1.

Example 3

Input: @binary = (0, 0, 0, 0, 0)
Output: 0

Example 4

Input: @binary = (0, 1, 0, 0, 1, 0)
Output: 4

Task 2: Semi-Ordered Permutation
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type binaries []int

func (bins binaries) ca() int {
	l := len(bins)
	if l < 2 { // not a single pair exists, no contigious 0/1
		return 0
	}
	bsm := 0 // calculate sum of 1 and 0 in the based array
	for _, v := range bins[:l] {
		bsm += v
	}
	switch bsm {
	case 0: // based sum equal 0 means the based array only contains 0s so there is no contigious  0/1
		return 0
	case 1: // based array contains single 1 and at least single 0 (as l >= 2), thus contigious 0/1 is 2
		return 2
	}
	c := 0                 // contigious array starts with 0
	for i := range l - 1 { // sub array starts with index0 and will increase by one
		sm := bsm           // sum of sub array start of with the sum of based array
		o := (l - i) % 2    // detect if the sub array has odd number of members
		sm -= bins[l-1] * o // remove the last member from the sum of sub array if it has odd number of members
		j := l - o          // the sub array will start with maximum size, also adjust if its size is of odd numbers
		for j > i+1 {       // size will be reduce until the sub array has single pair
			//fmt.Println(i, j, "=>", bins[i:j], "sum =", sm)
			sl := j - i     // length of sub array
			if sm == sl/2 { // detect if sub array is contigious 0/1, thanks to SG
				//fmt.Println("new ca found =>", sl)
				if c < sl { // store new max size of contigious array
					c = sl
					// max contigious found if one from this based array is greater than next based array
					if c >= l-i-o-2 { // quit function as ca already reaches possible max
						//fmt.Println("max =", c)
						return c
					}
				}
			}
			// remove the last two members from the sum of sub array and it size (i.e. j)
			sm -= bins[j-2] + bins[j-1]
			j -= 2
		}
		// reduced the sum of based array as the start index increases
		bsm -= bins[i]
	}
	return c
}

func main() {
	for _, data := range []struct {
		input  binaries
		output int
	}{
		{binaries{1, 0}, 2},
		{binaries{0, 1, 0}, 2},
		{binaries{0, 0, 0, 0, 0}, 0},
		{binaries{0, 1, 0, 0, 1, 0}, 4},
		{binaries{0, 1, 1, 0, 1, 0}, 6},
		{binaries{1, 1, 1, 0, 1, 0}, 4},
		{binaries{0, 1, 1, 0, 1, 0, 1, 1}, 6},
		{binaries{1, 1, 1, 0, 1, 0, 1, 1}, 4},
		{binaries{0, 0, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1}, 10},
	} {
		//fmt.Println(data.input, data.output)
		io.WriteString(os.Stdout, cmp.Diff(data.input.ca(), data.output)) // blank if ok, otherwise show the difference
	}
}
