//# https://theweeklychallenge.org/blog/perl-weekly-challenge-296/
/*#

Task 1: String Compression

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string of alphabetic characters, $chars.

   Write a script to compress the string with run-length encoding, as
   shown in the examples.

   A compressed unit can be either a single character or a count followed
   by a character.

   BONUS: Write a decompression function.

Example 1

Input: $chars = "abbc"
Output: "a2bc"

Example 2

Input: $chars = "aaabccc"
Output: "3ab3c"

Example 3

Input: $chars = "abcc"
Output: "ab2c"

Task 2: Matchstick Square
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"strconv"
	"strings"

	"github.com/google/go-cmp/cmp"
)

func isDigit(b byte) bool {
	return b >= 48 && b <= 57
}

func compress(str string) string {
	if str == "" || isDigit(str[0]) {
		return ""
	}
	var b strings.Builder
	p := str[0]
	c := 1
	for _, v := range []byte(str)[1:] {
		if isDigit(v) {
			return ""
		}
		if v == p {
			c++
		} else {
			if c > 1 {
				b.WriteString(strconv.Itoa(c))
			}
			b.WriteByte(p)
			c = 1
			p = v
		}
	}
	if c > 1 {
		b.WriteString(strconv.Itoa(c))
	}
	b.WriteByte(p)
	return b.String()
}

func decompress(str string) string {
	var b, c strings.Builder
	for _, v := range []byte(str) {
		if isDigit(v) {
			c.WriteByte(v)
		} else {
			n := 1
			if c.String() != "" {
				n, _ = strconv.Atoi(c.String())
				if n <= 1 {
					return ""
				}
			}
			for n > 0 {
				b.WriteByte(v)
				n--
			}
			c.Reset()
		}
	}
	return b.String()
}

func main() {
	for _, data := range []struct {
		input, output string
	}{
		{"abbc", "a2bc"},
		{"aaabccc", "3ab3c"},
		{"abcc", "ab2c"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(compress(data.input), data.output))   // blank if ok, otherwise show the difference
		io.WriteString(os.Stdout, cmp.Diff(decompress(data.output), data.input)) // blank if ok, otherwise show the difference
	}
}
