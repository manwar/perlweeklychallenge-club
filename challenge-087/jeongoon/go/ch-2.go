/* tested with: echo '[000111][111111][001001][001111][001111]' | go run ch-2.go
 *  `-> example 3
 * echo '[101010][010101][101010][010101]' | go run ch-2.go
 *  `-> example 1
 */
package main

import (
	"os"
	"bufio"
	"fmt"
	"strings"
	"reflect"
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
		// collect useful data only
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
		rowsOut = append( rowsOut, points )
	}
	return rowsOut
}


type FullHLine struct {
	points []int
	row    int
}

func (hl FullHLine) Length() int {
	return hl.points[len(hl.points)-1] - hl.points[0]
}

func (hl FullHLine) StartingPoint() int {
	return hl.points[0]
}

type Rect struct {
	rows []int
	cols []int
}

func (rect Rect) NorthWest() (int, int) {
	// ref: https://gobyexample.com/multiple-return-values
	return rect.rows[0], rect.cols[0]
}

func (rect Rect) Area() int {
	return len(rect.rows) * len(rect.cols)
}

func getSubHorizLinesFromHorizLines ( hlinesARow []FullHLine ) []FullHLine {
	var subHlinesAtARow []FullHLine
	for _, hline := range hlinesARow {
		for hl := hline ;len(hl.points) > 0; hl.points = hl.points[1:] {
			var pnts_so_far []int;
			for _, pnt := range(hl.points) {
				pnts_so_far = append(pnts_so_far, pnt)
				subHlinesAtARow = append(subHlinesAtARow,
					FullHLine {pnts_so_far, hline.row} )
			}
		}
	}
	return subHlinesAtARow
}

func getHorizLinesFromPoints ( pointsAtRows [][]int ) [][]FullHLine{
	var hlinesAtRows [][]FullHLine

	for r, points := range pointsAtRows {
		// note: a point will be allowed as a line
		//       so we can make a vertical line later on
		//       and vertical line is regarded as a rectangle
		//       in my implementation
		if len(points) == 0 {
			continue // skip empty line
		}
		points = append(points, points[len(points)-1] + 2) // dummy
		prev := points[0]
		pnts := []int{prev}
		var hlinesAtARow []FullHLine

		for _, curr := range points[1:] {
			if (curr - prev) == 1 {
				pnts = append(pnts, curr)
			} else {
				if len(pnts) > 0 {
					hlinesAtARow = append(hlinesAtARow,
						FullHLine { pnts, r } )
				}
				pnts = []int{curr}
			}
			prev = curr
		}

		hlinesAtRows = append(hlinesAtRows,
			getSubHorizLinesFromHorizLines(hlinesAtARow))
	}

	return hlinesAtRows
}

func findLargestRectanglesFromHorizLines (hlinesAtRows [][]FullHLine) []Rect {
	var largestRects []Rect
	largestArea := 0

	/* note: checking procedure is similar to below
         * 1 2 3 4 -> // each number represents row number
         * 1 -> 1 2 -> 1 2 3 -> 1 2 3 4 // but intersection is decreasing
         * 2 -> 2 3 -> 2 3 4 ->
         * 3 -> 3 4 ->
         * 4
         */

	
	for
	base, har := 0, hlinesAtRows;
	len(har) > 0;
	base, har  = base+1, har[1:] {
		intersects := har[0]	// initial intersection is same as first row
		var rows []int
	candidates:
		for offset, candi:= range har {
			rows = append(rows, base+offset)
			var inters []FullHLine
			for _, hlc := range candi {
				for _, hli := range intersects {
					if hli.row != hlc.row &&
						hlc.row - hli.row > 1 {
						// ignore if not consecutive
						continue;
					}
					if reflect.DeepEqual(
						hlc.points, hli.points) {
						//fmt.Println( base, ":", hlc, "~~", hli )
						// keep intersection
						inters = append(inters, hlc)
						r_cp := rows
						c_cp := hli.points
						rect := Rect { r_cp,c_cp }
						narea := rect.Area()
						if narea == 1 {
							// skip a point
							continue
						}
						// compare with largest
						// and update largest
						// if needed
						if largestArea < narea {
							largestArea =
								narea
							largestRects =
								[]Rect{rect}
							//fmt.Println( "new largest", largestRects)
						} else if largestArea ==
							narea {
							largestRects = append(
								largestRects,
								rect )
							//fmt.Println( "update largest", largestRects)
						}
					} else {
						// remove from intersec.
					}
				}
				if len(inters) == 0 {
					break candidates // no need to go further
				} else {
					copy(intersects, inters)
				}
			}
		}
	}
	return largestRects
}

func main() {
	reader := bufio.NewReader(os.Stdin)
	matrixString, _ := reader.ReadString('')
	pointsAtRows := getPointsFromMatrixLines(matrixString)
	hlinesAtRows  := getHorizLinesFromPoints(pointsAtRows)
	//fmt.Println( hlinesAtRows )
	largestRects := findLargestRectanglesFromHorizLines(hlinesAtRows)

	if len(largestRects) == 0 {
		fmt.Println("0 as no rectangle found")
		os.Exit(1)
	} else {
		fmt.Fprintln(os.Stderr, "Area:", largestRects[0].Area())
		for _, rect := range largestRects {
			y, x := rect.NorthWest()
			fmt.Fprintf(os.Stderr, "At: (r:%d,c:%d)\n", y, x)
			for range rect.rows {
				fmt.Print("1")
				for range rect.cols[1:] {
					fmt.Print(" 1")
				}
				fmt.Println("")
			}
		}
	}
	os.Exit(0)
}
