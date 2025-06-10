//# https://theweeklychallenge.org/blog/perl-weekly-challenge-325/
/*#

Task 1: Consecutive One

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a binary array containing only 0 or/and 1.

   Write a script to find out the maximum consecutive 1 in the given
   array.

Example 1

Input: @binary = (0, 1, 1, 0, 1, 1, 1)
Output: 3

Example 2

Input: @binary = (0, 0, 0, 0)
Output: 0

Example 3

Input: @binary = (1, 0, 1, 0, 1, 1)
Output: 2

Task 2: Final Price
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type ints []int

func (in ints) process() int {
	var c, mx int
	n := len(in)
	for n > 0 {
		n--
		if in[n] == 0 {
			if c == 0 {
				continue
			}
			if c > mx {
				//fmt.Printf("mx = %d\n", c)
				mx = c
			}
			if n > 0 && n <= mx {
				//fmt.Printf("remaining %d cannot exceed max %d\n", n, mx)
				break
			}
			c = 0
		} else {
			c++
		}
	}
	if n == 0 && in[n] > 0 {
		//fmt.Println("final max update")
		if mx < c {
			//fmt.Printf("mx = %d\n", c)
			mx = c
		}
	}
	return mx
}

func main() {
	for _, data := range []struct {
		input  ints
		output int
	}{
		{ints{0, 1, 1, 0, 1, 1, 1}, 3},
		{ints{0, 0, 0, 0}, 0},
		{ints{1, 0, 1, 0, 1, 1}, 2},
		{ints{1, 0, 1, 1, 0, 1, 1}, 2},
		{ints{1, 0, 1, 1, 0, 0, 1, 1}, 2},
		{ints{0, 1, 1, 1, 0, 1, 1, 1}, 3},
		{ints{1, 1, 1, 1, 0, 1, 1, 1, 0}, 4},
		{ints{0, 1, 1, 0, 0, 1, 1, 1, 0}, 3},
	} {
		//fmt.Println(data)
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
