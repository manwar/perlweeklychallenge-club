//# https://theweeklychallenge.org/blog/perl-weekly-challenge-301/
/*#

Task 2: Hamming Distance

Submitted by: [72]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to return the sum of Hamming distances between all the
   pairs of the integers in the given array of integers.
The Hamming distance between two integers is the number of places in which their
 binary representations differ.

Example 1

Input: @ints = (4, 14, 2)
Output: 6

Binary representation:
4  => 0100
14 => 1110
2  => 0010

HammingDistance(4, 14) + HammingDistance(4, 2) + HammingDistance(14, 2) = 2 + 2
+ 2 = 6.

Example 2

Input: @ints = (4, 14, 4)
Output: 4
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 29^th December
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
	"strconv"

	"github.com/google/go-cmp/cmp"
)

type ints []int

func (is ints) hammings() iter.Seq[hamming] {
	return func(yield func(hamming) bool) {
		l := len(is)
		for i := range l - 1 {
			for j := i + 1; j < l; j++ {
				if !yield(hamming{is[i], is[j]}) {
					return
				}
			}
		}
	}
}

func (is ints) hd() int {
	c := 0
	for h := range is.hammings() {
		c += h.distance()
	}
	return c
}

type hamming [2]int

func (hm hamming) distance() int {
	b1 := strconv.FormatInt(int64(hm[0]), 2)
	b2 := strconv.FormatInt(int64(hm[1]), 2)
	l1 := len(b1)
	l2 := len(b2)
	l := l1 - l2
	if l < 0 {
		l *= -1
		for i := 0; i < l; i++ {
			b1 = "0" + b1
		}
	} else if l > 0 {
		for i := 0; i < l; i++ {
			b2 = "0" + b2
		}
	}
	c := 0
	for i := range len(b1) {
		if b1[i] != b2[i] {
			c++
		}
	}
	return c
}

func main() {
	for _, data := range []struct {
		input  ints
		output int
	}{
		{ints{4, 14, 2}, 6},
		{ints{4, 14, 4}, 4},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.hd(), data.output)) // blank if ok, otherwise show the difference
	}
}
