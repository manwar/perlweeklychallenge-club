//# https://theweeklychallenge.org/blog/perl-weekly-challenge-254/
/*#

Task 2: Reverse Vowels

Submitted by: [48]Mohammad S Anwar
     __________________________________________________________________

   You are given a string, $s.

   Write a script to reverse all the vowels (a, e, i, o, u) in the given
   string.

Example 1

Input: $s = "Raku"
Output: "Ruka"

Example 2

Input: $s = "Perl"
Output: "Perl"

Example 3

Input: $s = "Julia"
Output: "Jaliu"

Example 4

Input: $s = "Uiua"
Output: "Auiu"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 4th February
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"strings"

	"github.com/google/go-cmp/cmp"
)

func main() {
	for _, data := range []struct {
		input, output str
	}{
		{"Raku", "Ruka"},
		{"Perl", "Perl"},
		{"Julia", "Jaliu"},
		{"Uiua", "Auiu"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.reverseVowels(), data.output)) // blank if ok, otherwise show the difference
	}
}

type char byte

func (ch char) isVowel() bool {
	for _, c := range []byte("aeiou") {
		if char(c) == ch {
			return true
		}
	}
	return false
}

type str string

func (st str) vowels() str {
	var b strings.Builder
	for _, v := range []byte(strings.ToLower(string(st))) {
		if char(v).isVowel() {
			b.WriteByte(v)
		}
	}
	return str(b.String())
}

func (st str) reverseVowels() str {
	var b strings.Builder
	vwls := st.vowels()
	l := len(vwls)
	for _, v := range []byte(strings.ToLower(string(st))) {
		if char(v).isVowel() {
			v = vwls[l-1]
			l--
		}
		b.WriteByte(v)
	}
	return str(strings.Title(b.String()))
}
