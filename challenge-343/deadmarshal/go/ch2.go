package main

import (
	"fmt"
)

func championTeam(grid [][]int) int {
	m := 0
	h := map[int]int{}
	for y := 0; y < len(grid); y++ {
		for x := 0; x < len(grid[y]); x++ {
			w := 0
			if grid[y][x] == 1 {
				w = y
			} else {
				w = x
			}
			h[w]++
			if h[w] > h[m] {
				m = w
			}
		}
	}
	return m
}

func main() {
	fmt.Println(championTeam([][]int{{0, 1, 1}, {0, 0, 1}, {0, 0, 0}}))
	fmt.Println(championTeam([][]int{{0, 1, 0, 0}, {0, 0, 0, 0},
		{1, 1, 0, 0}, {1, 1, 1, 0}}))
	fmt.Println(championTeam([][]int{{0, 1, 0, 1}, {0, 0, 1, 1},
		{1, 0, 0, 0}, {0, 0, 1, 0}}))
	fmt.Println(championTeam([][]int{{0, 1, 1}, {0, 0, 0}, {0, 1, 0}}))
	fmt.Println(championTeam([][]int{{0, 0, 0, 0, 0}, {1, 0, 0, 0, 0},
		{1, 1, 0, 1, 1}, {1, 1, 0, 0, 0}, {1, 1, 0, 1, 0}}))
}
