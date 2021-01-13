package main

import (
	"os"
	"bufio"
	"fmt"
	"strings"
)

func usage() {
	fmt.Println( "Usage: echo [1101][1100][0111][1011]' | go run ch-2.go" )
}

// this function will ignore any other information but "0","1","]"
func getPointsFromMatrixLines (raw string) [][]int {
	var rowsOut [][]int
	// remove new lines separated by []
	lines  := strings.Split(raw, "\n")
	joined := strings.Join(lines,  "")
	matrixlines := strings.Split(joined, "]")

	for ln, line := range matrixlines {
		x := 0
		var points []int
		// cqollect useful data only
		for _, singleStr := range line {
			switch string(singleStr) {
			case "1":
				points = append( points, x )
				x++
			case "0":
				x++
			case "[": // okay but not used
			case " ":
			default:
				fmt.Fprintf( os.Stderr,
					"Wrong character(%s) at row: %d\n",
					singleStr, ln )

			}
		}
		if len(points) > 0 {
			rowsOut = append( rowsOut, points )
		}
	}
	return rowsOut
}

func combiIndex2 (counts int) [][]int {
	combis := [][]int {}
	if counts < 1 {
		return combis
	}

	for fst := 0; fst < (counts -1); fst++ {
		for snd := (fst +1); snd < counts; snd++ {
			combis = append( combis, []int{fst, snd} )
		}
	}
	return combis
}

type HLine struct {
	points []int
	row    int
}

func abs(n int) int {
	if n < 0 {
		return -n
	}
	return n
}

func min(a int, b int) int{
	if a < b {
		return a
	}
	return b
}

func (hl HLine) length() int {
	return abs(hl.points[0] - hl.points[1])
}

func (hl HLine) startingPoint() int {
	return min(hl.points[0], hl.points[1])
}

func getHorizLinesFromPoints ( pointsAtRows [][]int ) []HLine{
	var hlinesAtRows []HLine
	for r, pts := range pointsAtRows {
		for _, ids := range combiIndex2( len(pts) ) {
			hlinesAtRows = append( hlinesAtRows,
				HLine {
					[]int{pts[ids[0]], pts[ids[1]]}, r } )
		}
	}
	return hlinesAtRows
}

type Square struct {
	top     HLine
	bottom  HLine
}

// find some way to make length from points and beginning point
// nicely in golang
func findSquares ( hlines []HLine ) []Square {
	var squares []Square
	for _, ids := range combiIndex2( len(hlines) ) {
		tl, bl := hlines[ids[0]], hlines[ids[1]]
		tlLen := tl.length()
		if tl.startingPoint() == bl.startingPoint() &&
			tlLen == bl.length() {
			if tlLen == abs(tl.row - bl.row) {
				squares = append(squares, Square{ tl, bl })
			}
		}
	}
	return squares
}

func main() {
	reader := bufio.NewReader(os.Stdin)
	matrixString, _ := reader.ReadString('')
	pointsAtRows := getPointsFromMatrixLines( matrixString )


	if len(pointsAtRows) < 2 {
		fmt.Fprintln( os.Stderr,
			"Number of rows is less than two. ",
			": unable to make any squares." )
		os.Exit(1)
	}

	hlines  := getHorizLinesFromPoints( pointsAtRows )
	squares := findSquares( hlines )
	fmt.Fprint(   os.Stderr, "Found Squares are: ")
	fmt.Println( len(squares), "\n" )
	// FIXME: better print out
	fmt.Fprintln( os.Stderr, squares )
	fmt.Fprintln( os.Stderr, "\nFrom Horizontal lines: ")
	fmt.Fprintln( os.Stderr, hlines )
	fmt.Fprintln( os.Stderr, "\nFound Points: ")
	fmt.Fprintln( os.Stderr, pointsAtRows )
	os.Exit(0)
}
