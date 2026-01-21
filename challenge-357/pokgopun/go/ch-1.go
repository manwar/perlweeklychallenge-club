//# https://theweeklychallenge.org/blog/perl-weekly-challenge-357/
/*#

Task 1: Kaprekar Constant

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   Write a function that takes a 4-digit integer and returns how many
   iterations are required to reach Kaprekar’s constant (6174). For more
   information about Kaprekar's Constant please follow the [44]wikipedia
   page.

Example 1

Input: $int = 3524
Output: 3

Iteration 1: 5432 - 2345 = 3087
Iteration 2: 8730 - 0378 = 8352
Iteration 3: 8532 - 2358 = 6174

Example 2

Input: $int = 6174
Output: 0

Example 3

Input: $int = 9998
Output: 5

Iteration 1: 9998 - 8999 = 0999
Iteration 2: 9990 - 0999 = 8991
Iteration 3: 9981 - 1899 = 8082
Iteration 4: 8820 - 0288 = 8532
Iteration 5: 8532 - 2358 = 6174

Example 4

Input: $int = 1001
Output: 4

Iteration 1: 1100 - 0011 = 1089
Iteration 2: 9810 - 0189 = 9621
Iteration 3: 9621 - 1269 = 8352
Iteration 4: 8532 - 2358 = 6174

Example 5

Input: $int = 9000
Output: 4

Iteration 1: 9000 - 0009 = 8991
Iteration 2: 9981 - 1899 = 8082
Iteration 3: 8820 - 0288 = 8532
Iteration 4: 8532 - 2358 = 6174

Example 6

Input: $int = 1111
Output: -1

The sequence does not converge on 6174, so return -1.

Task 2: Unique Fraction Generator
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"errors"
	"io"
	"iter"
	"log"
	"os"
	"slices"

	"github.com/google/go-cmp/cmp"
)

const KC = 6174

type Ints []int

func NewInts(ints ...int) Ints {
	slices.Sort(ints)
	return Ints(ints)
}

func (in Ints) FRDiff() int {
	i := len(in)
	t := 1
	diff := 0
	for _, v := range in {
		i--
		diff += t * (v - in[i])
		t *= 10
	}
	return diff
}

func (in Ints) UniqCount() int {
	c := 0
	l := len(in)
	if l > 1 {
		c = 1
		for i := l - 1; i > 0; i-- {
			if in[i] != in[i-1] {
				c++
			}
		}
	}
	return c
}

func NewFourInts(n int) (Ints, error) {
	if n < 0 || n > 9999 {
		return Ints{}, errors.New("n has more than 4 digits")
	}
	ints := make(Ints, 4)
	i := 0
	for n > 0 {
		ints[i] = n % 10
		n /= 10
		i++
	}
	return NewInts(ints...), nil
}

func Kc(n int) int {
	c := 0
	for c <= 7 {
		if n == KC {
			break
		}
		ints, err := NewFourInts(n)
		if err != nil {
			log.Fatal(err.Error())
		}
		n = ints.FRDiff()
		if n == 0 {
			return -1
		}
		c++
		//fmt.Println(n, c)
	}
	return c
}

func FullTestSet() iter.Seq2[int, []int] {
	return func(yield func(int, []int) bool) {
		var (
			counts []int
			ints   Ints
		)
		for n := range 10000 {
			if n == KC {
				counts = []int{0}
			} else {
				ints, _ = NewFourInts(n)
				if ints.UniqCount() == 1 {
					counts = []int{-1}
				} else {
					counts = []int{1, 2, 3, 4, 5, 6, 7}
				}
			}
			if !yield(n, counts) {
				return
			}
		}
	}
}

func main() {
	for _, data := range []struct {
		input, output int
	}{
		{3524, 3},
		{6174, 0},
		{9998, 5},
		{1001, 4},
		{9000, 4},
		{1111, -1},
	} {
		//fmt.Println(data.input, "=>", data.output)
		io.WriteString(os.Stdout, cmp.Diff(Kc(data.input), data.output)) // blank if ok, otherwise show the difference
	}
	for n, counts := range FullTestSet() {
		//fmt.Println(n, "=>", counts)
		io.WriteString(os.Stdout, cmp.Diff(slices.Contains(counts, Kc(n)), true)) // blank if ok, otherwise show the difference
	}
}
