//# https://theweeklychallenge.org/blog/perl-weekly-challenge-314/
/*#

Task 2: Sort Column

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list of strings of same length.

   Write a script to make each column sorted lexicographically by deleting
   any non sorted columns.

   Return the total columns deleted.

Example 1

Input: @list = ("swpc", "tyad", "azbe")
Output: 2

swpc
tyad
azbe

Column 1: "s", "t", "a" => non sorted
Column 2: "w", "y", "z" => sorted
Column 3: "p", "a", "b" => non sorted
Column 4: "c", "d", "e" => sorted

Total columns to delete to make it sorted lexicographically.

Example 2

Input: @list = ("cba", "daf", "ghi")
Output: 1

Example 3

Input: @list = ("a", "b", "c")
Output: 0
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 30th March
   2025.
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

type input []string

func (in input) process() int {
	c := len(in)
	if c < 2 {
		return 0
	}
	l := len(in[0])
	for _, v := range in[1:] {
		if l != len(v) {
			return -1
		}
	}
	str := in[0]
	count := 0
	for i := range l {
		p := str[i]
		j := 1
		for j < c {
			n := in[j][i]
			if p > n {
				count++
				break
			}
			p = n
			j++
		}
	}
	return count
}

func main() {
	for _, data := range []struct {
		input  input
		output int
	}{
		{input{"swpc", "tyad", "azbe"}, 2},
		{input{"cba", "daf", "ghi"}, 1},
		{input{"a", "b", "c"}, 0},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
