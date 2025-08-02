//# https://theweeklychallenge.org/blog/perl-weekly-challenge-282/
/*#

Task 2: Changing Keys

Submitted by: [58]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an alphabetic string, $str, as typed by user.

   Write a script to find the number of times user had to change the key
   to type the given string. Changing key is defined as using a key
   different from the last used key. The shift and caps lock keys won’t be
   counted.

Example 1

Input: $str = 'pPeERrLl'
Ouput: 3

p -> P : 0 key change
P -> e : 1 key change
e -> E : 0 key change
E -> R : 1 key change
R -> r : 0 key change
r -> L : 1 key change
L -> l : 0 key change

Example 2

Input: $str = 'rRr'
Ouput: 0

Example 3

Input: $str = 'GoO'
Ouput: 1
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 18th August
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

func ck(str string) int {
	var a, b byte
	c := -1
	for i := range len(str) {
		b = a
		a = str[i]
		if a < 97 {
			a += 32
		}
		if a != b {
			c++
		}
	}
	return c
}

func main() {
	for _, data := range []struct {
		input  string
		output int
	}{
		{"pPeERrLl", 3},
		{"rRr", 0},
		{"GoO", 1},
		{"oOlong", 4},
		{"ToOlong", 5},
	} {
		io.WriteString(os.Stdout, cmp.Diff(ck(data.input), data.output)) // blank if ok, otherwise show the differece
	}
}
