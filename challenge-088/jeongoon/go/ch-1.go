package main

import (
	"os"
	"fmt"
	"strconv"
)

func usage() {
	fmt.Println( "Usage: go run ch-1.go <integer> ..." )
}

func main() {
	switch len(os.Args[1:]) {
	case 0:
		usage()
		os.Exit(1);
	case 1:
		fmt.Println("1")
		os.Exit(0);
	}

	var ns []int

	for _, nstr := range os.Args[1:] {
		n, err := strconv.Atoi(nstr)
		if err == nil {
			ns = append(ns, n)
		} else {
			fmt.Fprintln(os.Stderr, nstr, "is ignored: ", err)
		}
	}

	p := 1
	for _, v := range ns {
		p *= v
	}

	var ms []int

	for _,v := range ns {
		ms = append(ms, (p/v))
	}

	fmt.Println(ms)
	os.Exit(0)
}
