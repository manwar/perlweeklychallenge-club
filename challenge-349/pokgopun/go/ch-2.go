//# https://theweeklychallenge.org/blog/perl-weekly-challenge-349/
/*#

Task 2: Meeting Point

Submitted by: [48]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given instruction string made up of U (up), D (down), L (left)
   and R (right).

   Write a script to return true if following the instruction, you meet
   (0,0) at any point along the sequence.

Example 1

Input: $path = "ULD"
Output: false

(-1,1) <- (0,1)
   |        ^
   v        |
(-1,0)    (0,0)

Example 2

Input: $path = "ULDR"
Output: true

 (-1,1) <- (0,1)
    |        ^
    v        |
 (-1,0) -> (0,0)

Example 3

Input: $path = "UUURRRDDD"
Output: false

(0,3) -> (1,3) -> (2,3) -> (3,3)
  ^                          |
  |                          v
(0,2)                      (3,2)
  ^                          |
  |                          v
(0,1)                      (3,1)
  ^                          |
  |                          v
(0,0)                      (3,0)

Example 4

Input: $path = "UURRRDDLLL"
Output: true

(0,2) -> (1,2) -> (2,2) -> (3,2)
  ^                          |
  |                          v
(0,1)                      (3,1)
  ^                          |
  |                          v
(0,0) <- (1,0) <- (1,1) <- (3,0)

Example 5

Input: $path = "RRUULLDDRRUU"
Output: true

(0,2) <- (1,2) <- (2,2)
  |                 ^
  v                 |
(0,1)             (2,1)
  |                 ^
  v                 |
(0,0) -> (1,0) -> (2,1)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 30th November
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

func mp(str string) bool {
	var x, y int
	for _, v := range str {
		switch v {
		case 'U':
			y++
		case 'D':
			y--
		case 'L':
			x--
		case 'R':
			x++
		}
		if x == 0 && y == 0 {
			return true
		}
	}
	return false
}

func main() {
	for _, data := range []struct {
		input  string
		output bool
	}{
		{"ULD", false},
		{"ULDR", true},
		{"UUURRRDDD", false},
		{"UURRRDDLLL", true},
		{"RRUULLDDRRUU", true},
	} {
		io.WriteString(os.Stdout, cmp.Diff(mp(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
