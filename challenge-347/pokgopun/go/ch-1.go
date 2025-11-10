//# https://theweeklychallenge.org/blog/perl-weekly-challenge-347/
/*#

Task 1: Format Date

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a date in the form: 10th Nov 2025.

   Write a script to format the given date in the form: 2025-11-10 using
   the set below.
@DAYS   = ("1st", "2nd", "3rd", ....., "30th", "31st")
@MONTHS = ("Jan", "Feb", "Mar", ....., "Nov",  "Dec")
@YEARS  = (1900..2100)

Example 1

Input: $str = "1st Jan 2025"
Output: "2025-01-01"

Example 2

Input: $str = "22nd Feb 2025"
Output: "2025-02-22"

Example 3

Input: $str = "15th Apr 2025"
Output: "2025-04-15"

Example 4

Input: $str = "23rd Oct 2025"
Output: "2025-10-23"

Example 5

Input: $str = "31st Dec 2025"
Output: "2025-12-31"

Task 2: Format Phone Number
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"fmt"
	"io"
	"os"
	"slices"
	"strconv"
	"strings"

	"github.com/google/go-cmp/cmp"
)

func fd(str string) string {
	m := []string{"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"}
	d := strings.Split(str, " ")
	day, _ := strconv.Atoi(d[0][:len(d[0])-2])
	return fmt.Sprintf("%s-%02d-%02d", d[2], slices.Index(m, d[1])+1, day)
}

func main() {
	for _, data := range []struct {
		input, output string
	}{
		{"1st Jan 2025", "2025-01-01"},
		{"22nd Feb 2025", "2025-02-22"},
		{"15th Apr 2025", "2025-04-15"},
		{"23rd Oct 2025", "2025-10-23"},
		{"31st Dec 2025", "2025-12-31"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(fd(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
