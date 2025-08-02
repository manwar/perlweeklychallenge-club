//# https://theweeklychallenge.org/blog/perl-weekly-challenge-326/
/*#

Task 1: Day of the Year

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a date in the format YYYY-MM-DD.

   Write a script to find day number of the year that the given date
   represent.

Example 1

Input: $date = '2025-02-02'
Output: 33

The 2nd Feb, 2025 is the 33rd day of the year.

Example 2

Input: $date = '2025-04-10'
Output: 100

Example 3

Input: $date = '2025-09-07'
Output: 250

Task 2: Decompressed List
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"time"

	"github.com/google/go-cmp/cmp"
)

const shortForm = "2006-01-02"

func doy(str string) int {
	t, _ := time.Parse(shortForm, str)
	return t.YearDay()
}

func main() {
	for _, data := range []struct {
		input  string
		output int
	}{
		{"2025-02-02", 33},
		{"2025-04-10", 100},
		{"2025-09-07", 250},
	} {
		io.WriteString(os.Stdout, cmp.Diff(doy(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
