package main

func largestContiguousBlock(matrix [][]rune) int {
	rows := len(matrix)
	if rows == 0 {
		return 0
	}
	cols := len(matrix[0])
	visited := make([][]bool, rows)
	for i := range visited {
		visited[i] = make([]bool, cols)
	}

	maxSize := 0

	for r := 0; r < rows; r++ {
		for c := 0; c < cols; c++ {
			symbol := matrix[r][c]
			size := dfs(matrix, visited, r, c, symbol)
			if size > maxSize {
				maxSize = size
			}
		}
	}

	return maxSize
}

func dfs(matrix [][]rune, visited [][]bool, row, col int, symbol rune) int {
	if row < 0 || row >= len(matrix) || col < 0 || col >= len(matrix[0]) ||
		visited[row][col] || matrix[row][col] != symbol {
		return 0
	}

	visited[row][col] = true
	count := 1

	count += dfs(matrix, visited, row+1, col, symbol)
	count += dfs(matrix, visited, row-1, col, symbol)
	count += dfs(matrix, visited, row, col+1, symbol)
	count += dfs(matrix, visited, row, col-1, symbol)

	return count
}
