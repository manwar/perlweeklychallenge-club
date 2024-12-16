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
	"iter"
	"os"

	"github.com/google/go-cmp/cmp"
)

func ba(n int) int {
	c := 0
	for p := range permutation(n) {
		i := 1
		for i <= n {
			pn := p[i-1] + 1
			if pn%i != 0 && i%pn != 0 {
				break
			}
			i++
		}
		if i > n {
			c++
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
		{10, 700},
	} {
		io.WriteString(os.Stdout, cmp.Diff(ba(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}

func factorial(n int) int {
	if n == 0 {
		return 1
	}
	return n * factorial(n-1)
}

func permutation(n int) iter.Seq[[]int] {
	return func(yield func([]int) bool) {
		fact := factorial(n)
		for r := 0; r < fact; r++ {
			if !yield(rank2permutation(n, r)) {
				break
			}
		}
	}
}

func rank2permutation(n, r int) []int {
	fact := factorial(n - 1)
	if r > fact*n-1 {
		return []int{}
	}
	digits := make([]int, n)
	for i := 0; i < n; i++ {
		digits[i] = i
	}
	p := []int{}
	var q int
	for i := 0; i < n; i++ {
		q = r / fact
		r %= fact
		p = append(p, digits[q])
		digits = append(digits[:q], digits[q+1:]...)
		if i != n-1 {
			fact /= n - 1 - i
		}
	}
	return p
}
