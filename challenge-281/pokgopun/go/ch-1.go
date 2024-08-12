//# https://theweeklychallenge.org/blog/perl-weekly-challenge-281/
/*#

Task 1: Check Color

Submitted by: [47]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given coordinates, a string that represents the coordinates of
   a square of the chessboard as shown below:

   Week_281_Task_1

   Write a script to return true if the square is light, and false if the
   square is dark.

Example 1

Input: $coordinates = "d3"
Output: true

Example 2

Input: $coordinates = "g5"
Output: false

Example 3

Input: $coordinates = "e6"
Output: true

Task 2: Knight’s Move
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

func checkColor(str string) bool {
	return ((str[0] % 2) + (str[1] % 2)) == 1
}

func main() {
	for _, data := range []struct {
		input  string
		output bool
	}{
		{"d3", true},
		{"g5", false},
		{"e6", true},
	} {
		io.WriteString(os.Stdout, cmp.Diff(checkColor(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
