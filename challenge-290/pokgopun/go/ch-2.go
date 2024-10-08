//# https://theweeklychallenge.org/blog/perl-weekly-challenge-290/
/*#

Task 2: Luhn’s Algorithm

Submitted by: [46]Andrezgz
     __________________________________________________________________

   You are given a string $str containing digits (and possibly other
   characters which can be ignored). The last digit is the payload;
   consider it separately. Counting from the right, double the value of
   the first, third, etc. of the remaining digits.

   For each value now greater than 9, sum its digits.

   The correct check digit is that which, added to the sum of all values,
   would bring the total mod 10 to zero.

   Return true if and only if the payload is equal to the correct check
   digit.

   It was originally posted on [47]reddit.

Example 1

Input: "17893729974"
Output: true

Payload is 4.

Digits from the right:

7 * 2 = 14, sum = 5
9 = 9
9 * 2 = 18, sum = 19
2 = 2
7 * 2 = 14, sum = 5
3 = 3
9 * 2 = 18, sum = 19
8 = 8
7 * 2 = 14, sum = 5
1 = 1

Sum of all values = 56, so 4 must be added to bring the total mod 10 to zero. Th
e payload is indeed 4.

Example 2

Input: "4137 8947 1175 5904"
Output: true

Example 3

Input: "4137 8974 1175 5904"
Output: false
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 13th October
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

func isLuhn(str string) bool {
	l := len(str)
	l--
	chk := int(str[l] - 48)
	sm := 0
	j := false
	for l > 0 {
		l--
		if str[l] < 48 || str[l] > 57 {
			continue
		}
		n := int(str[l] - 48)
		j = j != true
		if j {
			n *= 2
			if n > 9 {
				for n > 0 {
					sm += n % 10
					n /= 10
				}
				continue
			}
		}
		sm += n
	}
	return 10-(sm%10) == chk
}

func main() {
	for _, data := range []struct {
		input  string
		output bool
	}{
		{"17893729974", true},
		{"4137 8947 1175 5904", true},
		{"4137 8974 1175 5904", false},
	} {
		io.WriteString(os.Stdout, cmp.Diff(isLuhn(data.input), data.output)) // blank if ok, otherwise show the differences
	}
}
