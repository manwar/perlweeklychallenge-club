//# https://theweeklychallenge.org/blog/perl-weekly-challenge-305/
/*#

Task 2: Alien Dictionary

Submitted by: [41]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list of words and alien dictionary character order.

   Write a script to sort lexicographically the given list of words based
   on the alien dictionary characters.

Example 1

Input: @words = ("perl", "python", "raku")
       @alien = qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/
Output: ("raku", "python", "perl")

Example 2

Input: @words = ("the", "weekly", "challenge")
       @alien = qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/
Output: ("challenge", "the", "weekly")
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 26^th January
   2025.
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

type words []string

type input struct {
	words words
	alien string
}

func (ip *input) alienDict() {
	ip.alien = strings.ReplaceAll(ip.alien, " ", "")
}

func (ip input) translate(str string) string {
	bs := make([]byte, len(str))
	for i, r := range str {
		bs[i] = ip.alien[r-97]
	}
	return string(bs)
}

func (ip input) process() words {
	ip.alienDict()
	slices.SortFunc(ip.words, func(a, b string) int {
		return strings.Compare(ip.translate(a), ip.translate(b))
	})
	return ip.words
}

func main() {
	for _, data := range []struct {
		input  input
		output words
	}{
		{
			input{words{"perl", "python", "raku"}, "h l a b y d e f g i r k m n o p q j s t u v w x c z"},
			words{"raku", "python", "perl"},
		},
		{
			input{words{"the", "weekly", "challenge"}, "c o r l d a b t e f g h i j k m n p q s w u v x y z"},
			words{"challenge", "the", "weekly"},
		},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
