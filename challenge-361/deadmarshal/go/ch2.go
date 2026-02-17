package main

import (
	"fmt"
)

func findCelebrity(party [][]int) int {
	n := len(party)
	if n == 0 {
		return -1
	}
	cand := 0

	for i := range n {
		if party[cand][i] == 1 {
			cand = i
		}
	}

	for i := range n {
		if i == cand {
			continue
		}
		if party[cand][i] == 1 || party[i][cand] != 1 {
			return -1
		}
	}
	return cand
}

func main() {
	fmt.Println(findCelebrity([][]int{{0, 0, 0, 0, 1, 0},
		{0, 0, 0, 0, 1, 0},
		{0, 0, 0, 0, 1, 0},
		{0, 0, 0, 0, 1, 0},
		{0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 1, 0}}))
	fmt.Println(findCelebrity([][]int{{0, 1, 0, 0},
		{0, 0, 1, 0},
		{0, 0, 0, 1},
		{1, 0, 0, 0}}))
	fmt.Println(findCelebrity([][]int{{0, 0, 0, 0, 0},
		{1, 0, 0, 0, 0},
		{1, 0, 0, 0, 0},
		{1, 0, 0, 0, 0},
		{1, 0, 0, 0, 0}}))
	fmt.Println(findCelebrity([][]int{{0, 1, 0, 1, 0, 1},
		{1, 0, 1, 1, 0, 0},
		{0, 0, 0, 1, 1, 0},
		{0, 0, 0, 0, 0, 0},
		{0, 1, 0, 1, 0, 0},
		{1, 0, 1, 1, 0, 0}}))
	fmt.Println(findCelebrity([][]int{{0, 1, 1, 0},
		{1, 0, 1, 0},
		{0, 0, 0, 0},
		{0, 0, 0, 0}}))
	fmt.Println(findCelebrity([][]int{{0, 0, 1, 1},
		{1, 0, 0, 0},
		{1, 1, 0, 1},
		{1, 1, 0, 0}}))
}
