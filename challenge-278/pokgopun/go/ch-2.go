//# https://theweeklychallenge.org/blog/perl-weekly-challenge-278/
/*#

Task 2: Reverse Word

Submitted by: [52]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a word, $word and a character, $char.

   Write a script to replace the substring up to and including $char with
   its characters sorted alphabetically. If the $char doesn’t exist then
   DON'T do anything.

Example 1

Input: $str = "challenge", $char = "e"
Ouput: "acehllnge"

Example 2

Input: $str = "programming", $char = "a"
Ouput: "agoprrmming"

Example 3

Input: $str = "champion", $char = "b"
Ouput: "champion"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 21st July 2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"slices"
	"strings"

	"github.com/google/go-cmp/cmp"
)

func reverseWord(word string, char rune) string {
	i := strings.IndexRune(word, char)
	if i < 0 {
		return word
	}
	s := []rune(word)[:i+1]
	slices.Sort(s)
	return string(s) + word[i+1:]
}

func main() {
	for _, data := range []struct {
		word   string
		char   rune
		output string
	}{
		{"challenge", 'e', "acehllnge"},
		{"programming", 'a', "agoprrmming"},
		{"champion", 'b', "champion"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(reverseWord(data.word, data.char), data.output)) // blank if ok, otherwise show the difference
	}
}
