//# https://theweeklychallenge.org/blog/perl-weekly-challenge-240/
/*#

Task 1: Acronym

Submitted by: [52]Mohammad S Anwar
     __________________________________________________________________

   You are given two arrays of strings and a check string.

   Write a script to find out if the check string is the acronym of the
   words in the given array.

Example 1

Input: @str = ("Perl", "Python", "Pascal")
       $chk = "ppp"
Output: true

Example 2

Input: @str = ("Perl", "Raku")
       $chk = "rp"
Output: false

Example 3

Input: @str = ("Oracle", "Awk", "C")
       $chk = "oac"
Output: true

Task 2: Build Array
#*/
//# solution by pokgopun@gmail.com

package main

import "fmt"

func main() {
	for _, data := range []struct {
		strings []string
		abbrv   string
		res     bool
	}{
		{[]string{"Perl", "Python", "Pascal"}, "ppp", true},
		{[]string{"Perl", "Raku"}, "rp", false},
		{[]string{"Oracle", "Awk", "C"}, "oac", true},
	} {
		fmt.Println(isAbbrv(data.strings, data.abbrv) == data.res)
	}
}

func isAbbrv(s []string, a string) bool {
	if len(s) != len(a) {
		return false
	}
	for i, v := range s {
		if (v[0]-a[i])%32 != 0 {
			return false
		}
	}
	return true
}
