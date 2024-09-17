//# https://theweeklychallenge.org/blog/perl-weekly-challenge-287/
/*#

Task 2: Valid Number

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str.

   Write a script to find if it is a valid number.

   Conditions for a valid number:
- An integer number followed by an optional exponent.
- A decimal number followed by an optional exponent.
- An integer number is defined with an optional sign '-' or '+' followed by digi
ts.

   Decimal Number:
A decimal number is defined with an optional sign '-' or '+' followed by one of
the following definitions:
- Digits followed by a dot '.'.
- Digits followed by a dot '.' followed by digits.
- A dot '.' followed by digits.

   Exponent:
An exponent is defined with an exponent notation 'e' or 'E' followed by an integ
er number.

Example 1

Input: $str = "1"
Output: true

Example 2

Input: $str = "a"
Output: false

Example 3

Input: $str = "."
Output: false

Example 4

Input: $str = "1.2e4.2"
Output: false

Example 5

Input: $str = "-1."
Output: true

Example 6

Input: $str = "+1E-8"
Output: true

Example 7

Input: $str = ".44"
Output: true
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 22nd September
   2024.
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

func validNumber(str string) bool {
	if _, err := strconv.ParseFloat(str, 64); err != nil {
		return false
	}
	return true
}

func main() {
	for _, data := range []struct {
		input  string
		output bool
	}{
		{"1", true},
		{"a", false},
		{".", false},
		{"1.2e4.2", false},
		{"-1.", true},
		{"+1E-8", true},
		{".44", true},
	} {
		io.WriteString(os.Stdout, cmp.Diff(validNumber(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
