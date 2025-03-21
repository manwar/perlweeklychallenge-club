//# https://theweeklychallenge.org/blog/perl-weekly-challenge-313/
/*#

Task 1: Broken Keys

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You have a broken keyboard which sometimes type a character more than
   once.

   You are given a string and actual typed string.

   Write a script to find out if the actual typed string is meant for the
   given string.

Example 1

Input: $name = "perl", $typed = "perrrl"
Output: true

Here "r" is pressed 3 times instead of 1 time.

Example 2

Input: $name = "raku", $typed = "rrakuuuu"
Output: true

Example 3

Input: $name = "python", $typed = "perl"
Output: false

Example 4

Input: $name = "coffeescript", $typed = "cofffeescccript"
Output: true

Task 2: Reverse Letters
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type charCount struct {
	chr rune
	cnt int
}

type charCounts []charCount

func newCharCounts(str string) charCounts {
	chrs := []rune(str)
	if len(chrs) == 0 {
		return charCounts{}
	}
	ccs := charCounts{charCount{chrs[0], 1}}
	i := 0
	for _, v := range chrs[1:] {
		if v == ccs[i].chr {
			ccs[i].cnt++
		} else {
			ccs = append(ccs, charCount{v, 1})
			i++
		}
	}
	return ccs
}

type input struct {
	name, typed string
}

func (in input) process() bool {
	name_cc := newCharCounts(in.name)
	l := len(name_cc)
	typed_cc := newCharCounts(in.typed)
	if l != len(typed_cc) {
		return false
	}
	for i := range l {
		ncc := name_cc[i]
		tcc := typed_cc[i]
		if ncc.chr != tcc.chr || ncc.cnt > tcc.cnt {
			return false
		}
	}
	return true
}

func main() {
	for _, data := range []struct {
		input  input
		output bool
	}{
		{input{"perl", "perrrl"}, true},
		{input{"raku", "rrakuuuu"}, true},
		{input{"python", "perl"}, false},
		{input{"coffeescript", "cofffeescccript"}, true},
		{input{"noob", "nob"}, false},
		{input{"snow", "noow"}, false},
		{input{"ten", "teens"}, false},
		{input{"aha", "haa"}, false},
		{input{"กากมาก", "กาาากมาาาาาาก"}, true},
		{input{"กาาากมาาาก", "กากมาก"}, false},
		{input{"รักกัน", "รรักกันน"}, true},
		{input{"บรรทัด", "บรทัด"}, false},
		{input{"โรงเรียน", "โโโรรงงเรรียยนน"}, true},
		{input{"เกเรียน", "เกกเรรียยนน"}, true},
		{input{"แมว", "แแแมมมวววว"}, true},
		{input{"มมมแมว", "มแมมมวววว"}, false},
	} {
		//fmt.Println(data.input)
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
