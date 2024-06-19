package main

import (
	"fmt"
	"os"
	"regexp"
)

func main() {
	if len(os.Args) != 2 {
		usage()
		return
	}

	// check, _ := regexp.Match(`m/^[^b]*b[^b]/`, []byte(os.Args[1]))
	check, _ := regexp.Match("^[^b]*b([^a]|$)", []byte(os.Args[1]))
	fmt.Printf("Output: %t\n", check)
}

func usage() {
	fmt.Fprintln(os.Stderr, "Usage:")
	fmt.Fprintln(os.Stderr, "")
	fmt.Fprintln(os.Stderr, "Calculate whether there is a 'b' in a string where the first 'b' isn't followed by an 'a'")
	fmt.Fprintln(os.Stderr, "")
	fmt.Fprintln(os.Stderr, "  "+os.Args[0]+" <str>")
	fmt.Fprintln(os.Stderr, "")
}
