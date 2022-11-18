package main

import "fmt"

func cute_list(n int) int {
	count := 0
	position := 1

	visited := make([]bool, n+1)
	backtrack(n, position, &count, visited)
	return count
}

func backtrack(n int, pos int, count *int, visited []bool) {
	if pos > n {
		*count++
	}

	for i := n; i >= 1; i-- {
		if visited[i] || (i%pos != 0 && pos%i != 0) {
			continue
		}
		visited[i] = true
		backtrack(n, pos+1, count, visited)
		visited[i] = false
	}
	return
}

func main() {
	fmt.Println(cute_list(2))
}
