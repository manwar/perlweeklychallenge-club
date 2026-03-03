//# https://theweeklychallenge.org/blog/perl-weekly-challenge-363/
/*#

Task 1: String Lie Detector

Submitted by: [52]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string.

   Write a script that parses a self-referential string and determines
   whether its claims about itself are true. The string will make
   statements about its own composition, specifically the number of vowels
   and consonants it contains.

Example 1

Input: $str = "aa — two vowels and zero consonants"
Output: true

Example 2

Input: $str = "iv — one vowel and one consonant"
Output: true

Example 3

Input: $str = "hello - three vowels and two consonants"
Output: false

Example 4

Input: $str = "aeiou — five vowels and zero consonants"
Output: true

Example 5

Input: $str = "aei — three vowels and zero consonants"
Output: true

Task 2: Subnet Sheriff
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"strings"

	"github.com/google/go-cmp/cmp"
)

type processor map[string]int

func newProcessor() processor {
	return processor(map[string]int{
		"one":      1,
		"two":      2,
		"twen":     2,
		"three":    3,
		"thir":     3,
		"four":     4,
		"for":      4,
		"five":     5,
		"fif":      5,
		"six":      6,
		"seven":    7,
		"eight":    8,
		"eigh":     8,
		"nine":     9,
		"ten":      10,
		"eleven":   11,
		"twelve":   12,
		"hundred":  100,
		"thousand": 1_000,
		"million":  1_000_000,
		"billion":  1_000_000_000,
		"trillion": 1_000_000_000_000,
	})
}

func (pc processor) process(str string) int {
	sign, val := 1, 0
	if s, ok := strings.CutPrefix(str, "minus "); ok {
		sign *= -1
		str = s
	}
	for {
		i := strings.Index(str, ", ")
		if i == -1 {
			break
		}
		val += pc.process(str[:i])
		str = str[i+2:]
	}
	{
		i := strings.LastIndexByte(str, ' ')
		if i != -1 {
			u := pc[str[i+1:]]
			if u >= 100 {
				return sign * (val + u*pc.process(str[:i]))
			}
		}
	}
	for {
		i := strings.Index(str, " and ")
		if i == -1 {
			break
		}
		val += pc.process(str[:i])
		str = str[i+5:]
	}
	for v := range strings.SplitSeq(str, "-") {
		if s, ok := strings.CutSuffix(v, "ty"); ok {
			val += 10 * pc[s]
		} else if s, ok := strings.CutSuffix(v, "teen"); ok {
			val += 10 + pc[s]
		} else {
			val += pc[v]
		}
	}
	return sign * val
}

func sld(str string) bool {
	pc := newProcessor()
	vals := strings.Fields(str)
	chars := strings.ToLower(vals[0])
	vwl_cnt := pc.process(vals[2])
	csn_cnt := pc.process(vals[5])
	for _, v := range chars {
		switch v {
		case 'a', 'e', 'i', 'o', 'u':
			vwl_cnt--
		default:
			csn_cnt--
		}
	}
	return vwl_cnt == 0 && csn_cnt == 0
}

func main() {
	for _, data := range []struct {
		input  string
		output bool
	}{
		{"aa — two vowels and zero consonants", true},
		{"iv — one vowel and one consonant", true},
		{"hello - three vowels and two consonants", false},
		{"aeiou — five vowels and zero consonants", true},
		{"aei — three vowels and zero consonants", true},
	} {
		io.WriteString(os.Stdout, cmp.Diff(sld(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
