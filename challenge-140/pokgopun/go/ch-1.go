/* https://theweeklychallenge.org/blog/perl-weekly-challenge-140/
TASK #1 › Add Binary
Submitted by: Mohammad S Anwar
You are given two decimal-coded binary numbers, $a and $b.

Write a script to simulate the addition of the given binary numbers.

The script should simulate something like $a + $b. (operator overloading)

Example 1
Input: $a = 11; $b = 1;
Output: 100
Example 2
Input: $a = 101; $b = 1;
Output: 110
Example 3
Input: $a = 100; $b = 11;
Output: 111
*/
package main

import (
	"bufio"
	"errors"
	"os"
	"sort"
	"strings"
)

func main() {
	w := bufio.NewWriter(os.Stdout)
	sample := make([][2]string, 1)
	if len(os.Args) > 2 {
		sample[0] = [2]string{os.Args[1], os.Args[2]}
	} else {
		sample = [][2]string{
			[2]string{"11", "1"},
			[2]string{"101", "1"},
			[2]string{"100", "11"},
		}
	}
	var a, b string
	for _, v := range sample {
		a, b = v[0], v[1]
		w.WriteString("Input: a = " + a + "; b = " + b + "\nOutput: ")
		res, err := Add(a, b)
		if err != nil {
			w.WriteString(err.Error())
		} else {
			w.WriteString(res)
		}
		w.WriteString("\n\n")
	}
	w.Flush()
}
func Add(a, b string) (r string, err error) {
	for _, v := range a + b {
		if v != '1' && v != '0' {
			return "", errors.New("invalid binary string")
		}
	}
	for _, v := range []*string{&a, &b} {
		*v = Reverse(strings.TrimLeft(*v, "0"))
	}
	max := MaxLen(a, b)
	var count1 int
	for i := 0; i < max+count1; i++ {
		for _, str := range []string{a, b} {
			if i < len(str) {
				if str[i] == '1' {
					count1++
				}
			}
		}
		if count1%2 == 0 {
			r += "0"
		} else {
			r += "1"
		}
		count1 /= 2
	}
	return Reverse(r), nil
}
func Reverse(str string) string {
	s := []byte(str)
	sort.SliceStable(s, func(i, j int) bool {
		return true
	})
	return string(s)
}
func MaxLen(s ...string) (max int) {
	l := len(s[0])
	max = l
	for _, v := range s[1:] {
		l := len(v)
		if max < l {
			max = l
		}
	}
	return max
}
