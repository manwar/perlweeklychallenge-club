//# https://theweeklychallenge.org/blog/perl-weekly-challenge-348/
/*#

Task 1: String Alike

Submitted by: [49]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string of even length.

   Write a script to find if the given string split into two halves of
   equal lengths and they both have same number of vowels.

Example 1

Input: $str = "textbook"
Output: false

1st half: "text" (1 vowel)
2nd half: "book" (2 vowels)

Example 2

Input: $str = "book"
Output: true

1st half: "bo" (1 vowel)
2nd half: "ok" (1 vowel)

Example 3

Input: $str = "AbCdEfGh"
Output: true

1st half: "AbCd" (1 vowel)
2nd half: "EfGh" (1 vowel)

Example 4

Input: $str = "rhythmmyth"
Output: false

1st half: "rhyth" (0 vowel)
2nd half: "mmyth" (0 vowel)

Example 5

Input: $str = "UmpireeAudio"
Output: false

1st half: "Umpire" (3 vowels)
2nd half: "eAudio" (5 vowels)

Task 2: Covert Time
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

func sa(str string) bool {
	h := len(str) / 2
	var cnt [2]int
	d := 'a' - 'A'
	for i, rs := range []string{str[:h], str[h:]} {
		for _, r := range rs {
			if r < 'a' {
				r += d
			}
			switch r {
			case 'a', 'e', 'i', 'o', 'u':
				cnt[i]++
			}
		}
	}
	return cnt[0] > 0 && cnt[0] == cnt[1]
}

func main() {
	for _, data := range []struct {
		input  string
		output bool
	}{
		{"textbook", false},
		{"book", true},
		{"AbCdEfGh", true},
		{"rhythmmyth", false},
		{"UmpireeAudio", false},
	} {
		io.WriteString(os.Stdout, cmp.Diff(sa(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
