package main

import (
	"fmt"
	"strings"
)

func main() {
	s := "Perl Weekly Challenge"
	l := "e"
	fmt.Printf("%q has %q replaced with %q for %v times and resulted in %q\n",
		s, l, strings.ToUpper(l), strings.Count(s, l), strings.ReplaceAll(s, l, strings.ToUpper(l)))
}
