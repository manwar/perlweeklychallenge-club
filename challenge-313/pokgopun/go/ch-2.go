//# https://theweeklychallenge.org/blog/perl-weekly-challenge-313/
/*#

Task 2: Reverse Letters

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string.

   Write a script to reverse only the alphabetic characters in the string.

Example 1

Input: $str = "p-er?l"
Output: "l-re?p"

Example 2

Input: $str = "wee-k!L-y"
Output: "yLk-e!e-w"

Example 3

Input: $str = "_c-!h_all-en!g_e"
Output: "_e-!g_nel-la!h_c"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 23rd March
   2025.
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

func rl(str string) string {
	chrs := []rune(str)
	var ltrPos []int
	for i, v := range chrs {
		if (v >= 'a' && v <= 'z') || (v >= 'A' && v <= 'Z') || (v >= 'ก' && v <= 'ฮ') {
			ltrPos = append(ltrPos, i)
		}
	}
	l := len(ltrPos)
	for i := range l / 2 {
		a, b := ltrPos[i], ltrPos[l-1-i]
		chrs[a], chrs[b] = chrs[b], chrs[a]
	}
	return string(chrs)
}

func main() {
	for _, data := range []struct {
		input, output string
	}{
		{"p-er?l", "l-re?p"},
		{"wee-k!L-y", "yLk-e!e-w"},
		{"_c-!h_all-en!g_e", "_e-!g_nel-la!h_c"},
		{"ก-รอ?บ", "บ-อร?ก"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(rl(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
