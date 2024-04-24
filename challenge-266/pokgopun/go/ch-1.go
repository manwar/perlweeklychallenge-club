//# https://theweeklychallenge.org/blog/perl-weekly-challenge-266/
/*#

Task 1: Uncommon Words

Submitted by: [41]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two sentences, $line1 and $line2.

   Write a script to find all uncommmon words in any order in the given
   two sentences. Return ('') if none found.

     A word is uncommon if it appears exactly once in one of the
     sentences and doesn’t appear in other sentence.

Example 1

Input: $line1 = 'Mango is sweet'
       $line2 = 'Mango is sour'
Output: ('sweet', 'sour')

Example 2

Input: $line1 = 'Mango Mango'
       $line2 = 'Orange'
Output: ('Orange')

Example 3

Input: $line1 = 'Mango is Mango'
       $line2 = 'Orange is Orange'
Output: ('')

Task 2: X Matrix
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"strings"

	"github.com/google/go-cmp/cmp"
)

func uncommonWords(line1, line2 string) []string {
	wc := make(map[string]int)
	var words []string
	for _, v := range strings.Split(line1+" "+line2, " ") {
		wc[v]++
		if wc[v] == 1 {
			words = append(words, v)
		}
	}
	//fmt.Println("words =>", words, "wc =>", wc)
	l := len(words)
	i := l
	for i > 0 {
		if wc[words[i-1]] > 1 {
			copy(words[i-1:], words[i:])
			l--
		}
		i--
	}
	if l == 0 {
		return []string{""}
	}
	return words[:l]
}

func main() {
	for _, data := range []struct {
		line1, line2 string
		output       []string
	}{
		{"Mango is sweet", "Mango is sour", []string{"sweet", "sour"}},
		{"Mango Mango", "Orange", []string{"Orange"}},
		{"Mango is Mango", "Orange is Orange", []string{""}},
		{"Mango", "Mango", []string{""}},
		{"Mango", "Orange Orange", []string{"Mango"}},
	} {
		//fmt.Println("=>", data, uncommonWords(data.line1, data.line2))
		io.WriteString(os.Stdout, cmp.Diff(uncommonWords(data.line1, data.line2), data.output)) // blank if ok, otherwise show the difference
	}
}
