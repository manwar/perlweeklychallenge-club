/*
Ref:
https://golangbyexample.com/length-of-string-golang/
https://golangdocs.com/concatenate-strings-in-golang
*/

// test with: go run ch-1.go abcabc abcabcabcabc


package main

import (
	"os"
	"fmt"
	"strings"
)

func commonDivisors ( a int, b int ) []int {
	var result []int
	var min int
	if a < b {
		min = a
	} else {
		min = b }

	for i := 1; i <= min; i++ {
		if ( a % i == 0  && b % i ==0 ) {
			result = append( result, i );
		}
	}
	return result
}

// trying to make a method but it wasn't good idea :-/
type StrTest string
//https://stackoverflow.com/questions/28800672/how-to-add-new-methods-to-an-existing-type-in-go
func (substr StrTest) RepeatedIn(str string) bool {
	return (
		len(str) % len(substr) == 0 &&
			str == strings.Repeat( string(substr),
				len(str) / len(substr) ) )
}

func main() {
	AB := os.Args[1:3]

	var baseStrings []string;

        next_common_divisor:
	for _, dv := range commonDivisors( len(AB[0]), len(AB[1]) ) {
		mbs := AB[0][0:dv] // maybe base string
		for _, x := range AB {
			if ! StrTest(mbs).RepeatedIn( x ) {
				continue next_common_divisor;
			}
		}
		// copying is the only way??
		baseStrings = append( baseStrings, mbs )
	}

	fmt.Println( strings.Join(baseStrings, " " ) )
}
