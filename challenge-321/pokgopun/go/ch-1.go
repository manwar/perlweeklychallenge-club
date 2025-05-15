//# https://theweeklychallenge.org/blog/perl-weekly-challenge-321/
/*#

Task 1: Distinct Average

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of numbers with even length.

   Write a script to return the count of distinct average. The average is
   calculate by removing the minimum and the maximum, then average of the
   two.

Example 1

Input: @nums = (1, 2, 4, 3, 5, 6)
Output: 1

Step 1: Min = 1, Max = 6, Avg = 3.5
Step 2: Min = 2, Max = 5, Avg = 3.5
Step 3: Min = 3, Max = 4, Avg = 3.5

The count of distinct average is 1.

Example 2

Input: @nums = (0, 2, 4, 8, 3, 5)
Output: 2

Step 1: Min = 0, Max = 8, Avg = 4
Step 2: Min = 2, Max = 5, Avg = 3.5
Step 3: Min = 3, Max = 4, Avg = 3.5

The count of distinct average is 2.

Example 3

Input: @nums = (7, 3, 1, 0, 5, 9)
Output: 2

Step 1: Min = 0, Max = 9, Avg = 4.5
Step 2: Min = 1, Max = 7, Avg = 4
Step 3: Min = 3, Max = 5, Avg = 4

The count of distinct average is 2.

Task 2: Backspace Compare
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"slices"

	"github.com/google/go-cmp/cmp"
)

type qr struct {
	q, r int
}

type input []int

func (in input) process() int {
	l := len(in)
	slices.Sort(in)
	m := make(map[qr]bool)
	for i := range l / 2 {
		sm := (in[i] + in[l-1-i])
		m[qr{sm / 2, sm % 2}] = true
	}
	//fmt.Println(in, m)
	return len(m)
}

func main() {
	for _, data := range []struct {
		input  input
		output int
	}{
		{input{1, 2, 4, 3, 5, 6}, 1},
		{input{0, 2, 4, 8, 3, 5}, 2},
		{input{7, 3, 1, 0, 5, 9}, 2},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
