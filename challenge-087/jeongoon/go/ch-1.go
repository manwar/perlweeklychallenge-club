// tested with go run ch-1.go 1 3 2 -1 -2 -3 6 7 9 10

package main

import (
	"os"
	"fmt"
	"sort"
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
		fmt.Println("0 as only one element given")
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

	sort.Ints(ns)

	longest_size := 0
	longest_seq_ls := [][]int{}
	cseq := []int{}

	lv := ns[0]; // last value
	ns = append(ns, ns[len(ns)-1] + 2) // add dummy

	for _, v := range ns[1:] {
		switch v - lv {
		case 1: // add new member to current seq
			if len(cseq) == 0 {
				cseq = []int{lv, v}
			} else {
				cseq = append(cseq, v)
			}
		case 0: // skip
		default:
			clen := len(cseq)
			if longest_size < clen {		// new longest !

				// update size
				longest_size = clen
				// new longest seq
				longest_seq_ls = [][]int{ cseq }
			} else if ( longest_size == clen ) {	// same longest
				// add to longest_seq_ls
				longest_seq_ls = append(longest_seq_ls, cseq)
			}
			// reset current status
			cseq = []int{}
		}
		lv = v  // update last value
	}

	if len(longest_seq_ls) > 0 {
		fmt.Println("longest size:", longest_size)
		fmt.Println("sequence(s):")
		for _, sq := range longest_seq_ls {
			fmt.Println(sq)
		}
	} else {
		fmt.Println("0")
	}

}
