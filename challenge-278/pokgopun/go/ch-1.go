//# https://theweeklychallenge.org/blog/perl-weekly-challenge-278/
/*#

Task 1: Sort String

Submitted by: [51]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a shuffle string, $str.

   Write a script to return the sorted string.

     A string is shuffled by appending word position to each word.

Example 1

Input: $str = "and2 Raku3 cousins5 Perl1 are4"
Output: "Perl and Raku are cousins"

Example 2

Input: $str = "guest6 Python1 most4 the3 popular5 is2 language7"
Output: "Python is the most popular guest language"

Example 3

Input: $str = "Challenge3 The1 Weekly2"
Output: "The Weekly Challenge"

Task 2: Reverse Word
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"cmp"
	"io"
	"os"
	"slices"
	"strconv"
	"strings"

	gcmp "github.com/google/go-cmp/cmp"
)

// word position is consistent and single-digit
func sortString0(str string) string {
	s := strings.Split(str, " ")
	r := make([]string, len(s))
	for _, v := range s {
		l := len(v)
		r[v[l-1]-49] = v[:l-1]
	}
	return strings.Join(r, " ")
}

// word position is consistent and can be multiple-digit
func sortString1(str string) string {
	s := strings.Split(str, " ")
	r := make([]string, len(s))
	for _, v := range s {
		l := len(v)
		for l > 0 {
			l--
			if v[l] < 48 || v[l] > 57 {
				break
			}
		}
		d := v[l+1:]
		rank, _ := strconv.Atoi(d)
		r[rank-1] = v[:l+1]
	}
	return strings.Join(r, " ")
}

// word position does not need to be consistent and can be multiple-digit or empty
func sortString2(str string) string {
	s := strings.Split(str, " ")
	type rankWord struct {
		rank int
		word string
	}
	l := len(s)
	rw := make([]rankWord, l)
	r := make([]string, l)
	for i, v := range s {
		l := len(v)
		for l > 0 {
			l--
			if v[l] < 48 || v[l] > 57 {
				break
			}
		}
		d := v[l+1:]
		rank, _ := strconv.Atoi(d)
		rw[i] = rankWord{rank, v[:l+1]}
	}
	slices.SortFunc(rw, func(a, b rankWord) int {
		return cmp.Compare(a.rank, b.rank)
	})
	for i, v := range rw {
		r[i] = v.word
	}
	return strings.Join(r, " ")
}

func main() {
	sortStringFuncs := [3]func(string) string{sortString2, sortString1, sortString0}
	for _, data := range []struct {
		input, output string
		flevel        int
	}{
		{"and2 Raku3 cousins5 Perl1 are4", "Perl and Raku are cousins", 3},
		{"guest6 Python1 most4 the3 popular5 is2 language7", "Python is the most popular guest language", 3},
		{"Challenge3 The1 Weekly2", "The Weekly Challenge", 3},
		{"it9 guest6 Python1 most4 the3 popular5 timtowtdi12 is2 language7 but8 is10 not11", "Python is the most popular guest language but it is not timtowtdi", 2},
		{"Challenge31 The0 Weekly2", "The Weekly Challenge", 1},
	} {
		for _, f := range sortStringFuncs[:data.flevel] {
			io.WriteString(os.Stdout, gcmp.Diff(f(data.input), data.output)) // blank if ok, otherwise show the difference
		}
	}
}
