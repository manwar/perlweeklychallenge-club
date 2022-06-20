/*
You are given 2 matrices.

Write a script to implement Kronecker Product on the given 2 matrices.

Usage:
go run ch-2.go '[[1,2,3],[4,5,6],[7,8,9]]' '[[9,8,7],[6,5,4],[3,2,1]]'
A = [1 2 3]
    [4 5 6]
    [7 8 9]

B = [9 8 7]
    [6 5 4]
    [3 2 1]

A x B = [ 9  8  7 18 16 14 27 24 21]
        [ 6  5  4 12 10  8 18 15 12]
        [ 3  2  1  6  4  2  9  6  3]
        [36 32 28 45 40 35 54 48 42]
        [24 20 16 30 25 20 36 30 24]
        [12  8  4 15 10  5 18 12  6]
        [63 56 49 72 64 56 81 72 63]
        [42 35 28 48 40 32 54 45 36]
        [21 14  7 24 16  8 27 18  9]
*/
package main

import (
	"bufio"
	"encoding/json"
	"log"
	"os"

	"github.com/pokgopun/go/kronecker"
)

func main() {
	var matrix [3][][]int
	if len(os.Args) > 2 {
		for i := 0; i < 2; i++ {
			err := json.Unmarshal([]byte(os.Args[i+1]), &matrix[i])
			if err != nil {
				log.Fatal(err)
			}
		}
	} else {
		matrix = [3][][]int{
			[][]int{
				[]int{1, 2},
				[]int{3, 4},
			},
			[][]int{
				[]int{5, 6},
				[]int{7, 8},
			},
		}
	}
	var err error
	matrix[2], err = kronecker.Product(matrix[0], matrix[1])
	if err != nil {
		log.Fatal(err)
	}
	w := bufio.NewWriter(os.Stdout)
	for i, v := range []string{"A", "B", "A x B"} {
		w.WriteString(kronecker.MatrixString(v, matrix[i]) + "\n")
	}
	w.Flush()
}
