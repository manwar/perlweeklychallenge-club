//# https://theweeklychallenge.org/blog/perl-weekly-challenge-270/
/*#

Task 2: Distribute Elements

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are give an array of integers, @ints and two integers, $x and $y.

   Write a script to execute one of the two options:
Level 1:
Pick an index i of the given array and do $ints[i] += 1

Level 2:
Pick two different indices i,j and do $ints[i] +=1 and $ints[j] += 1.

   You are allowed to perform as many levels as you want to make every
   elements in the given array equal. There is cost attach for each level,
   for Level 1, the cost is $x and $y for Level 2.

   In the end return the minimum cost to get the work done.

Example 1

Input: @ints = (4, 1), $x = 3 and $y = 2
Output: 9

Level 1: i=1, so $ints[1] += 1.
@ints = (4, 2)

Level 1: i=1, so $ints[1] += 1.
@ints = (4, 3)

Level 1: i=1, so $ints[1] += 1.
@ints = (4, 4)

We perforned operation Level 1, 3 times.
So the total cost would be 3 x $x => 3 x 3 => 9

Example 2

Input: @ints = (2, 3, 3, 3, 5), $x = 2 and $y = 1
Output: 6

Level 2: i=0, j=1, so $ints[0] += 1 and $ints[1] += 1
@ints = (3, 4, 3, 3, 5)

Level 2: i=0, j=2, so $ints[0] += 1 and $ints[2] += 1
@ints = (4, 4, 4, 3, 5)

Level 2: i=0, j=3, so $ints[0] += 1 and $ints[3] += 1
@ints = (5, 4, 4, 4, 5)

Level 2: i=1, j=2, so $ints[1] += 1 and $ints[2] += 1
@ints = (5, 5, 5, 4, 5)

Level 1: i=3, so $ints[3] += 1
@ints = (5, 5, 5, 5, 5)

We perforned operation Level 1, 1 time and Level 2, 4 times.
So the total cost would be (1 x $x) + (3 x $y) => (1 x 2) + (4 x 1) => 6
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 26th May 2024.
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

func distElem(ints []int, x, y int) int {
	if len(ints) < 2 {
		return 0
	}
	slices.Sort(ints)
	l := len(ints)
	mx := ints[l-1]
	c := 0
	for {
		l = slices.Index(ints, mx)
		if l == 0 {
			break
		}
		d := mx - ints[l-1]
		if l == 1 || 2*x < y {
			for i := range l {
				ints[i] += d
				c += x * d
			}
		} else {
			p := l / 2
			for i := range p * 2 {
				ints[l-1-i] += d
			}
			c += y * p * d
		}
	}
	return c
}

func main() {
	for _, data := range []struct {
		ints       []int
		x, y, cost int
	}{
		{[]int{4, 1}, 3, 2, 9},
		{[]int{2, 3, 3, 3, 5}, 2, 1, 6},
	} {
		io.WriteString(os.Stdout, cmp.Diff(distElem(data.ints, data.x, data.y), data.cost)) // blank if ok, otherwise show the difference
	}
}
