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
	"sort"
	"strconv"
	"strings"
)

func main() {
	var sb strings.Builder
	for i := 10; i < 100; i++ {
		b := []byte(strconv.Itoa(i))
		sort.SliceStable(b, func(i, j int) bool {
			return true
		})
		n, _ := strconv.Atoi(string(b))
		//fmt.Println(i, "+", n, "=", i+n)
		for _, v := range []byte(strconv.Itoa(i + n)) {
			if (v-48)%2 == 0 {
				goto skip
			}
		}
		sb.WriteString(", " + strconv.Itoa(i))
	skip:
	}
	io.WriteString(os.Stdout, sb.String()[2:]+"\n")
}
