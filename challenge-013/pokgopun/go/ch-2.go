/*
 F ( 0 ) = 1   ;   M ( 0 ) = 0
 F ( n ) = n − M ( F ( n − 1 ) ) , n > 0
 M ( n ) = n − F ( M ( n − 1 ) ) , n > 0.
*/
package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func main() {
	w := bufio.NewWriter(os.Stdout)
	fmt.Fprintf(w, "| %4s | %4s | %4s |", "n", "F(n)", "M(n)")
	w.WriteString("\n" + strings.Repeat("-", w.Buffered()) + "\n")
	var n uint
	for n <= 20 {
		fmt.Fprintf(w, "| %4d | %4d | %4d |\n", n, female(n), male(n))
		n++
	}
	w.Flush()
}

func female(n uint) uint {
	if n == 0 {
		return 1
	}
	return n - male(female(n-1))
}

func male(n uint) uint {
	if n == 0 {
		return 0
	}
	return n - female(male(n-1))
}
