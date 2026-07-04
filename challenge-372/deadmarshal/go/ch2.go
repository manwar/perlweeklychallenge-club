package main

func largestSubstring(s string) int {
	res := -1
	last := make(map[rune]int)
	for j, c := range s {
		if i, ok := last[c]; ok {
			res = max(res, j-i-1)
		} else {
			last[c] = j
		}
	}
	return res
}
