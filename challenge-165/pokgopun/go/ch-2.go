/*
### Pass output to ch-1.go to create svg file

go run ch-2.go | go run ch-1.go ch-2.svg

### Pass output to ch-1.go and start http.Server at localhost:8080 to show the result:

go run ch-2.go | go run ch-1.go :8080

*/
package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strings"
)

func main() {
	//rawin := `2,4 3,5 5,7 7,10 9,15`
	/**/
	rawin := `333,129  39,189 140,156 292,134 393,52  160,166 362,122  13,193
			341,104 320,113 109,177 203,152 343,100 225,110  23,186 282,102
			284,98  205,133 297,114 292,126 339,112 327,79  253,136  61,169
			128,176 346,72  316,103 124,162  65,181 159,137 212,116 337,86
			215,136 153,137 390,104 100,180  76,188  77,181  69,195  92,186
			275,96  250,147  34,174 213,134 186,129 189,154 361,82  363,89`
	/**/
	var ds struct {
		count, x, y, sumx, sumy, sumxx, sumxy, m, b, x1, x2, y1, y2 float64
		xy                                                          string
	}
	_, err := fmt.Sscanf(rawin, "%f,%f %f,%f", &ds.x1, &ds.y1, &ds.x2, &ds.y2)
	if err != nil {
		log.Fatal(err)
	}
	w := bufio.NewWriter(os.Stdout)
	scanner := bufio.NewScanner(strings.NewReader(rawin))
	scanner.Split(bufio.ScanWords)
	for scanner.Scan() {
		ds.xy = scanner.Text()
		_, err := fmt.Sscanf(ds.xy, "%f,%f", &ds.x, &ds.y)
		if err != nil {
			log.Fatal(err)
		}
		fmt.Fprintln(w, ds.xy)
		ds.count++
		ds.sumx += ds.x
		ds.sumy += ds.y
		ds.sumxx += ds.x * ds.x
		ds.sumxy += ds.x * ds.y
		if ds.x1 > ds.x {
			ds.x1 = ds.x
		}
		if ds.x2 < ds.x {
			ds.x2 = ds.x
		}
	}
	ds.m = (ds.count*ds.sumxy - ds.sumx*ds.sumy) / (ds.count*ds.sumxx - ds.sumx*ds.sumx)
	ds.b = (ds.sumy - ds.m*ds.sumx) / ds.count
	ds.y1 = ds.m*ds.x1 + ds.b
	ds.y2 = ds.m*ds.x2 + ds.b
	fmt.Fprintf(w, "%f,%f,%f,%f\n", ds.x1, ds.y1, ds.x2, ds.y2)
	w.Flush()
	//fmt.Printf("%+v\n", ds)
}
