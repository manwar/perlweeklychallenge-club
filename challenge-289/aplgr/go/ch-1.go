package main

import (
	"errors"
	"sort"
)

func thirdMax(ints []int) (int, error) {
	if len(ints) == 0 {
		return 0, errors.New("input slice is empty")
	}

	unique := make(map[int]struct{})
	for _, num := range ints {
		unique[num] = struct{}{}
	}

	numsSorted := make([]int, 0, len(unique))
	for num := range unique {
		numsSorted = append(numsSorted, num)
	}

	sort.Slice(numsSorted, func(i, j int) bool {
		return numsSorted[i] > numsSorted[j]
	})

	if len(numsSorted) >= 3 {
		return numsSorted[2], nil
	}
	return numsSorted[0], nil
}
