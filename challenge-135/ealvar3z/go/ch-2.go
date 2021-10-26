package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strings"
)

// You are given 7-characters alphanumeric SEDOL.
// Write a script to validate the given SEDOL. Print 1 if it is a valid SEDOL otherwise 0.
// For more information about SEDOL, please checkout the wikipedia page.

//  Example 1
// Input: $SEDOL = '2936921'
// Output: 1

//  Example 2
// Input: $SEDOL = '1234567'
// Output: 0

//  Example 3
// Input: $SEDOL = 'B0YBKL9'
// Output: 1

func main() {
	r := bufio.NewReader(os.Stdin)
	// set the weights per the wikipedia page
	w := []rune{1, 3, 1, 7, 3, 9, 1}

	for {
		txt, err := r.ReadString('\n')
		if err != nil {
			break
		}
		// strip new lines
		txt = strings.TrimRight(txt, "\n")

		// check for syntax
		m, _ := regexp.MatchString("^[0-9BCDFGHJKLMNPQRSTVWXYZ]{6}[0-9]$", txt)

		if !m {
			fmt.Println("Invalid SEDOL Number")
			continue
		}
		// check the sum
		var check rune = 0
		for i, rune := range txt {
			if rune <= '9' {
				// too much magic in that example
				// i'll simply substract from the
				// upper limit of the rune
				rune -= '0'
			} else {
				rune -= 'A'
			}
			// bounce it against the weights
			check += w[i] * rune
		}
		if check%10 == 0 {
			fmt.Println("1")
		} else {
			fmt.Println("0")
		}
	}
}
