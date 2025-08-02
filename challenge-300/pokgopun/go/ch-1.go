//# https://theweeklychallenge.org/blog/perl-weekly-challenge-300/
/*#

Task 1: Beautiful Arrangement

Submitted by: [54]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a positive integer, $int.

   Write a script to return the number of beautiful arrangements that you
   can construct.
A permutation of n integers, 1-indexed, is considered a beautiful arrangement
if for every i (1 <= i <= n) either of the following is true:

1) perm[i] is divisible by i
2) i is divisible by perm[i]

Example 1

Input: $n = 2
Output: 2

1st arrangement: [1, 2]
    perm[1] is divisible by i = 1
    perm[2] is divisible by i = 2
2nd arrangement: [2, 1]
    perm[1] is divisible by i = 1
    i=2 is divisible by perm[2] = 1

Example 2

Input: $n = 1
Output: 1

Example 3

Input: $n = 10
Output: 700

Task 2: Nested Array
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type processor struct {
	s, p []int
}

func ba(n int) int {
	s := make([]int, n)
	for n > 0 {
		n--
		s[n] = n + 1
	}
	return bpermute(processor{s, make([]int, len(s))})
}

func bpermute(p processor) int {
	l := len(p.s)
	if l == 0 {
		//fmt.Println(p.p)
		return 1
	}
	c := 0
	idx := len(p.p) - l + 1
	for i := range l {
		if idx%p.s[i] != 0 && p.s[i]%idx != 0 {
			continue
		}
		p.p[idx-1] = p.s[i]
		switch i {
		case 0:
			c += bpermute(processor{p.s[1:], p.p})
		case l - 1:
			c += bpermute(processor{p.s[:l-1], p.p})
		default:
			ss := make([]int, l-1)
			copy(ss[:i], p.s[:i])
			copy(ss[i:], p.s[i+1:])
			c += bpermute(processor{ss, p.p})
		}
	}
	return c
}

func main() {
	for _, data := range []struct {
		input, output int
	}{
		{2, 2},
		{1, 1},
		//	{10, 700},
	} {
		io.WriteString(os.Stdout, cmp.Diff(ba(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
