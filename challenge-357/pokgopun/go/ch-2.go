//# https://theweeklychallenge.org/blog/perl-weekly-challenge-357/
/*#

Task 2: Unique Fraction Generator

Submitted by: Yary
     __________________________________________________________________

   Given a positive integer N, generate all unique fractions you can
   create using integers from 1 to N and follow the rules below:
- Use numbers 1 through N only (no zero)
- Create fractions like numerator/denominator
- List them in ascending order (from smallest to largest)
- If two fractions have the same value (like 1/2 and 2/4),
  only show the one with the smallest numerator

Example 1

Input: $int = 3
Output: 1/3, 1/2, 2/3, 1/1, 3/2, 2/1, 3/1

Example 2

Input: $int = 4
Output: 1/4, 1/3, 1/2, 2/3, 3/4, 1/1, 4/3, 3/2, 2/1, 3/1, 4/1

Example 3

Input: $int = 1
Output: 1/1

Example 4

Input: $int = 6
Output: 1/6, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4,
        4/5, 5/6, 1/1, 6/5, 5/4, 4/3, 3/2, 5/3, 2/1,
        5/2, 3/1, 4/1, 5/1, 6/1

Example 5

Input: $int = 5
Output: 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1,
        5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 25th January
   2026.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"cmp"
	"io"
	"os"
	"slices"
	"strconv"
	"strings"

	gocmp "github.com/google/go-cmp/cmp"
)

type fraction struct {
	nmrt, dmnt int
}

func (f fraction) val() float64 {
	return float64(f.nmrt) / float64(f.dmnt)
}

type fractions []fraction

func (fs fractions) String() string {
	var b strings.Builder
	for _, v := range fs {
		b.WriteRune(',')
		b.WriteRune(' ')
		b.WriteString(strconv.Itoa(v.nmrt))
		b.WriteRune('/')
		b.WriteString(strconv.Itoa(v.dmnt))
	}
	return b.String()[2:]
}

func ufc(n int) string {
	var fs fractions
	for i := range n {
		for j := range n {
			fs = append(fs, fraction{i + 1, j + 1})
		}
	}
	slices.SortFunc(fs, func(a, b fraction) int {
		return cmp.Compare(a.val(), b.val())
	})
	e := 1e-9
	l := len(fs)
	c := 0
	i := l
	for i > 1 {
		i--
		a, b := fs[i-1], fs[i]
		d := a.val() - b.val()
		if d < 0 {
			d *= -1
		}
		if d < e {
			c++
			if a.nmrt > b.nmrt {
				copy(fs[i-1:], fs[i:])
			} else {
				copy(fs[i:], fs[i+1:])
			}
		}
	}
	return fs[:l-c].String()
}

func main() {
	for _, data := range []struct {
		input  int
		output string
	}{
		{3, "1/3, 1/2, 2/3, 1/1, 3/2, 2/1, 3/1"},
		{4, "1/4, 1/3, 1/2, 2/3, 3/4, 1/1, 4/3, 3/2, 2/1, 3/1, 4/1"},
		{1, "1/1"},
		{6, "1/6, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 5/6, 1/1, 6/5, 5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1, 6/1"},
		{5, "1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1, 5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1"},
	} {
		io.WriteString(os.Stdout, gocmp.Diff(ufc(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
