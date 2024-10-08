//# https://theweeklychallenge.org/blog/perl-weekly-challenge-288/
/*#

Task 1: Closest Palindrome

Submitted by: [49]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str, which is an integer.

   Write a script to find out the closest palindrome, not including
   itself. If there are more than one then return the smallest.

     The closest is defined as the absolute difference minimized between
     two integers.

Example 1

Input: $str = "123"
Output: "121"

Example 2

Input: $str = "2"
Output: "1"

There are two closest palindrome "1" and "3". Therefore we return the smallest "
1".

Example 3

Input: $str = "1400"
Output: "1441"

Example 4

Input: $str = "1001"
Output: "999"

Task 2: Contiguous Block
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"fmt"
	"io"
	"os"
	"strconv"

	"github.com/google/go-cmp/cmp"
)

func main() {
	for _, data := range []struct {
		input, output string
	}{
		{"123", "121"},
		{"2", "1"},
		{"1400", "1441"},
		{"1001", "999"},
		{"0", "1"},
		{"10", "9"},
		{"16", "11"},
		{"17", "22"},
		{strconv.Itoa(44_5_00), strconv.Itoa(44_5_44)},
		{strconv.Itoa(44_4_99), strconv.Itoa(44_5_44)},
		{strconv.Itoa(44_60_00), strconv.Itoa(44_55_44)},
		{strconv.Itoa(44_40_99), strconv.Itoa(44_44_44)},
		{strconv.Itoa(99_0_49), strconv.Itoa(99_0_99)},
		{strconv.Itoa(99_0_39), strconv.Itoa(98_9_89)},
		{strconv.Itoa(99_06_49), strconv.Itoa(99_00_99)},
		{strconv.Itoa(999_94_499), strconv.Itoa(999_88_999)},
		{strconv.Itoa(999999_94_499999), strconv.Itoa(999999_88_999999)},
		{strconv.Itoa(999999_83_599999), strconv.Itoa(999999_88_999999)},
		{strconv.Itoa(9999999_99_9999999), strconv.Itoa(10000000_0_00000001)},
		{strconv.Itoa(9999999_88_9999999), strconv.Itoa(9999999_77_9999999)},
	} {
		io.WriteString(os.Stdout, cmp.Diff(closestPalindrome(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}

func isPalindromeSlice[S ~[]E, E comparable](s S) bool {
	for {
		l := len(s)
		if l < 2 {
			break
		}
		if s[0] != s[l-1] {
			return false
		}
		s = s[1 : l-1]
	}
	return true
}

func numToDigits(n int) []int {
	var s []int
	if n < 0 {
		return s
	}
	for {
		s = append(s, n%10)
		n /= 10
		if n == 0 {
			break
		}
	}
	return s
}

func digitsToNum(s []int) int {
	l := len(s) - 1
	if l < 0 {
		return -1
	}
	n := s[l]
	for l > 0 {
		n *= 10
		l--
		n += s[l]
	}
	return n
}

type palindromeNumber struct {
	dgt []int
	d0d bool
}

func newPalindromeNumber(numstr string) *palindromeNumber {
	var pn palindromeNumber
	n, err := strconv.Atoi(numstr)
	if err != nil || !isPalindromeSlice([]byte(numstr)) {
		return &pn
	}
	dgt := numToDigits(n)
	l := len(dgt)
	pn.dgt = dgt[l/2:]
	pn.d0d = l%2 == 0
	return &pn
}

func (pn *palindromeNumber) prev() *palindromeNumber {
	l := len(pn.dgt)
	if l == 0 {
		return pn
	}
	n := digitsToNum(pn.dgt)
	switch {
	case n == 0 && pn.d0d == false:
		pn.dgt = pn.dgt[l:]
	case n == 1 && pn.d0d == true:
		pn.dgt[0] = 9
		pn.d0d = false
	case n < 10:
		pn.dgt[0]--
	default:
		pn.dgt = numToDigits(n - 1)
		if len(pn.dgt) < l {
			if pn.d0d == true {
				pn.dgt = numToDigits(10*n - 1)
			}
			pn.d0d = !pn.d0d
		}
	}
	return pn
}
func (pn *palindromeNumber) next() *palindromeNumber {
	l := len(pn.dgt)
	pn.dgt = numToDigits(digitsToNum(pn.dgt) + 1)
	if len(pn.dgt) > l {
		if pn.d0d == false {
			pn.dgt = pn.dgt[1:]
		}
		pn.d0d = !pn.d0d
	}
	return pn
}
func (pn palindromeNumber) String() string {
	l := len(pn.dgt)
	if l == 0 {
		return ""
	}
	str := strconv.Itoa(pn.dgt[0])
	if pn.d0d == true {
		str += str
	}
	var w string
	for _, v := range pn.dgt[1:] {
		w = strconv.Itoa(v)
		str = w + str + w
	}
	return str
}

func (pn palindromeNumber) num() int {
	if n, err := strconv.Atoi(pn.String()); err == nil {
		return n
	}
	return -1
}

func closestPalindrome(numstr string) string {
	n, err := strconv.Atoi(numstr)
	if err != nil {
		return ""
	}
	switch {
	case n < 0:
		return "0"
	case n == 0:
		return "1"
	case n < 11:
		return strconv.Itoa(n - 1)
	}
	if isPalindromeSlice([]byte(numstr)) {
		prev := newPalindromeNumber(numstr).prev()
		next := newPalindromeNumber(numstr).next()
		if n-prev.num() <= next.num()-n {
			return prev.String()
		}
		return next.String()
	}
	numstr = strconv.Itoa(n)
	l := len(numstr)
	bn, _ := strconv.Atoi(numstr[:l/2+l%2])
	p := palindromeNumber{numToDigits(bn), l%2 == 0}
	num1 := p.num()
	var diff1, num2, diff2 int
	if num1 > n {
		diff1 = num1 - n
		num2 = p.prev().num()
		diff2 = n - num2
		if diff2 < 0 {
			fmt.Printf("!!! should %d > %d > %d ???\n", num1, n, num2)
		}
	} else {
		diff1 = n - num1
		num2 = p.next().num()
		diff2 = num2 - n
		if diff2 < 0 {
			fmt.Printf("!!! should %d < %d < %d ???\n", num1, n, num2)
		}
	}
	//fmt.Printf("%d => %d[%d]->%d[%d]\n", n, num1, diff1, num2, diff2)
	var r int
	switch {
	case diff1 < diff2:
		r = num1
	case diff2 < diff1:
		r = num2
	default:
		r = min(num1, num2)
	}
	return strconv.Itoa(r)
}
