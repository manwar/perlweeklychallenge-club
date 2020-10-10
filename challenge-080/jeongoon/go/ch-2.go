package main

/* Ref:
https://golangdocs.com/slices-in-golang
*/

/* test with:
go run ch-2.go 1 5 4 2
# > 6
*/

import (
	"fmt"
	"os"
	"strconv"
)

func main() {
	args := os.Args[1:] // ignore programme name
	rank := []int{}

	for _, it := range args {
		int_val, err := strconv.Atoi( it )
		if err != nil {
			fmt.Fprint( os.Stderr, err )
			fmt.Fprintln( os.Stderr, ": skipped" )
			continue
		}
		rank = append( rank, int_val )
	}
	rank_len := len(rank)
	if rank_len == 0 {
		fmt.Println("0 as no useuful data")
		os.Exit(1)
	}

	left  := rank[0:rank_len -1]
	right := rank[1:]

	candies := rank_len

	for i := 0; i < rank_len -2; i++ {
		if left[i] != right[i] {
			candies++
		}
	}
	fmt.Println(candies)
}
