package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

// TASK #1: Middle 3-digits
// You are given an integer.
// Write a  script find out the middle 3-digits of  the given integer, if possible otherwise throw sensible
// error.

// Example 1
// Input: $n = 1234567
// Output: 345

// Example 2
// Input: $n = -123
// Output: 123

// Example 3
// Input: $n = 1
// Output: too short

// Example 4
// Input: $n = 10
// Output: even number of digits

func main() {
	r := bufio.NewReader(os.Stdin)

	// labeled loop for easier debugging
repeat:
	for {
		txt, err := r.ReadString('\n')
		if err != nil {
			break
		}
		// strip the newline
		txt = strings.TrimRight(txt, "\n")

		// remove the leading sign, if there are any
		if txt[0:1] == "-" || txt[0:1] == "+" {
			txt = txt[1:]
		}

		// check if char is a num
		for _, c := range txt {
			if c < '0' || c > '9' {
				fmt.Println("not an integer")
				continue repeat
			}
		}
		// is it an even num?
		if len(txt)%2 == 0 {
			fmt.Println("even number of digits")
			continue repeat
		}
		// how long is this things?
		if len(txt) < 3 {
			fmt.Println("too short")
			continue repeat
		}
		// snatch the 3 middle ones
		fmt.Printf("%+v\n", txt[(len(txt)-3)/2:(len(txt)+3)/2])
	}
}
