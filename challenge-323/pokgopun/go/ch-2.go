//# https://theweeklychallenge.org/blog/perl-weekly-challenge-323/
/*#

Task 2: Tax Amount

Submitted by: [48]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an income amount and tax brackets.

   Write a script to calculate the total tax amount.

Example 1

Input: $income = 10, @tax = ([3, 50], [7, 10], [12,25])
Output: 2.65

1st tax bracket upto  3, tax is 50%.
2nd tax bracket upto  7, tax is 10%.
3rd tax bracket upto 12, tax is 25%.

Total Tax => (3 * 50/100) + (4 * 10/100) + (3 * 25/100)
          => 1.50 + 0.40 + 0.75
          => 2.65

Example 2

Input: $income = 2, @tax = ([1, 0], [4, 25], [5,50])
Output: 0.25

Total Tax => (1 * 0/100) + (1 * 25/100)
          => 0 + 0.25
          => 0.25

Example 3

Input: $income = 0, @tax = ([2, 50])
Output: 0
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 1st June 2025.
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

type taxb struct {
	ceil, perc float64
}

type taxbs []taxb

type input struct {
	income float64
	tax    taxbs
}

func (in input) process() float64 {
	var floor float64
	var ttax, taxt float64
	for _, tb := range in.tax {
		if in.income >= tb.ceil {
			taxt = tb.ceil - floor
		} else {
			taxt = in.income - floor
		}
		ttax += taxt * tb.perc / 100
		if in.income <= tb.ceil {
			break
		}
		floor = tb.ceil
	}
	return ttax
}

func main() {
	for _, data := range []struct {
		input  input
		output float64
	}{
		{input{10, taxbs{taxb{3, 50}, taxb{7, 10}, taxb{12, 25}}}, 2.65},
		{input{2, taxbs{taxb{1, 0}, taxb{4, 25}, taxb{5, 50}}}, 0.25},
		{input{0, taxbs{taxb{2, 50}}}, 0},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
