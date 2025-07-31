//# https://theweeklychallenge.org/blog/perl-weekly-challenge-332/
/*#

Task 1: Binary Date

Submitted by: [39]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a date in the format YYYY-MM-DD.

   Write a script to convert it into binary date.

Example 1

Input: $date = "2025-07-26"
Output: "11111101001-111-11010"

Example 2

Input: $date = "2000-02-02"
Output: "11111010000-10-10"

Example 3

Input: $date = "2024-12-31"
Output: "11111101000-1100-11111"

Task 2: Odd Letters
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"fmt"
	"io"
	"os"
	"strings"

	"github.com/google/go-cmp/cmp"
)

func bd(str string) string {
	var y, m, d int
	fmt.Fscanf(strings.NewReader(str), "%d-%d-%d", &y, &m, &d)
	return fmt.Sprintf("%b-%b-%b", y, m, d)
}

func main() {
	for _, data := range []struct {
		input, output string
	}{
		{"2025-07-26", "11111101001-111-11010"},
		{"2000-02-02", "11111010000-10-10"},
		{"2024-12-31", "11111101000-1100-11111"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(bd(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
