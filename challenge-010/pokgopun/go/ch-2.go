/* https://theweeklychallenge.org/blog/perl-weekly-challenge-010/
Challenge #2
Write a script to find Jaro-Winkler distance between two strings. For more information check wikipedia page.
*/
package main

import (
	"fmt"
	"os"

	"github.com/pokgopun/go/jarowinkler"
)

func main() {
	if len(os.Args) > 2 {
		jw := jarowinkler.New(os.Args[1], os.Args[2])
		//fmt.Printf("%.3f %.3f\n", jw.Similarity(false), jw.Similarity(true))
		fmt.Printf("%.3f\n", jw.Distance(true))
	} else {
		fmt.Println(`
Usage:
	%cmd% %str1% %str2%`)
	}
}
