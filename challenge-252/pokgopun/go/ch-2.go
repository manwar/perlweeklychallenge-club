//# https://theweeklychallenge.org/blog/perl-weekly-challenge-252/
/*#

Task 2: Unique Sum Zero

Submitted by: [46]Mohammad S Anwar
     __________________________________________________________________

   You are given an integer, $n.

   Write a script to find an array containing $n unique integers such that
   they add up to zero.

Example 1

Input: $n = 5
Output: (-7, -1, 1, 3, 4)

Two other possible solutions could be as below:
(-5, -1, 1, 2, 3) and (-3, -1, 2, -2, 4).

Example 2

Input: $n = 3
Output: (-1, 0, 1)

Example 3

Input: $n = 1
Output: (0)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 21st January
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

	"github.com/google/go-cmp/cmp"
)

func isUsz(n int, s []int) bool {
	slices.Sort(s)
	l := 0
	for i := 1; i < n; i++ {
		l -= i
	}
	p := make([]int, n-l)
	for i := 0; i < n-l; i++ {
		p[i] = l + i
	}
	for v := range Combinations(p, uint(n)) {
		sum := 0
		for _, i := range v {
			sum += i
		}
		if sum == 0 && cmp.Diff(v, s) == "" {
			return true
		}
	}
	return false
}

type ints []int

func main() {
	for _, data := range []struct {
		n   int
		arr ints
		res bool
	}{
		{5, ints{-7, -1, 1, 3, 4}, true},
		{5, ints{-5, -1, 1, 2, 3}, true},
		{5, ints{-3, -1, 2, -2, 4}, true},
		{3, ints{-1, 0, 1}, true},
		{1, ints{0}, true},
		{5, ints{-6, -1, 1, 3, 4}, false},
		{5, ints{-5, 1, 1, 2, 3}, false},
		{5, ints{-3, -1, 1, 2, 4}, false},
		{3, ints{-2, 0, 1}, false},
		{1, ints{1}, false},
	} {
		io.WriteString(os.Stdout, cmp.Diff(isUsz(data.n, data.arr), data.res)) // blank if ok, otherwise show the difference
	}
}

// transcribed from https://docs.python.org/3/library/itertools.html#itertools.combinations
func Combinations[E any](s []E, r uint) chan []E {
	res := make(chan []E)
	n := uint(len(s))
	if r > n {
		go func() {
			res <- []E{}
			close(res)
		}()
		return res
	}
	go func() {
		res <- s[:r]
		idx := make([]uint, r)
		for i := range idx {
			idx[i] = uint(i)
		}
		var i, j uint
		for {
			i = r
			for {
				i--
				if idx[i] != i+n-r {
					break
				}
				if i > 0 {
					continue
				}
				close(res)
				return
			}
			idx[i]++
			j = i + 1
			for j < r {
				idx[j] = idx[j-1] + 1
				j++
			}
			result := make([]E, r)
			i = 0
			for _, v := range idx {
				result[i] = s[v]
				i++
			}
			res <- result
		}
		close(res)
	}()
	return res
}
