package main

import (
	"fmt"
	"slices"
)

func arithmeticProgression(arr []float64) bool {
	slices.Sort(arr)
	d := arr[1] - arr[0]
	for i := 2; i < len(arr); i++ {
		if arr[i]-arr[i-1] != d {
			return false
		}
	}
	return true
}

func main() {
	fmt.Println(arithmeticProgression([]float64{1, 3, 5, 7, 9}))
	fmt.Println(arithmeticProgression([]float64{9, 1, 7, 5, 3}))
	fmt.Println(arithmeticProgression([]float64{1, 2, 4, 8, 16}))
	fmt.Println(arithmeticProgression([]float64{5, -1, 3, 1, -3}))
	fmt.Println(arithmeticProgression([]float64{1.5, 3, 0, 4.5, 6}))
}
