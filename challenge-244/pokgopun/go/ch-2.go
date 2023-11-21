//# https://theweeklychallenge.org/blog/perl-weekly-challenge-244/
/*#

Task 2: Group Hero

Submitted by: [46]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of integers representing the strength.

   Write a script to return the sum of the powers of all possible
   combinations; power is defined as the square of the largest number in a
   sequence, multiplied by the smallest.

Example 1

Input: @nums = (2, 1, 4)
Output: 141

Group 1: (2) => square(max(2)) * min(2) => 4 * 2 => 8
Group 2: (1) => square(max(1)) * min(1) => 1 * 1 => 1
Group 3: (4) => square(max(4)) * min(4) => 16 * 4 => 64
Group 4: (2,1) => square(max(2,1)) * min(2,1) => 4 * 1 => 4
Group 5: (2,4) => square(max(2,4)) * min(2,4) => 16 * 2 => 32
Group 6: (1,4) => square(max(1,4)) * min(1,4) => 16 * 1 => 16
Group 7: (2,1,4) => square(max(2,1,4)) * min(2,1,4) => 16 * 1 => 16

Sum: 8 + 1 + 64 + 4 + 32 + 16 + 16 => 141
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 26th November
   2023.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"fmt"
)

type mArr []int

func (ma mArr) power() int {
	mx := ma.m(true)
	return mx * mx * ma.m(false)
}

func (ma mArr) m(b bool) (m int) {
	l := len(ma)
	f := func(x, y int) int {
		if b {
			return max(x, y)
		}
		return min(x, y)
	}
	if l > 0 {
		m = ma[0]
		for l > 1 {
			l--
			m = f(m, ma[l])
		}
	}
	return m
}

func (ma mArr) sumOfPower() (s int) {
	l := len(ma)
	ma0 := make(mArr, l)
	var d, i, j int
	for n := 1; n < 1<<l; n++ {
		d, i, j = n, 0, 0
		for d > 0 {
			if d%2 > 0 {
				ma0[j] = ma[i]
				j++
			}
			i++
			d /= 2
		}
		s += ma0[:j].power()
		clear(ma0)
	}
	return s
}

func main() {
	for _, data := range []struct {
		input  mArr
		output int
	}{
		{mArr{2, 1, 4}, 141},
	} {
		fmt.Println(data.input.sumOfPower() == data.output)
	}
}
