/* https://theweeklychallenge.org/blog/perl-weekly-challenge-047/
TASK #1
Roman Calculator
Write a script that accepts two roman numbers and operation. It should then perform the operation on the give roman numbers and print the result.

For example,

perl ch-1.pl V + VI
It should print

XI
*/
package main

import (
	"fmt"
	"log"
	"os"
	"strings"

	"github.com/pokgopun/go/roman"
)

func main() {
	guide := `
Usage:
	%cmd% %RomanString1% %op% %RomanString2%

	supported ops are + and -
	result less than 1 or greater than 3999 will get error as it cannot be displayed in standard roman form

	MMXXII + DXLIII
	MMDLXV

	MMDLXV - DXLIII
	MMXXII`
	var str1, op, str2 string
	_, err := fmt.Sscanf(strings.Join(os.Args[1:], " "), "%s %s %s", &str1, &op, &str2)
	if err != nil {
		fmt.Println(guide)
		os.Exit(0)
	}
	roman := roman.NewRoman()
	r1, err1 := roman.ToDec(str1)
	r2, err2 := roman.ToDec(str2)
	if err1 != nil {
		fmt.Println("RomanString1:", err1)
	}
	if err2 != nil {
		fmt.Println("RomanString2:", err2)
	}
	if err1 != nil || err2 != nil {
		os.Exit(1)
	}
	switch op {
	case "+":
		r, err := roman.FromDec(r1 + r2)
		if err != nil {
			log.Fatal(err)
		}
		fmt.Println(r)
	case "-":
		r, err := roman.FromDec(r1 - r2)
		if err != nil {
			log.Fatal(err)
		}
		fmt.Println(r)
	default:
		log.Fatal("invalid ops: supported ops are +,-,*")
	}
}
