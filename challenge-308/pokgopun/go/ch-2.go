//# https://theweeklychallenge.org/blog/perl-weekly-challenge-308/
/*#

Task 2: Decode XOR

Submitted by: [47]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an encoded array and an initial integer.

   Write a script to find the original array that produced the given
   encoded array. It was encoded such that encoded[i] = orig[i] XOR orig[i
   + 1].

Example 1

Input: @encoded = (1, 2, 3), $initial = 1
Output: (1, 0, 2, 1)

Encoded array created like below, if the original array was (1, 0, 2, 1)
$encoded[0] = (1 xor 0) = 1
$encoded[1] = (0 xor 2) = 2
$encoded[2] = (2 xor 1) = 3

Example 2

Input: @encoded = (6, 2, 7, 3), $initial = 4
Output: (4, 2, 0, 7, 4)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 16^th February
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

type input struct {
	enc  ints
	init int
}

func (in input) process() ints {
	enc := in.enc
	l := len(enc)
	org := make(ints, l+1)
	org[0] = in.init
	for i := range l {
		orgn := 0
		switch {
		case enc[i] == org[i]:
		case enc[i] == 0:
			orgn = org[i]
		case org[i] == 0:
			orgn = enc[i]
		default:
			b := 1
			dst, src := enc[i], org[i]
			if dst < src {
				dst, src = src, dst
			}
			for dst > 0 {
				o := dst%2 - src%2
				if o < 0 {
					o = 1
				}
				orgn += b * o
				b *= 2
				dst /= 2
				src /= 2
			}
		}
		org[i+1] = orgn
	}
	return org
}

func main() {
	for _, data := range []struct {
		input  input
		output ints
	}{
		{input{ints{1, 2, 3}, 1}, ints{1, 0, 2, 1}},
		{input{ints{6, 2, 7, 3}, 4}, ints{4, 2, 0, 7, 4}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
