/*
TASK #2 › Like Numbers
Submitted by: Mohammad S Anwar
You are given positive integers, $m and $n.

Write a script to find total count of integers created using the digits of $m which is also divisible by $n.

Repeating of digits are not allowed. Order/Sequence of digits can’t be altered. You are only allowed to use (n-1) digits at the most. For example, 432 is not acceptable integer created using the digits of 1234. Also for 1234, you can only have integers having no more than three digits.

Example 1:
Input: $m = 1234, $n = 2
Output: 9

Possible integers created using the digits of 1234 are:
1, 2, 3, 4, 12, 13, 14, 23, 24, 34, 123, 124, 134 and 234.

There are 9 integers divisible by 2 such as:
2, 4, 12, 14, 24, 34, 124, 134 and 234.
Example 2:
Input: $m = 768, $n = 4
Output: 3

Possible integers created using the digits of 768 are:
7, 6, 8, 76, 78 and 68.

There are 3 integers divisible by 4 such as:
8, 76 and 68.
*/
package likenums

import (
	"errors"
	"strconv"
)

func Count(m, n uint) (c uint, err error) {
	if n == 0 {
		return 0, errors.New("divisor must be greater than zero")
	}
	if m < 10 {
		return 0, errors.New("must have at least two digits")
	}
	s := strconv.FormatUint(uint64(m), 10)
	seen := make(map[byte]int)
	for _, v := range []byte(s) {
		seen[v]++
		if seen[v] > 1 {
			return 0, errors.New("repeating of digits are not allowed")
		}
	}
	l := len(s)
	var num uint64
	for i := 1; i < l; i++ {
		for _, v := range getCombo(i, s) {
			num, _ = strconv.ParseUint(v, 10, 64)
			if uint(num)%n == 0 {
				c++
			}
		}
	}
	return c, nil
}
func getCombo(n int, e string) (r []string) {
	var c string
	cTree(n, e, c, func(s string) {
		r = append(r, s)
	})
	return r
}
func cTree(n int, e string, c string, f func(s string)) {
	if len(c) == n || len(c)+len(e) == n {
		f((c + e)[:n])
	} else {
		for i := 0; len(c)+len(e)-i >= n; i++ {
			cTree(n, e[i+1:], c+string(e[i]), f)
		}
	}
}
