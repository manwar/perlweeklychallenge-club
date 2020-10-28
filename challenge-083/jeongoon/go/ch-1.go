package main

import (
	"os"
	"fmt"
	"strings"
)

func usage() {
	fmt.Println( "Usage: go run ch-1.go \"a single string\"" )
}

func main() {
	if len(os.Args[1:]) != 1 {
		usage()
		os.Exit(1);
	}

	words := strings.Split( os.Args[1], " " );
	if len(words) < 3 {
		fmt.Fprintln( os.Stderr,
			"words must contain at least three words" )
		os.Exit(2);
	}

	middleCharsExceptWhitespace := 0
	for _, c := range words[ 1 : len(words)-1 ] {
		middleCharsExceptWhitespace += len(c)
	}

	fmt.Println( middleCharsExceptWhitespace )
}
