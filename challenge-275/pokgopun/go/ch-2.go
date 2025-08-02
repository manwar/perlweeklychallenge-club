//# https://theweeklychallenge.org/blog/perl-weekly-challenge-275/
/*#

Task 2: Replace Digits

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an alphanumeric string, $str, where each character is
   either a letter or a digit.

   Write a script to replace each digit in the given string with the value
   of the previous letter plus (digit) places.

Example 1

Input: $str = 'a1c1e1'
Ouput: 'abcdef'

shift('a', 1) => 'b'
shift('c', 1) => 'd'
shift('e', 1) => 'f'

Example 2

Input: $str = 'a1b2c3d4'
Output: 'abbdcfdh'

shift('a', 1) => 'b'
shift('b', 2) => 'd'
shift('c', 3) => 'f'
shift('d', 4) => 'h'

Example 3

Input: $str = 'b2b'
Output: 'bdb'

Example 4

Input: $str = 'a16z'
Output: 'abgz'
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 30th June 2024.
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

func replaceDigits(str string) string {
	bs := []byte(str)
	var (
		b byte
		i int
	)
	for i = range len(bs) {
		if bs[i] >= 48 && bs[i] <= 57 {
			bs[i] = b + bs[i] - 48
		} else {
			b = bs[i]
		}
	}
	return string(bs)
}

func main() {
	for _, data := range []struct {
		input, output string
	}{
		{"a1c1e1", "abcdef"},
		{"a1b2c3d4", "abbdcfdh"},
		{"b2b", "bdb"},
		{"a16z", "abgz"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(replaceDigits(data.input), data.output)) // blank if ok, otherwise show the differences
	}
}
