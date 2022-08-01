/* https://theweeklychallenge.org/blog/perl-weekly-challenge-176/

Task 1: Permuted Multiples Submitted by: Mohammad S Anwar Write a script to find the smallest integer x such that x, 2x, 3x, 4x, 5x and 6x are permuted multiples of each other.

For example, the integers 125874 and 251748 are permutated multiples of each other as

251784 = 2 x 125874
and also both have the same digits but in different order.

Output
142857

*/
package main

import (
	"fmt"
	"os"
	"sort"
	"strconv"
	"strings"
)

func main() {
	count := 1
	fmt.Sscanf(strings.Join(os.Args[1:], " "), "%d", &count)
	// start with 10C3 as we need at least 6 (i.e. 3!) variations to satisfy 1x-6x, end with 10C9 as 10C10 only has single variation
	for i := 3; i < 10; i++ {
		var c string
		for _, v := range strings.Split(combo(i, "0123456789", "", &c), " ") {
			// filter out combinations that cannot produce 1x and 6x => max/min < 6
			/**/
			min, _ := strconv.Atoi(v)
			b := []byte(v)
			sort.SliceStable(b, func(i, j int) bool {
				return true
			})
			max, _ := strconv.Atoi(string(b))
			if max/min < 6 {
				continue
			}
			/**/
			//fmt.Println(v)
			m := make(map[string]bool)
			var p string
			for _, a := range strings.Split(permute(v, "", &p), " ") {
				m[a] = true
			}
			for a, _ := range m {
				n, _ := strconv.Atoi(a)
				var j int
				for j = 6; j > 1; j-- {
					if !m[strconv.Itoa(j*n)] {
						break
					}
				}
				if j == 1 {
					fmt.Println(a)
					count--
					if count == 0 {
						goto skip
					}
				}
			}

		}
	}
skip:
}

func permute(s, t string, res *string) string {
	if len(s) > 0 {
		for i, v := range []byte(s) {
			permute(s[:i]+s[i+1:], t+string(v), res)
		}
	} else {
		*res += " " + t
	}
	return (*res)[1:]
}

func combo(r int, e, c string, res *string) string {
	lc, le := len(c), len(e)
	if lc == r || lc+le == r {
		*res += " " + (c + e)[:r]
	} else {
		for i := 0; i <= lc+le-r; i++ {
			combo(r, e[i+1:], c+string(e[i]), res)
		}
	}
	return (*res)[1:]
}
