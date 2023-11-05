package main

import (
	"fmt"
)

type interval struct {
	x, y int
}

func conflictIntervals(arr []interval) {
	for i := 1; i < len(arr); i++ {
		b := false
		for j := 0; j < i; j++ {
			if arr[i].x >= arr[j].x && arr[i].x <= arr[j].y {
				b = true
			}
		}
		if b {
			fmt.Printf("(%d %d) ", arr[i].x, arr[i].y)
		}
	}
	fmt.Println()
}

func main() {
	arr := []interval{{1, 4}, {3, 5}, {6, 8}, {12, 13}, {3, 20}}
	arr2 := []interval{{3, 4}, {5, 7}, {6, 9}, {10, 12}, {13, 15}}
	conflictIntervals(arr)
	conflictIntervals(arr2)
}
