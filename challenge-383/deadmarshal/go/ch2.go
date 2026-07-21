package main

import (
	"fmt"
	"strconv"
)

func nearestRGB(color string) string {
	webSafe := []int{0, 51, 102, 153, 204, 255}
	r := hexToInt(color[1:3])
	g := hexToInt(color[3:5])
	b := hexToInt(color[5:7])
	res := "#"
	for _, c := range []int{r, g, b} {
		best := 0
		for _, s := range webSafe {
			if abs(c-s) < abs(best-c) {
				best = s
			}
		}
		res += fmt.Sprintf("%02X", best)
	}
	return res
}

func hexToInt(s string) int {
	val, _ := strconv.ParseInt(s, 16, 64)
	return int(val)
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}
