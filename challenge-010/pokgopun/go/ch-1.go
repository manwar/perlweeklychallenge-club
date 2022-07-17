/* https://theweeklychallenge.org/blog/perl-weekly-challenge-010/

Challenge #1
Write a script to encode/decode Roman numerals. For example, given Roman numeral CCXLVI, it should return 246. Similarly, for decimal number 39, it should return XXXIX. Checkout wikipedia page for more informaiton.

*/
package main

import (
	"fmt"
	"log"
	"os"
	"strconv"

	"github.com/pokgopun/go/roman"
)

func main() {
	guide := `
Usage:
	To encode decimal number to roman, enter:
	%cmd% encode %number%

	To decode roman number string to decimal number, enter:
	%cmd% decode %string%
	`
	roman := roman.NewRoman()
	if len(os.Args) > 2 && (os.Args[1] == "encode" || os.Args[1] == "decode") {
		switch os.Args[1] {
		case "encode":
			n, err := strconv.ParseUint(os.Args[2], 10, 64)
			if err != nil {
				log.Fatal(err)
			}
			str, err := roman.FromDec(uint(n))
			if err != nil {
				log.Fatal(err)
			}
			fmt.Println(str)
		case "decode":
			n, err := roman.ToDec(os.Args[2])
			if err != nil {
				log.Fatal(err)
			}
			fmt.Println(n)
		}
	} else {
		fmt.Println(guide)
		for _, v := range []uint{246, 39} {
			str, _ := roman.FromDec(v)
			fmt.Printf("\tencode %v => %v\n\n", v, str)
		}
		for _, v := range []string{"CCXLVI", "XXXIX"} {
			n, _ := roman.ToDec(v)
			fmt.Printf("\tdecode %v => %v\n\n", v, n)
		}
	}
}
