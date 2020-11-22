// tested with go run ch-1.go 1 3 2 -1 -2 -3 6 7 9 10

package main

import (
	"os"
	"fmt"
	"sort"
	"strconv"
)

func usage() {
	fmt.Println( "Usage: go run ch-1.go <target diff(positive interger)> <integer> ..." )
}

func main() {
	if len(os.Args[1:]) < 3 {
		usage()
		os.Exit(1);
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

	df := ns[ 0]	// diff
	ns  = ns[1:]
	sort.Ints(ns)

	found := false

	for i := 1; i < len(ns); i++ {
		cdf := ns[i] - ns[0]
		if cdf == df {
			fmt.Printf("1 as %d - %d = %d", ns[i], ns[0], df)
			found = true
			break
		} else if cdf > df { // no need to check further
			ns = ns[1:]  // reduce list size
			i  = 1       // and reset cursor
		}
	}

	if ! found {
		fmt.Println("0")
	}

}
