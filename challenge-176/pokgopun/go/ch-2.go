/* https://theweeklychallenge.org/blog/perl-weekly-challenge-176/

Task 2: Reversible Numbers
Submitted by: Mohammad S Anwar
Write a script to find out all Reversible Numbers below 100.


A number is said to be a reversible if sum of the number and its reverse had only odd digits.


For example,

36 is reversible number as 36 + 63 = 99 i.e. all digits are odd.
17 is not reversible as 17 + 71 = 88, none of the digits are odd.

Output
10, 12, 14, 16, 18, 21, 23, 25, 27,
30, 32, 34, 36, 41, 43, 45, 50, 52,
54, 61, 63, 70, 72, 81, 90

*/
package main

import (
	"io"
	"os"
	"strconv"
	"strings"
)

func main() {
	var sb strings.Builder
	var n int
	for i := 10; i < 100; i++ {
		n = i
		var r int
		for n > 0 {
			r *= 10
			r += n % 10
			n /= 10
		}
		n = i + r
		for n > 0 {
			if n%2 == 0 {
				goto skip
			}
			n /= 10
		}
		sb.WriteString(", " + strconv.Itoa(i))
	skip:
	}
	io.WriteString(os.Stdout, sb.String()[2:]+"\n")
}
