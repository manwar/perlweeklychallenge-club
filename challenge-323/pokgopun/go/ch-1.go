//# https://theweeklychallenge.org/blog/perl-weekly-challenge-323/
/*#

Task 1: Increment Decrement

Submitted by: [47]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list of operations.

   Write a script to return the final value after performing the given
   operations in order. The initial value is always 0.
Possible Operations:
++x or x++: increment by 1
--x or x--: decrement by 1

Example 1

Input: @operations = ("--x", "x++", "x++")
Output: 1

Operation "--x" =>  0 - 1 => -1
Operation "x++" => -1 + 1 =>  0
Operation "x++" =>  0 + 1 =>  1

Example 2

Input: @operations = ("x++", "++x", "x++")
Output: 3

Example 3

Input: @operations = ("x++", "++x", "--x", "x--")
Output: 0

Operation "x++" => 0 + 1 => 1
Operation "++x" => 1 + 1 => 2
Operation "--x" => 2 - 1 => 1
Operation "x--" => 1 - 1 => 0

Task 2: Tax Amount
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type operations []string

func (ops operations) process() int {
	r := 0
	sigm := byte('-')
	sigp := byte('+')
	for _, op := range ops {
		for _, sig := range []byte{op[0], op[2]} {
			if sig == sigm {
				r--
			} else if sig == sigp {
				r++
			} else {
				continue
			}
			break
		}
	}
	return r
}

func main() {
	for _, data := range []struct {
		input  operations
		output int
	}{
		{operations{"--x", "x++", "x++"}, 1},
		{operations{"x++", "++x", "x++"}, 3},
		{operations{"x++", "++x", "--x", "x--"}, 0},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
