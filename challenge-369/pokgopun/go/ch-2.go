//# https://theweeklychallenge.org/blog/perl-weekly-challenge-369/
/*#

Task 2: Group Division

Submitted by: [64]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, group size and filler character.

   Write a script to divide the string into groups of given size. In the
   last group if the string doesn’t have enough characters remaining fill
   with the given filler character.

Example 1

Input: $str = "RakuPerl", $size = 4, $filler = "*"
Output: ("Raku", "Perl")

Example 2

Input: $str = "Python", $size = 5, $filler = "0"
Output: ("Pytho", "n0000")

Example 3

Input: $str = "12345", $size = 3, $filler = "x"
Output: ("123", "45x")

Example 4

Input: $str = "HelloWorld", $size = 3, $filler = "_"
Output: ("Hel", "loW", "orl", "d__")

Example 5

Input: $str = "AI", $size = 5, $filler = "!"
Output: "AI!!!"
     __________________________________________________________________

   By submitting a response to the challenge you agree that your name or
   pseudonym, any photograph you supply and any other personal information
   contained in your submission may be published on this website and the
   associated mobile app. Last date to submit the solution 23:59 (UK Time)
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

func gd(str string, size int, filler byte) []string {
	var s []string
	l := len(str)
	o := (size - (l % size)) % size
	bs := make([]byte, l+o)
	copy(bs, []byte(str))
	i := len(bs)
	for i > l {
		i--
		bs[i] = filler
	}
	for len(bs) > 0 {
		s = append(s, string(bs[:size]))
		bs = bs[size:]
	}
	return s
}

func main() {
	for _, data := range []struct {
		str    string
		size   int
		filler byte
		output []string
	}{
		{"RakuPerl", 4, '*', []string{"Raku", "Perl"}},
		{"Python", 5, '0', []string{"Pytho", "n0000"}},
		{"12345", 3, 'x', []string{"123", "45x"}},
		{"HelloWorld", 3, '_', []string{"Hel", "loW", "orl", "d__"}},
		{"AI", 5, '!', []string{"AI!!!"}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(gd(data.str, data.size, data.filler), data.output)) // blank if ok, otherwise show the difference
	}
}
