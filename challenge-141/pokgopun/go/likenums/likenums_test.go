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

import "testing"

func TestCount(t *testing.T) {
	data := []struct {
		m, n, o uint
		errMsg  string
	}{
		{1234, 2, 9, ""},
		{1234, 1, 14, ""},
		{768, 4, 3, ""},
		{768, 1, 6, ""},
		{7, 1, 0, "must have at least two digits"},
		{43212, 1, 0, "repeating of digits are not allowed"},
		{78, 0, 0, "divisor must be greater than zero"},
	}
	for _, d := range data {
		res, err := Count(d.m, d.n)
		if res != d.o {
			t.Errorf("incorrect result: expected %d, got %d", d.o, res)
		}
		var errMsg string
		if err != nil {
			errMsg = err.Error()
		}
		if errMsg != d.errMsg {
			t.Errorf("Expected error message `%s`, got `%s`", d.errMsg, errMsg)
		}
	}
}
