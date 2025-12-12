package main

import (
	"fmt"
	"slices"
)

func specialAverage(arr []int) int {
	if len(arr) < 2 {
		return 0
	}
	slices.Sort(arr)
	sub, sum := arr[1:len(arr)-1], 0
	for _, n := range sub {
		sum += n
	}
	return sum / len(sub)
}

func main() {
	fmt.Println(specialAverage([]int{8000, 5000, 6000, 2000, 3000, 7000}))
	fmt.Println(specialAverage([]int{100_000, 80_000, 110_000, 90_000}))
	fmt.Println(specialAverage([]int{2500, 2500, 2500, 2500}))
	fmt.Println(specialAverage([]int{2000}))
	fmt.Println(specialAverage([]int{1000, 2000, 3000, 4000, 5000, 6000}))
}
