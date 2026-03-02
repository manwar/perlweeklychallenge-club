//# https://theweeklychallenge.org/blog/perl-weekly-challenge-362/
/*#

Task 2: Spellbound Sorting

Submitted by: [46]Peter Campbell Smith
     __________________________________________________________________

   You are given an array of integers.

   Write a script to return them in alphabetical order, in any language of
   your choosing. Default language is English.

Example 1

Input: (6, 7, 8, 9 ,10)
Output: (8, 9, 7, 6, 10)

eight, nine, seven, six, ten

Example 2

Input: (-3, 0, 1000, 99)
Output: (-3, 99, 1000, 0)

minus three, ninety-nine, one thousand, zero

Example 3

Input: (1, 2, 3, 4, 5)

Output: (5, 2, 4, 3, 1) for French language
cinq, deux, quatre, trois, un

Output: (5, 4, 1, 3, 2) for English language
five, four, one, three, two

Example 4

Input: (0, -1, -2, -3, -4)
Output: (-4, -1, -3, -2, 0)

minus four, minus one, minus three, minus two, zero

Example 5

Input: (100, 101, 102)
Output: (100, 101, 102)

one hundred, one hundred and one, one hundred and two
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 1st March 2026.
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
	"strings"

	gocmp "github.com/google/go-cmp/cmp"
)

type processor struct {
	l1, l2, l3 []string
}

func newProcessor() processor {
	l1 := strings.Split("zero one two three four five six seven eight nine ten eleven twelve", " ")
	l2 := strings.Split("twent thirt fort fift sixt sevent eight ninet", " ")
	l3 := strings.Split("thousand million billion trillion quadrillion", " ") // can be extended by simply adding qunitillion, sextillion, ...
	return processor{l1, l2, l3}
}

func (pc processor) process(n int) string {
	var res string
	if n < 0 {
		res = "minus "
		n *= -1
	}
	switch {
	case n < 13:
		res += pc.l1[n]
	case n == 14:
		res += "fourteen"
	case n < 20:
		res += pc.l2[n-12] + "een"
	case n < 100:
		res += pc.l2[(n/10)-2] + "y"
		d := n % 10
		if d > 0 {
			res += "-" + pc.l1[d]
		}
	case n < 1_000:
		res += pc.l1[n/100] + " hundred"
		d := n % 100
		if d > 0 {
			res += " and " + pc.process(d)
		}
	default:
		c := -1
		t := 1
		m := n
		for m >= 1_000 {
			c++
			t *= 1_000
			m /= 1_000
		}
		res += pc.process(m) + " " + pc.l3[c]
		d := n % t
		if d > 0 {
			var sep string
			if d < 100 {
				sep = " and "
			} else {
				sep = ", "
			}
			res += sep + pc.process(d)
		}
	}
	return res
}

type ints []int

func spellboundSort(s ints) ints {
	res := make(ints, len(s))
	copy(res, s)
	if len(res) < 2 {
		return res
	}
	pc := newProcessor()
	slices.SortFunc(res, func(a, b int) int {
		return cmp.Compare(pc.process(a), pc.process(b))
	})
	return res
}

func main() {
	for _, data := range []struct {
		input, output ints
	}{
		{ints{6, 7, 8, 9, 10}, ints{8, 9, 7, 6, 10}},
		{ints{-3, 0, 1000, 99}, ints{-3, 99, 1000, 0}},
		{ints{1, 2, 3, 4, 5}, ints{5, 4, 1, 3, 2}},
		{ints{0, -1, -2, -3, -4}, ints{-4, -1, -3, -2, 0}},
		{ints{100, 101, 102}, ints{100, 101, 102}},
	} {
		io.WriteString(os.Stdout, gocmp.Diff(spellboundSort(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
