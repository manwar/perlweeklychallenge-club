/* tested with:
 * echo "[a b c][d e f][g h i]" | go run ch-2.go
 * echo "[a b c d][e f g h][i j k l]" | go run ch-2.go
 */

package main

import (
	"os"
	"bufio"
	"fmt"
	"strings"
)

func usage() {
	fmt.Println( "Usage: echo [a b c][d e f][g h i][j k l]' | go run ch-2.go" )
}

func parseMatrix (raw string) [][]string {
	var mat [][]string

	lines  := strings.Split(raw, "\n")
	for _, line := range lines {
		sublines := strings.Split(line, "]")

		for _, sl := range sublines {
			if len(sl) < 1 {
				continue
			}
			ws := strings.Split(sl, " ")
			var words []string
			for _, w := range ws {
				if len(w) < 1 {
					continue
				}
				words = append(words,
					strings.Replace(w, "[", "", 1))
			}
			mat = append(mat, words)
		}

	}
	return mat
}

// translate from ch-2.lsp
func getSpiralArray (mat [][]string) []string {
	var sarr []string

	num_rows := len(mat)
	num_cols := len(mat[0])
	for o := 0 ; num_rows > 0 && num_cols > 0; o++ {
		row_end := o + num_rows -1
		col_end := o + num_cols -1
		// north
		sarr = append(sarr, mat[o][o:col_end+1]...)
		// east
		if num_rows > 1 {
			for r := o+1; r <= row_end; r++ {
				sarr = append(sarr, mat[r][col_end])
			}
			// south
			if num_cols > 1 {
				for c := col_end -1; c >= o; c-- {
					sarr = append(sarr, mat[row_end][c])
				}
				// west
				if num_rows > 2 {
					for r := row_end -1; r > o; r-- {
						sarr = append(sarr, mat[r][o]);
					}
				}
			}
		}

		// go inner
		num_rows -= 2
		num_cols -= 2
	}

	return sarr
}

func main() {
	reader := bufio.NewReader(os.Stdin)
	matrixString, _ := reader.ReadString('')
	matrix := parseMatrix(matrixString)
	if len(matrix) < 1 {
		usage()
		os.Exit(1)
	}

	fmt.Println(getSpiralArray(matrix))
}
