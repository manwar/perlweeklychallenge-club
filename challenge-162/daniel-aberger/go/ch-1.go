package main

import (
	"fmt"
	"os"
	"strconv"
)

func main() {
	input := os.Args[1]
	isbn := make([]int, 0)
	for _, r := range input {
		i, err := strconv.Atoi(string(r))
		if err != nil {
			continue
		}
		isbn = append(isbn, i)
	}
	if len(isbn) < 12 || len(isbn) > 13 {
		fmt.Println("ISBN malformed")
		os.Exit(1)
	}
	sum := 0
	for k, v := range isbn {
		if k == 12 {
			break
		}
		if k%2 == 1 {
			sum += v * 3
		} else {
			sum += v
		}
	}
	if len(isbn) == 13 {
		if 10-sum%10 == isbn[12] {
			fmt.Println("correct checksum!")
		} else {
			fmt.Println("incorrect checksum!")
		}
	} else {
		fmt.Printf("checksum: %d\n", 10-sum%10)
	}
}
