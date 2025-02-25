//# https://theweeklychallenge.org/blog/perl-weekly-challenge-303/
/*#

Task 2: Delete and Earn

Submitted by: [40]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to return the maximum number of points you can earn by
   applying the following operation some number of times.
Pick any ints[i] and delete it to earn ints[i] points.
Afterwards, you must delete every element equal to ints[i] - 1
and every element equal to ints[i] + 1.

Example 1

Input: @ints = (3, 4, 2)
Output: 6

Delete 4 to earn 4 points, consequently, 3 is also deleted.
Finally delete 2 to earn 2 points.

Example 2

Input: @ints = (2, 2, 3, 3, 3, 4)
Output: 9

Delete a 3 to earn 3 points. All 2's and 4's are also deleted too.
Delete a 3 again to earn 3 points.
Delete a 3 once more to earn 3 points.
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 12^th January
   2025.
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

type ints []int

func (is ints) intc() intc {
	ic := make(intc)
	for _, v := range is {
		ic[v]++
	}
	return ic
}

type intc map[int]int

func (ic intc) check(n int) (int, func() int) {
	score := n * ic[n]
	return score - (n-1)*ic[n-1] - (n+1)*ic[n+1], func() int {
		for i := -1; i < 2; i++ {
			delete(ic, n+i)
		}
		return score
	}
}

func (ic intc) dae() int {
	score := 0
	for len(ic) > 0 {
		var (
			mx []int
			fx func() int
		)
		for n := range ic {
			if len(mx) == 0 {
				mx = make([]int, 1)
				mx[0], fx = ic.check(n)
				continue
			}
			if m, f := ic.check(n); m > mx[0] {
				mx[0] = m
				fx = f
			}
		}
		score += fx()
	}
	return score
}

func main() {
	for _, data := range []struct {
		input  ints
		output int
	}{
		{ints{3, 4, 2}, 6},
		{ints{2, 2, 3, 3, 3, 4}, 9},
		{ints{2, 2, 3, 3, 3, 4, 4}, 12},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.intc().dae(), data.output)) // blank if ok, otherwise show the difference
	}
}
