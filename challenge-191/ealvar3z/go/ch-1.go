package main

import (
	"sort"
)

func Twice_largest(l []int) int {
	sort.Ints(l)
	head := 0
	for _, v := range l[:len(l)-1] {
		head += v
	}
	tail := l[len(l)-1:][0]
	if head > tail {
		return -1
	} else {
		return 1
	}
}
