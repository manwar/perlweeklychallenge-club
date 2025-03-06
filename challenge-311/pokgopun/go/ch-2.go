//# https://theweeklychallenge.org/blog/perl-weekly-challenge-311/
/*#

Task 2: Group Digit Sum

Submitted by: [40]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str, made up of digits, and an integer, $int,
   which is less than the length of the given string.

   Write a script to divide the given string into consecutive groups of
   size $int (plus one for leftovers if any). Then sum the digits of each
   group, and concatenate all group sums to create a new string. If the
   length of the new string is less than or equal to the given integer
   then return the new string, otherwise continue the process.

Example 1

Input: $str = "111122333", $int = 3
Output: "359"

Step 1: "111", "122", "333" => "359"

Example 2

Input: $str = "1222312", $int = 2
Output: "76"

Step 1: "12", "22", "31", "2" => "3442"
Step 2: "34", "42" => "76"

Example 3

Input: $str = "100012121001", $int = 4
Output: "162"

Step 1: "1000", "1212", "1001" => "162"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 9^th March
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"strconv"

	"github.com/google/go-cmp/cmp"
)

type digits string

func (ds digits) sum() digits {
	var sm rune
	for _, r := range ds {
		sm += r - 48
	}
	return digits(strconv.Itoa(int(sm)))
}

func (ds digits) add(d digits) digits {
	return ds + d
}

type input struct {
	ds digits
	n  int
}

func (in input) process() digits {
	ds, n := in.ds, in.n
	for {
		l := len(ds)
		if l <= n {
			break
		}
		var d digits
		r := l / n
		for i := range r {
			d = d.add(ds[i*n : i*n+n].sum())
		}
		if l%n > 0 {
			d = d.add(ds[r*n:].sum())
		}
		ds = d
	}
	return ds
}

func main() {
	for _, data := range []struct {
		input  input
		output digits
	}{
		{input{digits("111122333"), 3}, digits("359")},
		{input{digits("1222312"), 2}, digits("76")},
		{input{digits("100012121001"), 4}, digits("162")},
		{input{digits("100012121001"), 3}, digits("81")},
		{input{digits("100012121001"), 5}, digits("261")},
		{input{digits("99990999909999"), 5}, digits("216")},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
