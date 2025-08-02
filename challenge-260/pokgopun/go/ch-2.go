//# https://theweeklychallenge.org/blog/perl-weekly-challenge-260/
/*#

Task 2: Dictionary Rank

Submitted by: [43]Mark Anderson
     __________________________________________________________________

   You are given a word, $word.

   Write a script to compute the dictionary rank of the given word.

Example 1

Input: $word = 'CAT'
Output: 3

All possible combinations of the letters:
CAT, CTA, ATC, TCA, ACT, TAC

Arrange them in alphabetical order:
ACT, ATC, CAT, CTA, TAC, TCA

CAT is the 3rd in the list.
Therefore the dictionary rank of CAT is 3.

Example 2

Input: $word = 'GOOGLE'
Output: 88

Example 3

Input: $word = 'SECRET'
Output: 255
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 17th March
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"slices"
	"strings"

	"github.com/google/go-cmp/cmp"
)

func dc(word string) int {
	var res string
	s := strings.Split(permute(word, "", &res), " ")
	slices.Sort(s)
	l := len(s)
	i, j := 0, l
	for j > 1 {
		if s[i] == s[i+1] {
			copy(s[i:], s[i+1:])
			l--
		} else {
			i++
		}
		j--
	}
	return slices.Index(s, word) + 1
}

func permute(s, t string, res *string) string {
	if len(s) > 0 {
		for i, v := range []byte(s) {
			permute(s[:i]+s[i+1:], t+string(v), res)
		}
	} else {
		*res += " " + t
		return ""
	}
	return (*res)[1:]
}

func main() {
	for _, data := range []struct {
		input  string
		output int
	}{
		{"CAT", 3},
		{"GOOGLE", 88},
		{"SECRET", 255},
	} {
		io.WriteString(os.Stdout, cmp.Diff(dc(data.input), data.output)) // blank if ok, otherwise show the differences
	}
}
