//# https://theweeklychallenge.org/blog/perl-weekly-challenge-287/
/*#

Task 1: Strong Password

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str.

   Write a program to return the minimum number of steps required to make
   the given string very strong password. If it is already strong then
   return 0.

   Criteria:
- It must have at least 6 characters.
- It must contains at least one lowercase letter, at least one upper case letter
 and at least one digit.
- It shouldn't contain 3 repeating characters in a row.

   Following can be considered as one step:
- Insert one character
- Delete one character
- Replace one character with another

Example 1

Input: $str = "a"
Output: 5

Example 2

Input: $str = "aB2"
Output: 3

Example 3

Input: $str = "PaaSW0rd"
Output: 0

Example 4

Input: $str = "Paaasw0rd"
Output: 1

Example 5

Input: $str = "aaaaa"
Output: 2

Task 2: Valid Number
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

func consecutiveCharCount(str string, l int) int {
	if len(str) < l {
		return 0
	}
	var (
		count, cnt int
		prev       rune
	)
	for _, r := range str {
		if cnt == 0 {
			prev = r
			cnt++
			continue
		}
		if r == prev {
			cnt++
			if cnt == l {
				count++
				cnt = 0
			}
		} else {
			prev = r
			cnt = 1
		}
	}
	return count
}

type charset struct {
	first, last rune
}

func countRequiredCharset(str string, charsets []charset) int {
	count := len(charsets)
	m := make(map[charset]bool, count)
	for _, v := range charsets {
		m[v] = true
	}
	//var n int
	for _, c := range str {
		//n++
		for k, v := range m {
			if v && c >= k.first && c <= k.last {
				m[k] = false
				count -= 1
				break
			}
		}
		if count == 0 {
			break
		}
	}
	//fmt.Println(n, "char(s) checked for required types")
	return count
}

func strongPassword(str string) int {
	requiredLength := 6
	l := len(str)
	if l == 0 {
		return requiredLength
	}
	requiredCharsetCount := countRequiredCharset(
		str,
		[]charset{
			charset{'0', '9'},
			charset{'A', 'Z'},
			charset{'a', 'z'},
		},
	)
	consecutiveCharLength := 3
	countConsecutiveChar := consecutiveCharCount(str, consecutiveCharLength)
	//fmt.Println(requiredCharsetCount, countConsecutiveChar,requiredLength -min(requiredLength, l))
	return max(requiredCharsetCount, countConsecutiveChar, requiredLength-min(requiredLength, l))
}

func main() {
	for _, data := range []struct {
		input  string
		output int
	}{
		{"a", 5},
		{"aB2", 3},
		{"PaaSW0rd", 0},
		{"Paaasw0rd", 1},
		{"aaaaa", 2},
		{"aaaaaa", 2},
		{"aaaaaaa", 2},
		{"aaaaaaaa", 2},
		{"aaaaaaaaa", 3},
		{"aaaaaaaaaa", 3},
		{"aaa", 3},
		{"s3cret", 1},
		{"444o333", 2},
		{"44333", 2},
	} {
		//fmt.Println(data.input, data.output)
		io.WriteString(os.Stdout, cmp.Diff(strongPassword(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
