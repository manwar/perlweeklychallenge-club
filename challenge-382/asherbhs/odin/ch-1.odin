package main

import "core:fmt"
import "core:math"
import "core:slice"
// import "core:time"

hamiltonian_cycle :: proc(n: int) -> []int {
	// make adjacency list
	graph := make([][dynamic]int, n)
	defer delete(graph)
	for i in 0..<n do graph[i] = make([dynamic]int)
	defer for i in 0..<n do delete(graph[i])
	for i in 0..<(n-1) {
		for j in (i+1)..<n {
			root := math.sqrt(f64(i + j + 2))
			if root == math.floor(root) {
				append(&graph[i], j)
				append(&graph[j], i)
			}
		}
	}

	// depth first search
	path  := make([dynamic]int, 0, n)     // stack of visited nodes
	nexti := make([dynamic]int, 0, n)     // stack of next child indices
	seen  := make([]bool, n)              // which nodes are on the path
	defer { delete(nexti); delete(seen) } // defer cleanup - path is returned
	append(&path,  0)                     // initial state: [0]         start at node 0
	append(&nexti, 0)                     //                [0]         look at its first child
	seen[0] = true                        //                [1 0 0 ..]  mark it as seen
	for len(path) > 0 {
		this := len(path) - 1                                                       // index of this node
		next := graph[path[this]]                                                   // slice of children
		if len(path) == n && slice.contains(next[:], 0) do break                    // found cycle?
		for nexti[this] < len(next) && seen[next[nexti[this]]] do nexti[this] += 1  // skip children already in the path
		if nexti[this] < len(next) {                                                // if there are unvisited children
			next := next[nexti[this]] // the child
			append(&path, next)       // put it on the path
			seen[next] = true         // mark it as on the path
			nexti[this] += 1          // go to next child next time we get back here
			append(&nexti, 0)         // look at first grandchild
		} else {                                                                    // if there are no unvisited children
			popped := pop(&path)      // discard node
			pop(&nexti)               // ditto
			seen[popped] = false      // mark it as not on the path
		}
	}
	for _, i in path do path[i] += 1
	return path[:]
}

main :: proc() {
	cycle: []int
	cycle = hamiltonian_cycle(32); fmt.println(cycle); delete(cycle)
	cycle = hamiltonian_cycle(15); fmt.println(cycle); delete(cycle)
	cycle = hamiltonian_cycle(34); fmt.println(cycle); delete(cycle)
}
