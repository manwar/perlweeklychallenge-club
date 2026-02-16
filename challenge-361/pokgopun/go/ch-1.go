//# https://theweeklychallenge.org/blog/perl-weekly-challenge-361/
/*#

Task 1: Zeckendorf Representation

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a positive integer (<= 100).

   Write a script to return Zeckendorf Representation of the given
   integer.

     Every positive integer can be uniquely represented as sum of
     non-consecutive Fibonacci numbers.

Example 1

Input: $int = 4
Output: 3,1

4 => 3 + 1 (non-consecutive fibonacci numbers)

Example 2

Input: $int = 12
Output: 8,3,1

12 => 8 + 3 + 1

Example 3

Input: $int = 20
Output: 13,5,2

20 => 13 + 5 + 2

Example 4

Input: $int = 96
Output: 89,5,2

96 => 89 + 5 + 2

Example 5

Input: $int = 100
Output: 89,8,3

100 => 89 + 8 + 3

Task 2: Find Celebrity
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type ints []int

func zkd(n int) ints {
	if n <= 3 {
		return []int{n}
	}
	fib := []int{0, 1, 1, 2, 3}
	i := 4
	for fib[i] < n {
		fib = append(fib, fib[i]+fib[i-1])
		i++
	}
	var s ints
	for n > 0 {
		v := fib[i]
		i--
		if v <= n {
			s = append(s, v)
			n -= v
		}
	}
	return s
}

func main() {
	for _, data := range []struct {
		input  int
		output ints
	}{
		{4, ints{3, 1}},
		{12, ints{8, 3, 1}},
		{20, ints{13, 5, 2}},
		{96, ints{89, 5, 2}},
		{100, ints{89, 8, 3}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(zkd(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
