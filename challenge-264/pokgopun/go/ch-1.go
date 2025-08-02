//# https://theweeklychallenge.org/blog/perl-weekly-challenge-264/
/*#

Task 1: Greatest English Letter

Submitted by: [47]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str, made up of only alphabetic characters
   [a..zA..Z].

   Write a script to return the greatest english letter in the given
   string.

     A letter is greatest if it occurs as lower and upper case. Also
     letter ‘b’ is greater than ‘a’ if ‘b’ appears after ‘a’ in the
     English alphabet.

Example 1

Input: $str = 'PeRlwEeKLy'
Output: L

There are two letters E and L that appears as lower and upper.
The letter L appears after E, so the L is the greatest english letter.

Example 2

Input: $str = 'ChaLlenge'
Output: L

Example 3

Input: $str = 'The'
Output: ''

Task 2: Target Array
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"slices"

	"github.com/google/go-cmp/cmp"
)

func gel(s string) string {
	bs := []byte(s)
	slices.Sort(bs)
	l := len(bs)
	i := l - 1
	for i > 0 {
		if bs[i] == bs[i-1] {
			copy(bs[i-1:], bs[i:])
			l--
		}
		i--
	}
	seen := make(map[byte]bool)
	var mx byte
	for _, v := range bs[:l] {
		if v > 96 {
			v -= 32
		}
		if seen[v] {
			mx = max(mx, v)
			continue
		}
		seen[v] = true
	}
	var res string
	if mx > 0 {
		res = string([]byte{mx})
	}
	return res
}

func main() {
	for _, data := range []struct {
		input, output string
	}{
		{"PeRLwEeKLy", "E"},
		{"PeRlwEeKLy", "L"},
		{"ChaLlenge", "L"},
		{"The", ""},
	} {
		io.WriteString(os.Stdout, cmp.Diff(gel(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
