//# https://theweeklychallenge.org/blog/perl-weekly-challenge-282/
/*#

Task 1: Good Integer

Submitted by: [57]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a positive integer, $int, having 3 or more digits.

   Write a script to return the Good Integer in the given integer or -1 if
   none found.

     A good integer is exactly three consecutive matching digits.

Example 1

Input: $int = 12344456
Output: "444"

Example 2

Input: $int = 1233334
Output: -1

Example 3

Input: $int = 10020003
Output: "000"

Task 2: Changing Keys
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"strconv"

	"github.com/google/go-cmp/cmp"
)

type answer struct {
	Val_str  string
	Err_code int
}

func goodInteger(num int) answer {
	var (
		c int
		r rune
	)
	for _, v := range strconv.Itoa(num) {
		if r == v {
			c++
		} else {
			if c == 3 {
				return answer{Val_str: string([]rune{r, r, r})}
			}
			r = v
			c = 1
		}
	}
	return answer{Err_code: -1}
}

func main() {
	for _, data := range []struct {
		input  int
		output answer
	}{
		{12344456, answer{Val_str: "444"}},
		{1233334, answer{Err_code: -1}},
		{10020003, answer{Val_str: "000"}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(goodInteger(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
