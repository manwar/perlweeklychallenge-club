package main

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"os"
	"strings"
)

//type rectangle struct {
//	posL      coordinate
//	posH      coordinate
//	dimension int
//}
//
//type coordinate struct {
//	x, y, z int
//}
type rectangle struct {
	pointL []int
	pointH []int
}

func main() {
	var jsonStream string
	if len(os.Args) > 1 {
		for _, v := range os.Args[1:] {
			jsonStream += fmt.Sprintf("%v\n", v)
		}
	} else {
		jsonStream = `
[ [[-3,-1],[1,3]], [[-1,-3],[2,2]], [[0,1],[3,5]] ]
[ [[-3,-1],[1,3]], [[-1,-3],[2,2]], [[0,1],[3,5]], [[3,3],[5,5]] ]
[ [[-3,-1],[1,3]], [[-1,-3],[2,2]], [[0,1],[3,5]], [[3,3],[5,5]], [[-5,-5],[5,5]] ]
[ [[0,0,0],[4,4,4]], [[-3,-3,-3],[0,0,0]] ]
[ [[0,0,0],[4,4,4]], [[-3,-3,-3],[0,0,0]], [[-1,-1,-1],[1,1,1]] ]
[ [[0,0,0],[4,4,4]], [[-3,-3,-3],[0,0,0]], [[-1,-1,-1],[1,1,1]], [[-5,-5,-5],[5,5,5]] ]
[ [[-1,0],[2,2]], [[0,-1],[4,4]] ]
[ [[-3,-1],[1,3]], [[-1,-3],[2,2]] ]
`
	}
	dec := json.NewDecoder(strings.NewReader(jsonStream))
	for {
		var sosos [][][]int
		if err := dec.Decode(&sosos); err == io.EOF {
			break
		} else if err != nil {
			log.Fatal(err)
		}
		dimension := len(sosos[0][0])
		recs := []rectangle{}
		var recKeys []int
		sumCoverage := 0
		mi := map[int]string{0: "Input:"}
		for i, v := range sosos {
			rec := newRectangle(v)
			recKeys = append(recKeys, i)
			recs = append(recs, rec)
			sumCoverage += recCoverage(rec)
			fmt.Printf("%16s %d => %v\n", mi[i]+" Rectangle", recKeys[i]+1, v)
		}
		sumOverlap := 0
		for i := 2; i <= len(recs); i++ {
			for _, orecKeys := range getCombo(i, recKeys) {
				var orec rectangle
				for j := 0; j < dimension; j++ {
					var maxPointL, minPointH int
					for i, orecKey := range orecKeys {
						pointL := recs[orecKey].pointL[j]
						pointH := recs[orecKey].pointH[j]
						if i == 0 {
							maxPointL = pointL
							minPointH = pointH
						}
						if maxPointL < pointL {
							maxPointL = pointL
						}
						if minPointH > pointH {
							minPointH = pointH
						}
					}
					if maxPointL < minPointH {
						orec.pointL = append(orec.pointL, maxPointL)
						orec.pointH = append(orec.pointH, minPointH)
					}
				}
				if len(orec.pointL) == dimension {
					overlap := recCoverage(orec)
					if len(orecKeys)%2 == 0 {
						sumOverlap += overlap
					} else {
						sumOverlap -= overlap
					}
				}
			}
		}
		fmt.Printf("Output: %v\n\n", sumCoverage-sumOverlap)
	}
}
func recCoverage(r rectangle) int {
	c := 1
	for i, v := range r.pointH {
		c *= v - r.pointL[i]
	}
	return c
}
func newRectangle(s [][]int) (r rectangle) {
	r.pointL = s[0]
	r.pointH = s[1]
	return r
}
func getCombo(n int, e []int) (r [][]int) {
	c := []int{}
	cTree(n, e, c, func(s []int) {
		r = append(r, s)
	})
	return r
}
func cTree(n int, e []int, c []int, f func(s []int)) {
	if len(c) == n || len(c)+len(e) == n {
		s := append(c, e...)
		f(s[:n])
	} else {
		for i := 0; len(c)+len(e)-i >= n; i++ {
			cTree(n, e[i+1:], append(c, e[i]), f)
		}
	}
}

//func recCoverage(r rectangle) int {
//	c := 1
//	sol := []int{r.posH.x - r.posL.x, r.posH.y - r.posL.y, r.posH.z - r.posL.z}
//	for i := 0; i < r.dimension; i++ {
//		c *= sol[i]
//	}
//	return c
//}
//func newCoordinate(d int, s []int) (c coordinate) {
//	soc := [3]*int{&c.x, &c.y, &c.z}
//	for i := 0; i < d; i++ {
//		*soc[i] = s[i]
//	}
//	return c
//}
//func newRectangle(s [][]int) (r rectangle) {
//	r.dimension = len(s[0])
//	sop := [2]*coordinate{&r.posL, &r.posH}
//	for i := 0; i < len(sop); i++ {
//		*sop[i] = newCoordinate(r.dimension, s[i])
//	}
//	return r
//}
