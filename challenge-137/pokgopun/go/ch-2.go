/* https://theweeklychallenge.org/blog/perl-weekly-challenge-137/
TASK #2 › Lychrel Number
Submitted by: Mohammad S Anwar
You are given a number, 10 <= $n <= 1000.

Write a script to find out if the given number is Lychrel number. To keep the task simple, we impose the following rules:

a. Stop if the number of iterations reached 500.
b. Stop if you end up with number >= 10_000_000.

[UPDATED][2021-11-01 16:20:00]: If you stop because of any of the above two rules then we expect 1 as an output.

According to wikipedia:

A Lychrel number is a natural number that cannot form a palindrome through the iterative process of repeatedly reversing its digits and adding the resulting numbers.

Example 1
Input: $n = 56
Output: 0

After 1 iteration, we found palindrome number.
56 + 65 = 121
Example 2
Input: $n = 57
Output: 0

After 2 iterations, we found palindrome number.
 57 +  75 = 132
132 + 231 = 363
Example 3
Input: $n = 59
Output: 0

After 3 iterations, we found palindrome number.
 59 +  95 =  154
154 + 451 =  605
605 + 506 = 1111
*/
package main

import (
	"fmt"
	"os"
	"strconv"
)

func main() {
	var s []uint64
	for _, v := range os.Args[1:] {
		n, err := strconv.ParseUint(v, 10, 64)
		if err != nil {
			break
		}
		s = append(s, n)
	}
	l := len(s)
	if l == 0 || l != len(os.Args)-1 {
		s = []uint64{56, 57, 59, 196, 295, 394}
	}
	for _, v := range s {
		fmt.Printf("Input: n = %d\nOutput: %t\n\n", v, isLychrel(v))
	}
}

func isPalindrome(s []byte) bool {
	l := len(s)
	for i := 0; i < l; i++ {
		if s[i] != s[l-1-i] {
			return false
		}
	}
	return true
}

func iterate(n uint64) uint64 {
	sum := n
	var t uint64 = 1
	for _, v := range []byte(strconv.FormatUint(n, 10)) {
		sum += t * uint64(v-48)
		t *= 10
	}
	return sum
}

func isLychrel(n uint64) bool {
	for i := 0; i < 500; i++ {
		if isPalindrome([]byte(strconv.FormatUint(n, 10))) {
			return false
		}
		n = iterate(n)
		if n >= 10_000_000 {
			return true
		}
	}
	return true
}
