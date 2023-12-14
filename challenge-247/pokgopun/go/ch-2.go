//# https://theweeklychallenge.org/blog/perl-weekly-challenge-247/
/*#

Task 2: Most Frequent Letter Pair

Submitted by: [55]Jorg Sommrey
     __________________________________________________________________

   You are given a string S of lower case letters 'a'..'z'.

   Write a script that finds the pair of consecutive letters in S that
   appears most frequently. If there is more than one such pair, chose the
   one that is the lexicographically first.

Example 1

Input: $s = 'abcdbca'
Output: 'bc'

'bc' appears twice in `$s`

Example 2

Input: $s = 'cdeabeabfcdfabgcd'
Output: 'ab'

'ab' and 'cd' both appear three times in $s and 'ab' is lexicographically smalle
r than 'cd'.
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 17th December
   2023.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"strings"
)

func main() {
	var b strings.Builder
	for _, data := range []struct {
		input, output string
	}{
		{"abcdbca", "bc"},
		{"cdeabeabfcdfabgcd", "ab"},
	} {
		if data.output == mostFrequentLetterPair(data.input) {
			b.WriteString("true\n")
		} else {
			b.WriteString("false\n")
		}
	}
	io.WriteString(os.Stdout, b.String())
}

type letterPair struct {
	m  map[string]int
	mq string
}

func mostFrequentLetterPair(s string) string {
	l := len(s)
	var lp letterPair
	lp.m = make(map[string]int)
	lp.m[s[0:2]]++
	lp.mq = s[0:2]
	for i := 1; i < l-1; i++ {
		k := s[i : i+2]
		lp.m[k]++
		d := lp.m[k] - lp.m[lp.mq]
		switch {
		case d > 0:
			lp.mq = k
		case d == 0:
			if k < lp.mq {
				lp.mq = k
			}
		}
	}
	return lp.mq
}
