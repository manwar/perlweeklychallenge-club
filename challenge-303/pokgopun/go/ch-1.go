//# https://theweeklychallenge.org/blog/perl-weekly-challenge-303/
/*#

Task 1: 3-digits Even

Submitted by: [39]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list (3 or more) of positive integers, @ints.

   Write a script to return all even 3-digits integers that can be formed
   using the integers in the given list.

Example 1

Input: @ints = (2, 1, 3, 0)
Output: (102, 120, 130, 132, 210, 230, 302, 310, 312, 320)

Example 2

Input: @ints = (2, 2, 8, 8, 2)
Output: (222, 228, 282, 288, 822, 828, 882)

Task 2: Delete and Earn
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"iter"
	"os"
	"slices"
	"strconv"

	"github.com/google/go-cmp/cmp"
)

// transcibed from https://docs.python.org/3/library/itertools.html#itertools.permutations
func permute[S ~[]E, E any](s S, r int) iter.Seq[S] {
	return func(yield func(S) bool) {
		n := len(s)
		idxs := make([]int, n)
		for i := 0; i < n; i++ {
			idxs[i] = i
		}
		ccls := make([]int, r)
		for i := 0; i < r; i++ {
			ccls[i] = n - i
		}
		p := make(S, r)
		copy(p, s)
		if !yield(p) {
			return
		}
		for {
			i := r
			for {
				i--
				ccls[i] -= 1
				if ccls[i] == 0 {
					copy(idxs[i:], append(idxs[i+1:], idxs[i]))
					ccls[i] = n - i
				} else {
					j := ccls[i]
					idxs[i], idxs[n-j] = idxs[n-j], idxs[i]
					//p := make(S, r)
					for k := 0; k < r; k++ {
						p[k] = s[idxs[k]]
					}
					if !yield(p) {
						return
					}
					break
				}
				if i == 0 {
					return
				}
			}
		}
	}
}

type ints []int

func (is ints) digit() int {
	l := len(is)
	t := 1
	for i := 0; i < l-1; i++ {
		t *= 10
	}
	c := 0
	for i := 0; i < l; i++ {
		c += is[i] * t
		t /= 10
	}
	return c
}

func (is ints) tde() ints {
	var s ints
	seen := map[string]bool{}
	for p := range permute(is, 3) {
		if p[0] == 0 || p[2]%2 == 1 {
			continue
		}
		d := p.digit()
		str := strconv.Itoa(d)
		if !seen[str] {
			seen[str] = true
			s = append(s, d)
		}
	}
	slices.Sort(s)
	return s
}

func main() {
	for _, data := range []struct {
		input, output ints
	}{
		{ints{2, 1, 3, 0}, ints{102, 120, 130, 132, 210, 230, 302, 310, 312, 320}},
		{ints{2, 2, 8, 8, 2}, ints{222, 228, 282, 288, 822, 828, 882}},
	} {
		//fmt.Println(data.input.tde())
		io.WriteString(os.Stdout, cmp.Diff(data.input.tde(), data.output)) // blank if ok, otherwise show the difference
	}
}
