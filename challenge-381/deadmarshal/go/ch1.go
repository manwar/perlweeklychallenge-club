package main

func sameRowColumn(m [][]int) bool {
	n := len(m)
	for _, row := range m {
		h := make(map[int]bool)
		for _, num := range row {
			if num < 1 || num > n || h[num] {
				return false
			}
			h[num] = true
		}
	}

	for col := 0; col < n; col++ {
		h := make(map[int]bool)
		for _, row := range m {
			num := row[col]
			if num < 1 || num > n || h[num] {
				return false
			}
			h[num] = true
		}
	}
	return true
}
