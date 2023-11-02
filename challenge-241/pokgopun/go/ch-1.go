//# https://theweeklychallenge.org/blog/perl-weekly-challenge-241/
/*#

Task 1: Arithmetic Triplets

Submitted by: [42]Mohammad S Anwar
     __________________________________________________________________

   You are given an array (3 or more members) of integers in increasing
   order and a positive integer.

   Write a script to find out the number of unique Arithmetic Triplets
   satisfying the following rules:
a) i < j < k
b) nums[j] - nums[i] == diff
c) nums[k] - nums[j] == diff

Example 1

Input: @nums = (0, 1, 4, 6, 7, 10)
       $diff = 3
Output: 2

Index (1, 2, 4) is an arithmetic triplet because both  7 - 4 == 3 and 4 - 1 == 3
.
Index (2, 4, 5) is an arithmetic triplet because both 10 - 7 == 3 and 7 - 4 == 3
.

Example 2

Input: @nums = (4, 5, 6, 7, 8, 9)
       $diff = 2
Output: 2

(0, 2, 4) is an arithmetic triplet because both 8 - 6 == 2 and 6 - 4 == 2.
(1, 3, 5) is an arithmetic triplet because both 9 - 7 == 2 and 7 - 5 == 2.

Task 2: Prime Order
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"fmt"
	"strings"
)

func main() {
	for _, data := range []struct {
		nums        []int
		diff, count int
	}{
		{[]int{0, 1, 4, 6, 7, 10}, 3, 2},
		{[]int{4, 5, 6, 7, 8, 9}, 2, 2},
	} {
		fmt.Println(uatCount(data.nums, data.diff) == data.count)
	}
}

func uatCount(s []int, d int) (count int) {
	l := len(s)
	t := make([]int, 3)
	var c string
	for _, idxs := range strings.Split(combo(3, string(ibytes(l)), "", &c, byte(l)), string(byte(l))) {
		for i, v := range []byte(idxs) {
			t[i] = s[int(v)]
		}
		if t[1]-t[0] == d && 2*t[1] == t[0]+t[2] {
			count++
		}
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
