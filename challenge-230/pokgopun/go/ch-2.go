// https://theweeklychallenge.org/blog/perl-weekly-challenge-230/
/*
Task 2: Count Words
Submitted by: Mohammad S Anwar
You are given an array of words made up of alphabetic characters and a prefix.

Write a script to return the count of words that starts with the given prefix.

Example 1
Input: @words  = ("pay", "attention", "practice", "attend")
       $prefix = "at"
Ouput: 2

Two words "attention" and "attend" starts with the given prefix "at".
Example 2
Input: @words  = ("janet", "julia", "java", "javascript")
       $prefix = "ja"
Ouput: 3

Three words "janet", "java" and "javascripr" starts with the given prefix "ja".
*/

package main

import "fmt"

func main() {
	var mss MyStringSlice
	for _, data := range []struct {
		i []string
		v string
		o int
	}{
		{[]string{"pay", "attention", "practice", "attend"}, "at", 2},
		{[]string{"janet", "julia", "java", "javascript"}, "ja", 3},
	} {
		mss.Data = data.i
		fmt.Println(mss.CountPrefix(data.v) == data.o)
	}
}

type MyStringSlice struct {
	Data []string
	cmp  int
	pl   int
}

func (mss MyStringSlice) CountPrefix(prefix string) int {
	mss.cmp = 0
	mss.pl = len(prefix)
	for _, v := range mss.Data {
		if v[0:mss.pl] == prefix {
			mss.cmp++
		}
	}
	return mss.cmp
}
