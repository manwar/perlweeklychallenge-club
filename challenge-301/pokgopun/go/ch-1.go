//# https://theweeklychallenge.org/blog/perl-weekly-challenge-301/
/*#

Task 1: Largest Number

Submitted by: [71]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list of positive integers, @ints.

   Write a script to arrange all the elements in the given list such that
   they form the largest number and return it.

Example 1

Input: @ints = (20, 3)
Output: 320

Example 2

Input: @ints = (3, 30, 34, 5, 9)
Output: 9534330

Task 2: Hamming Distance
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"slices"
	"strconv"
	"strings"

	"github.com/google/go-cmp/cmp"
)

type digits struct {
	s []int
	l int
}

func newDigits(n int) digits {
	a := strconv.Itoa(n)
	l := len(a)
	s := make([]int, l)
	for i, v := range a {
		s[i] = int(v - 48)
	}
	return digits{s, l}
}

func (ds digits) get(idx int) int {
	if idx < ds.l {
		return ds.s[idx]
	}
	return ds.s[ds.l-1]
}

type ints []int

func (is ints) ln() int {
	slices.SortFunc(is, func(b, a int) int {
		if a == b {
			return 0
		}
		ds1 := newDigits(a)
		ds2 := newDigits(b)
		l := max(ds1.l, ds2.l)
		for i := range l {
			d1 := ds1.get(i)
			d2 := ds2.get(i)
			if d1 == d2 {
				continue
			}
			return d1 - d2
		}
		return 0
	})
	var b strings.Builder
	for _, v := range is {
		b.WriteString(strconv.Itoa(v))
	}
	n, err := strconv.Atoi(b.String())
	if err != nil {
		return -1
	}
	return n
}

func main() {
	for _, data := range []struct {
		input  ints
		output int
	}{
		{ints{20, 3}, 320},
		{ints{3, 30, 34, 5, 9}, 9534330},
		{ints{4, 43, 445, 5, 8, 9}, 985445443},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.ln(), data.output)) // blank if ok, otherwise show the difference
	}
}
