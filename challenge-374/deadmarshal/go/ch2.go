package main

import (
	"slices"
	"strconv"
)

func groupBy(s string) []string {
	if len(s) == 0 {
		return []string{}
	}

	var result []string
	runes := []rune(s)
	current := []rune{runes[0]}

	for i := 1; i < len(runes); i++ {
		if runes[i] == runes[i-1] {
			current = append(current, runes[i])
		} else {
			result = append(result, string(current))
			current = []rune{runes[i]}
		}
	}

	result = append(result, string(current))
	return result
}

func largestSameDigitNumber(s string) int {
	strs := groupBy(s)
	ints := []int{}
	for _, s := range strs {
		v, _ := strconv.Atoi(s)
		ints = append(ints, v)
	}
	if len(ints) == 0 {
		return 0
	}
	return slices.Max(ints)
}
