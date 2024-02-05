//# https://theweeklychallenge.org/blog/perl-weekly-challenge-255/
/*#

Task 2: Most Frequent Word

Submitted by: [47]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a paragraph $p and a banned word $w.

   Write a script to return the most frequent word that is not banned.

Example 1

Input: $p = "Joe hit a ball, the hit ball flew far after it was hit."
       $w = "hit"
Output: "ball"

The banned word "hit" occurs 3 times.
The other word "ball" occurs 2 times.

Example 2

Input: $p = "Perl and Raku belong to the same family. Perl is the most popular l
anguage in the weekly challenge."
       $w = "the"
Output: "Perl"

The banned word "the" occurs 3 times.
The other word "Perl" occurs 2 times.
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 11th February
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"regexp"

	"github.com/google/go-cmp/cmp"
)

func mostFreqWord(p, w string) string {
	re := regexp.MustCompile(`\w+`)
	m := make(map[string]int)
	var (
		i, mx int
		loc   []int
		r, v  string
	)
	l := len(p)
	for l-i > 1 {
		loc = re.FindStringIndex(p[i:])
		if loc == nil {
			break
		}
		v = p[loc[0]+i : loc[1]+i]
		i += loc[1]
		if v == w {
			continue
		}
		m[v]++
		if m[v] > mx {
			mx = m[v]
			r = v
		}
	}
	return r
}

func main() {
	for _, data := range []struct {
		p, w, o string
	}{
		{"Joe hit a ball, the hit ball flew far after it was hit.", "hit", "ball"},
		{"Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.", "the", "Perl"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(mostFreqWord(data.p, data.w), data.o)) // blank if ok, otherwise show the difference
	}
}
