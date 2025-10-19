package main

import (
	"fmt"
	"math"
)

func zeroFriend(arr []int) int {
	res := math.MaxInt
	for _, e := range arr {
		ae := int(math.Abs(float64(e)))
		if ae < res {
			res = ae
		}
	}
	return res
}

func main() {
	fmt.Println(zeroFriend([]int{4, 2, -1, 3, -2}))
	fmt.Println(zeroFriend([]int{-5, 5, -3, 3, -1, 1}))
	fmt.Println(zeroFriend([]int{7, -3, 0, 2, -8}))
	fmt.Println(zeroFriend([]int{-2, -5, -1, -8}))
	fmt.Println(zeroFriend([]int{-2, 2, -4, 4, -1, 1}))
}
