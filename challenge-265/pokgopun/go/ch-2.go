//# https://theweeklychallenge.org/blog/perl-weekly-challenge-265/
/*#

Task 2: Completing Word

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str containing alphnumeric characters and
   array of strings (alphabetic characters only), @str.

   Write a script to find the shortest completing word. If none found
   return empty string.

     A completing word is a word that contains all the letters in the
     given string, ignoring space and number. If a letter appeared more
     than once in the given string then it must appear the same number or
     more in the word.

Example 1

Input: $str = 'aBc 11c'
       @str = ('accbbb', 'abc', 'abbc')
Output: 'accbbb'

The given string contains following, ignoring case and number:
a 1 times
b 1 times
c 2 times

The only string in the given array that satisfies the condition is 'accbbb'.

Example 2

Input: $str = 'Da2 abc'
       @str = ('abcm', 'baacd', 'abaadc')
Output: 'baacd'

The given string contains following, ignoring case and number:
a 2 times
b 1 times
c 1 times
d 1 times

The are 2 strings in the given array that satisfies the condition:
'baacd' and 'abaadc'.

Shortest of the two is 'baacd'

Example 3

Input: $str = 'JB 007'
       @str = ('jj', 'bb', 'bjb')
Output: 'bjb'

The given string contains following, ignoring case and number:
j 1 times
b 1 times

The only string in the given array that satisfies the condition is 'bjb'.
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 21st April
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"sort"

	"github.com/google/go-cmp/cmp"
)

type myByte map[byte]int

func newMyByte(s string) myByte {
	m := make(myByte)
	for _, v := range []byte(s) {
		if v >= 65 && v <= 90 {
			v += 32
		}
		if v >= 97 && v <= 122 {
			m[v]++
		}
	}
	return m
}

func (mb myByte) cw(s []string) string {
	sort.Slice(s, func(i, j int) bool {
		return len(s[i]) < len(s[j])
	})
	for _, v := range s {
		m := newMyByte(v)
		l := len(mb)
		for b, c := range mb {
			if c > m[b] {
				break
			}
			l--
		}
		if l == 0 {
			return v
		}
	}
	return ""
}

func main() {
	for _, data := range []struct {
		str    string
		strs   []string
		output string
	}{
		{"aBc 11c", []string{"accbbb", "abc", "abbc"}, "accbbb"},
		{"Da2 abc", []string{"abcm", "baacd", "abaadc"}, "baacd"},
		{"JB 007", []string{"jj", "bb", "bjb"}, "bjb"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(newMyByte(data.str).cw(data.strs), data.output)) // blank if ok, otherwise show the difference
	}
}
