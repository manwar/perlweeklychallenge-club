//# https://theweeklychallenge.org/blog/perl-weekly-challenge-294/
/*#

Task 2: Next Permutation

Submitted by: [40]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to find out the next permutation of the given array.

     The next permutation of an array of integers is the next
     lexicographically greater permutation of its integer.

Example 1

Input: @ints = (1, 2, 3)
Output: (1, 3, 2)

Permutations of (1, 2, 3) arranged lexicographically:
(1, 2, 3)
(1, 3, 2)
(2, 1, 3)
(2, 3, 1)
(3, 1, 2)
(3, 2, 1)

Example 2

Input: @ints = (2, 1, 3)
Output: (2, 3, 1)

Example 3

Input: @ints = (3, 1, 2)
Output: (3, 2, 1)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 10th November
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

func factorial(n uint) uint {
	if n == 0 {
		return 1
	}
	return n * factorial(n-1)
}

func permutation(n uint) [][]uint {
	fact := factorial(n)
	s := make([][]uint, fact)
	for r := uint(0); r < fact; r++ {
		s[r] = rank2permutation(n, r)
	}
	return s
}

func permutation2rank(p []uint) uint {
	n := uint(len(p))
	fact := factorial(n - 1)
	var r uint = 0
	digits := make([]uint, n)
	for i := uint(0); i < n; i++ {
		digits[i] = i
	}
	var q uint
	for i := uint(0); i < n-1; i++ {
		q = 0
		for digits[q] != p[i] {
			q++
		}
		r += fact * q
		digits = append(digits[:q], digits[q+1:]...)
		fact /= n - 1 - i
	}
	return r
}

func rank2permutation(n, r uint) []uint {
	fact := factorial(n - 1)
	if r > fact*n-1 {
		return []uint{}
	}
	digits := make([]uint, uint(n))
	for i := uint(0); i < n; i++ {
		digits[i] = i
	}
	p := []uint{}
	var q uint
	for i := uint(0); i < n; i++ {
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

func np(p []uint) []uint {
	l := len(p)
	for i := range l {
		p[i] -= 1
	}
	r := permutation2rank(p)
	n := rank2permutation(uint(l), r+1)
	for i := range l {
		n[i]++
	}
	return n
}

func main() {
	for _, data := range []struct {
		input, output []uint
	}{
		{[]uint{1, 2, 3}, []uint{1, 3, 2}},
		{[]uint{2, 1, 3}, []uint{2, 3, 1}},
		{[]uint{3, 1, 2}, []uint{3, 2, 1}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(np(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
