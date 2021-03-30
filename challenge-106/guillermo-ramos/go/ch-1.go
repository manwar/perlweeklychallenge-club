package main

import (
	"fmt"
	"os"
	"sort"
	"strconv"
)

func main() {
	numbers := make(sort.IntSlice, 0, len(os.Args)-1)
	for _, v := range os.Args[1:] {
		n, err := strconv.Atoi(v)
		if err != nil {
			fmt.Println(err)
			os.Exit(1)
		}
		numbers = append(numbers, n)
	}
	sort.Sort(numbers)
	var maxGap int
	for i := 0; i < len(numbers)-1; i++ {
		diff := numbers[i+1] - numbers[i]
		if diff > maxGap {
			maxGap = diff
		}
	}
	fmt.Println(maxGap)
}
