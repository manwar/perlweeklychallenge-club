//# https://theweeklychallenge.org/blog/perl-weekly-challenge-234/
/*#

Task 2: Unequal Triplets

Submitted by: [44]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of positive integers.

   Write a script to find the number of triplets (i, j, k) that satisfies
   num[i] != num[j], num[j] != num[k] and num[k] != num[i].

Example 1

Input: @ints = (4, 4, 2, 4, 3)
Ouput: 3

(0, 2, 4) because 4 != 2 != 3
(1, 2, 4) because 4 != 2 != 3
(2, 3, 4) because 2 != 4 != 3

Example 2

Input: @ints = (1, 1, 1, 1, 1)
Ouput: 0

Example 3

Input: @ints = (4, 7, 1, 10, 7, 4, 1, 1)
Output: 28

triplets of 1, 4, 7  = 3x2×2 = 12 combinations
triplets of 1, 4, 10 = 3×2×1 = 6  combinations
triplets of 4, 7, 10 = 2×2×1 = 4  combinations
triplets of 1, 7, 10 = 3x2x1 = 6 combinations
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 17th September
   2023.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
*/
package main

import (
	"fmt"
	"strings"
)

func main() {
	for _, data := range []struct {
		inpt []int
		otpt int
	}{
		{[]int{4, 4, 2, 4, 3}, 3},
		{[]int{1, 1, 1, 1, 1}, 0},
		{[]int{4, 7, 1, 10, 7, 4, 1, 1}, 28},
	} {
		fmt.Println(utCount(data.inpt) == data.otpt)
	}
}

func utCount(s []int) (count int) {
	l := len(s)
	m := make(map[int]int)
	var c string
	for _, idxs := range strings.Split(combo(3, string(ibytes(l)), "", &c, byte(l)), string(byte(l))) {
		for _, v := range []byte(idxs) {
			m[s[int(v)]]++
		}
		if len(m) == 3 {
			count++
		}
		clear(m)
	}
	return count
}
func ibytes(n int) []byte {
	b := make([]byte, n)
	for i := 0; i < n; i++ {
		b[i] = byte(i)
	}
	return b
}
func combo(r int, e, c string, res *string, sep byte) string {
	lc, le := len(c), len(e)
	if lc == r || lc+le == r {
		*res += string(sep) + (c + e)[:r]
		return ""
	} else {
		for i := 0; i <= lc+le-r; i++ {
			combo(r, e[i+1:], c+string(e[i]), res, sep)
		}
	}
	return (*res)[1:]
}
