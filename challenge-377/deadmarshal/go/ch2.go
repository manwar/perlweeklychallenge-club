package main

import (
	"fmt"
	"strings"
)

func prefixSuffix(arr []string) int {
	pairs := make(map[string]bool)
	for i := 0; i < len(arr); i++ {
		s1 := arr[i]
		for j := i + 1; j < len(arr); j++ {
			s2 := arr[j]
			if !strings.HasPrefix(s2, s1) {
				continue
			}
			diff := len(s2) - len(s1)
			if diff != strings.LastIndex(s2, s1) {
				continue
			}
			key := fmt.Sprintf("%d:%d", i, j)
			pairs[key] = true
		}
	}
	return len(pairs)
}
