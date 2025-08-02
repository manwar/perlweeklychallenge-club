//# https://theweeklychallenge.org/blog/perl-weekly-challenge-274/
/*#

Task 1: Goat Latin

Submitted by: [57]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a sentence, $sentance.

   Write a script to convert the given sentence to Goat Latin, a made up
   language similar to Pig Latin.

   Rules for Goat Latin:
1) If a word begins with a vowel ("a", "e", "i", "o", "u"), append
   "ma" to the end of the word.
2) If a word begins with consonant i.e. not a vowel, remove first
   letter and append it to the end then add "ma".
3) Add letter "a" to the end of first word in the sentence, "aa" to
   the second word, etc etc.

Example 1

Input: $sentence = "I love Perl"
Output: "Imaa ovelmaaa erlPmaaaa"

Example 2

Input: $sentence = "Perl and Raku are friends"
Output: "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa"

Example 3

Input: $sentence = "The Weekly Challenge"
Output: "heTmaa eeklyWmaaa hallengeCmaaaa"

Task 2: Bus Route
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"strings"

	"github.com/google/go-cmp/cmp"
)

func isVowel(b byte) bool {
	for _, v := range []byte("aeiouAEIOU") {
		if b == v {
			return true
		}
	}
	return false
}

func goatLatin(sntnce string) string {
	var b strings.Builder
	for i, wrd := range strings.Split(sntnce, " ") {
		b.WriteRune(' ')
		if !isVowel(wrd[0]) {
			b.WriteString(wrd[1:])
			b.WriteByte(wrd[0])
		} else {
			b.WriteString(wrd)
		}
		b.WriteRune('m')
		for j := 0; j < i+2; j++ {
			b.WriteRune('a')
		}
	}
	return b.String()[1:]
}

func main() {
	for _, data := range []struct {
		input, output string
	}{
		{"I love Perl", "Imaa ovelmaaa erlPmaaaa"},
		{"Perl and Raku are friends", "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa"},
		{"The Weekly Challenge", "heTmaa eeklyWmaaa hallengeCmaaaa"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(goatLatin(data.input), data.output)) // blank if ok, otherwise show the differences
	}
}
