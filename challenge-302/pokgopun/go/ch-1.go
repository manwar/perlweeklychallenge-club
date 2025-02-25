//# https://theweeklychallenge.org/blog/perl-weekly-challenge-302/
/*#

Task 1: Ones and Zeroes

Submitted by: [68]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of binary strings, @str, and two integers, $x
   and $y.

   Write a script to return the size of the largest subset of @str such
   that there are at most $x 0’s and $y 1’s in the subset.
A set m is a subset of n if all elements of m are also elements of n.

Example 1

Input: @str = ("10", "0001", "111001", "1", "0")
       $x = 5
       $y = 3
Output: 4

The largest subset with at most five 0's and three 1's:
("10", "0001", "1", "0")

Example 2

Input: @str = ("10", "1", "0")
       $x = 1
       $y = 1
Output: 2

The largest subset with at most one 0's and one 1's:
("1", "0")

Task 2: Step by Step
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"iter"
	"os"

	"github.com/google/go-cmp/cmp"
)

func main() {
	for _, data := range []struct {
		bins   bins
		x, y   int
		output int
	}{
		{bins{"10", "0001", "111001", "1", "0"}, 5, 3, 4},
		{bins{"10", "1", "0"}, 1, 1, 2},
	} {
		io.WriteString(os.Stdout, cmp.Diff(oaz(data.bins, data.x, data.y), data.output)) // blank if ok, otherwise show the difference
	}
}

type bins []string

func (bs bins) sbins() [][2]int {
	s := make([][2]int, len(bs))
	for i, v := range bs {
		var z, o int
		for _, r := range v {
			switch r {
			case '0':
				z++
			case '1':
				o++
			}
		}
		s[i] = [2]int{z, o}
	}
	return s
}

func oaz(bs bins, x, y int) int {
	sbins := bs.sbins()
	l := len(bs)
	for l > 0 {
		for cmb := range Combinator(sbins, l) {
			var z, o int
			for _, v := range cmb {
				z += v[0]
				o += v[1]
			}
			if z <= x && o <= y {
				return l
			}
		}
		l--
	}
	return l
}

func Combinator[V any, S ~[]V](e S, r int) iter.Seq[S] {
	return func(yield func(S) bool) {
		l := len(e)
		var d, i, j int
		for n := 1<<r - 1; n < 1<<l-1<<(l-r)+1; n++ {
			c := make(S, r)
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
				if !yield(c) {
					break
				}
			}
		}
	}
}
