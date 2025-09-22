//# https://theweeklychallenge.org/blog/perl-weekly-challenge-340/
/*#

Task 1: Duplicate Removals

Submitted by: [48]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str, consisting of lowercase English letters.

   Write a script to return the final string after all duplicate removals
   have been made. Repeat duplicate removals on the given string until we
   no longer can.

     A duplicate removal consists of choosing two adjacent and equal
     letters and removing them.

Example 1

Input: $str = 'abbaca'
Output: 'ca'

Step 1: Remove 'bb' => 'aaca'
Step 2: Remove 'aa' => 'ca'

Example 2

Input: $str = 'azxxzy'
Output: 'ay'

Step 1: Remove 'xx' => 'azzy'
Step 2: Remove 'zz' => 'ay'

Example 3

Input: $str = 'aaaaaaaa'
Output: ''

Step 1: Remove 'aa' => 'aaaaaa'
Step 2: Remove 'aa' => 'aaaa'
Step 3: Remove 'aa' => 'aa'
Step 4: Remove 'aa' => ''

Example 4

Input: $str = 'aabccba'
Output: 'a'

Step 1: Remove 'aa' => 'bccba'
Step 2: Remove 'cc' => 'bba'
Step 3: Remove 'bb' => 'a'

Example 5

Input: $str = 'abcddcba'
Output: ''

Step 1: Remove 'dd' => 'abccba'
Step 2: Remove 'cc' => 'abba'
Step 3: Remove 'bb' => 'aa'
Step 4: Remove 'aa' => ''

Task 2: Ascending Numbers
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

func dr(bs []byte) []byte {
	l := len(bs)
	if l < 2 {
		return bs
	}
	i := 0
	for i < l-1 {
		if bs[i] == bs[i+1] {
			copy(bs[i:], bs[i+2:])
			l -= 2
			bs = bs[:l]
			continue
		}
		i++
	}
	return bs
}

func DuplicateRemovals(str string) string {
	bs := []byte(str)
	for {
		l := len(bs)
		bs = dr(bs)
		if len(bs) == l {
			break
		}
	}
	return string(bs)
}

func main() {
	for _, data := range []struct {
		input, output string
	}{
		{"abbaca", "ca"},
		{"azxxzy", "ay"},
		{"aaaaaaaa", ""},
		{"aabccba", "a"},
		{"abcddcba", ""},
	} {
		io.WriteString(os.Stdout, cmp.Diff(DuplicateRemovals(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
