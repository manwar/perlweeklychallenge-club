package ch2

import (
	"errors"
	"strconv"
	"strings"
)

var ErrNotFound = errors.New("not found")

func stringDifference(words []string) (string, error) {
	h := make(map[string]int)
	keys := make([]string, 0, len(words))

	for _, w := range words {
		parts := make([]string, 0, len(w))
		for j := 0; j+1 < len(w); j++ {
			d := int(w[j+1]) - int(w[j])
			parts = append(parts, strconv.Itoa(d))
		}
		key := strings.Join(parts, ",")
		keys = append(keys, key)
		h[key]++
	}
	for i, w := range words {
		if h[keys[i]] == 1 {
			return w, nil
		}
	}
	return "", ErrNotFound
}
