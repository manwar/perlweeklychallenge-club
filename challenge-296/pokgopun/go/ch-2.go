//# https://theweeklychallenge.org/blog/perl-weekly-challenge-296/
/*#

Task 2: Matchstick Square

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to find if it is possible to make one square using the
   sticks as in the given array @ints where $ints[ì] is the length of ith
   stick.

Example 1

Input: @ints = (1, 2, 2, 2, 1)
Output: true

Top: $ints[1] = 2
Bottom: $ints[2] = 2
Left: $ints[3] = 2
Right: $ints[0] and $ints[4] = 2

Example 2

Input: @ints = (2, 2, 2, 4)
Output: false

Example 3

Input: @ints = (2, 2, 2, 2, 4)
Output: false

Example 4

Input: @ints = (3, 4, 1, 4, 3, 1)
Output: true
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 24th November
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"iter"
	"os"

	"github.com/google/go-cmp/cmp"
)

func Combinator[V any, S ~[]V](e S, r int) iter.Seq[S] {
	return func(yield func(S) bool) {
		l := len(e)
		var d, i, j int
		c := make(S, r)
		for n := 1<<r - 1; n < 1<<l-1<<(l-r)+1; n++ {
			d, i, j = n, 0, 0
			for d > 0 {
				if d%2 > 0 {
					if j == r {
						j = 0
						break
					}
					c[j] = e[i]
					j++
				}
				i++
				d /= 2
			}
			if r == j {
				if !yield(c[:j]) {
					break
				}
			}
			clear(c)
		}
	}
}

type indexes []int

func (idxs indexes) contains(i int) bool {
	for _, v := range idxs {
		if v == i {
			return true
		}
	}
	return false
}

type ints []int

func (is ints) indexes() indexes {
	idxs := make(indexes, len(is))
	for i := range is {
		idxs[i] = i
	}
	return idxs
}

func (is ints) sum() int {
	c := 0
	for _, v := range is {
		c += v
	}
	return c
}

func (is ints) sub(idxs indexes) ints {
	l := len(idxs)
	r := make(ints, l)
	for i := range l {
		r[i] = is[idxs[i]]
	}
	return r
}

func (is ints) subi(idxs indexes) ints {
	l := len(is)
	r := make(ints, l-len(idxs))
	i := 0
	for j := range l {
		if idxs.contains(j) {
			continue
		}
		r[i] = is[j]
		i++
	}
	return r
}

func (is ints) hsv() bool {
	v := is[0]
	for _, e := range is[1:] {
		if e != v {
			return false
		}
	}
	return true
}

func (is ints) mss(n int) bool {
	l := len(is)
	switch {
	case n == 1:
		return l > 0
	case l == 0:
		return n == 0
	case l < n:
		return false
	case l == n:
		return is.hsv()
	}
	sm := is.sum()
	sl := sm / n
	if sl*n != sm {
		return false
	}
	idxs := is.indexes()
	for r := range l - n + 1 {
		r++
		for cmb := range Combinator(idxs, r) {
			if is.sub(cmb).sum() != sl {
				continue
			}
			if is.subi(cmb).mss(n - 1) {
				return true
			}
		}
	}
	return false
}

func (is ints) matchStickSquare() bool {
	return is.mss(4)
}

func (is ints) matchStickTriangle() bool {
	return is.mss(3)
}

func (is ints) matchStickDuo() bool {
	return is.mss(2)
}

func main() {
	for _, data := range []struct {
		input  ints
		output bool
	}{
		{ints{1, 2, 2, 2, 1}, true},
		{ints{2, 2, 2, 4}, false},
		{ints{2, 2, 2, 2, 4}, false},
		{ints{3, 4, 1, 4, 3, 1}, true},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.matchStickSquare(), data.output)) // blank if ok, otherwise show the difference
	}
	for _, data := range []struct {
		input  ints
		output bool
	}{
		{ints{1, 2, 2, 1}, true},
		{ints{3, 2, 3, 1}, true},
		{ints{1, 2, 1, 2, 4}, false},
		{ints{2, 1, 1, 2, 2, 1}, true},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.matchStickTriangle(), data.output)) // blank if ok, otherwise show the difference
	}
	for _, data := range []struct {
		input  ints
		output bool
	}{
		{ints{1, 2, 2, 1}, true},
		{ints{3, 2, 3, 1}, false},
		{ints{1, 2, 1, 2, 4}, true},
		{ints{2, 1, 1, 2, 2, 1}, false},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.matchStickDuo(), data.output)) // blank if ok, otherwise show the difference
	}
}
