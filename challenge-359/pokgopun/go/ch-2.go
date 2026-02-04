//# https://theweeklychallenge.org/blog/perl-weekly-challenge-359/
/*#

Task 2: String Reduction

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a word containing only alphabets,

   Write a function that repeatedly removes adjacent duplicate characters
   from a string until no adjacent duplicates remain and return the final
   word.

Example 1

Input: $word = "aabbccdd"
Output: ""

Iteration 1: remove "aa", "bb", "cc", "dd" => ""

Example 2

Input: $word = "abccba"
Output: ""

Iteration 1: remove "cc" => "abba"
Iteration 2: remove "bb" => "aa"
Iteration 3: remove "aa" => ""

Example 3

Input: $word = "abcdef"
Output: "abcdef"

No duplicate found.

Example 4

Input: $word = "aabbaeaccdd"
Output: "aea"

Iteration 1: remove "aa", "bb", "cc", "dd" => "aea"

Example 5

Input: $word = "mississippi"
Output: "m"

Iteration 1: Remove "ss", "ss", "pp" => "miiii"
Iteration 2: Remove "ii", "ii" => "m"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 7th February
   2026.
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

func stringReduction(str string) string {
	rs := []rune(str)
	l := len(rs) - 1
	for {
		i := 0
		d := l
		for i < l {
			if rs[i] == rs[i+1] {
				copy(rs[i:], rs[i+2:])
				rs = rs[:l-1]
				l -= 2
			} else {
				i++
			}
		}
		if d == l {
			break
		}
	}
	return string(rs)
}

func main() {
	for _, data := range []struct {
		input, output string
	}{
		{"aabbccdd", ""},
		{"abccba", ""},
		{"abcdef", "abcdef"},
		{"aabbaeaccdd", "aea"},
		{"mississippi", "m"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(stringReduction(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
