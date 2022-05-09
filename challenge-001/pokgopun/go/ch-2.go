package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

var (
	rseen [15]bool
	r2str [15]string
)

func main() {
	w := bufio.NewWriter(os.Stdout)
	n, _ := strconv.Atoi(append(os.Args, "20")[1])
	for i := 1; i <= n; i++ {
		fmt.Fprintf(w, "%v ", fizzbuzz(i))
	}
	w.Flush()
	fmt.Print("\n")
}

func fizzbuzz(n int) (str string) {
	r := n % 15
	if rseen[r] {
		str = r2str[r]
		if str == "" {
			return strconv.Itoa(n)
		}
		return str
	}
	rseen[r] = true
	switch {
	case r == 0:
		str = "fizzbuzz"
	case r%3 == 0:
		str = "fizz"
	case r%5 == 0:
		str = "buzz"
	default:
		return strconv.Itoa(n)
	}
	r2str[r] = str
	return str
}
