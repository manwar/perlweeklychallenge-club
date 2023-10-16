//# https://theweeklychallenge.org/blog/perl-weekly-challenge-239/
/*#

Task 1: Same String

Submitted by: [54]Mohammad S Anwar
     __________________________________________________________________

   You are given two arrays of strings.

   Write a script to find out if the word created by concatenating the
   array elements is the same.

Example 1

Input: @arr1 = ("ab", "c")
       @arr2 = ("a", "bc")
Output: true

Using @arr1, word1 => "ab" . "c" => "abc"
Using @arr2, word2 => "a" . "bc" => "abc"

Example 2

Input: @arr1 = ("ab", "c")
       @arr2 = ("ac", "b")
Output: false

Using @arr1, word1 => "ab" . "c" => "abc"
Using @arr2, word2 => "ac" . "b" => "acb"

Example 3

Input: @arr1 = ("ab", "cd", "e")
       @arr2 = ("abcde")
Output: true

Using @arr1, word1 => "ab" . "cd" . "e" => "abcde"
Using @arr2, word2 => "abcde"

Task 2: Consistent Strings
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"fmt"
	"strings"
)

func main() {
	for _, data := range []struct {
		s1, s2 []string
		res    bool
	}{
		{[]string{"ab", "c"}, []string{"a", "bc"}, true},
		{[]string{"ab", "c"}, []string{"ac", "b"}, false},
		{[]string{"ab", "cd", "e"}, []string{"abcde"}, true},
	} {
		fmt.Println(sameStrings(data.s1, data.s2) == data.res)
	}
}

func sameStrings(s1, s2 []string) bool {
	return strings.Join(s1, "") == strings.Join(s2, "")
}
