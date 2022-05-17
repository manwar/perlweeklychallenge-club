/*
### Interactively enter points and lines and output to STDOUT:

go run ch-1.go

Enter 'x1,y1' for a point or 'x1,y1,x2,y2' for a line, or '0' to end this
53,10
53,10,23,30
23,30
0
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
<svg height="60.000000" width="106.000000" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
	<g id="lines" stroke="#369" stroke-width="4"><line x1="53.000000" x2="23.000000" y1="10.000000" y2="30.000000" /></g><g fill="#f73" id="points"><circle cx="53.000000" cy="10.000000" r="3" /><circle cx="23.000000" cy="30.000000" r="3" /></g></svg>

### Pass points and line data via STDIN and output to file ch-1.svg:

echo -e "53,10\n53,10,23,30\n23,30\n0" | go run ch-1.go ch-1.svg
*/
package main

import (
	"bufio"
	"fmt"
	"io"
	"log"
	"os"
)

type point struct{ x, y float64 }
type line struct {
	start point
	end   point
}

type Svg struct {
	points        []point
	lines         []line
	height, width float64
}

func (svg *Svg) updateHW() {
	var points []point
	for _, l := range svg.lines {
		points = append(points, l.start, l.end)
	}
	for _, p := range append(points, svg.points...) {
		if p.x > svg.width {
			svg.width = p.x
		}
		if p.y > svg.height {
			svg.height = p.y
		}
	}
}

func (svg *Svg) input() {
	var x1, y1, x2, y2 float64
	guide := "Enter 'x1,y1' for a point or 'x1,y1,x2,y2' for a line, or '0' to end this"
	//fmt.Println(guide)
	for {
		n, err := fmt.Scanf("%f,%f,%f,%f\n", &x1, &y1, &x2, &y2)
		//fmt.Println("n =>", n, "err =>", err)
		switch n {
		case 2:
			svg.points = append(svg.points, point{x1, y1})
		case 4:
			svg.lines = append(svg.lines, line{point{x1, y1}, point{x2, y2}})
		default:
			if err == io.EOF || n == 1 && x1 == 0 {
				goto done
			}
			fmt.Fprintln(os.Stderr, guide)
			continue
		}
		//fmt.Println("svg =>", svg)
	}
done:
}
func main() {
	w := bufio.NewWriter(os.Stdout)
	if len(os.Args) > 1 {
		f, err := os.Create(os.Args[1])
		if err != nil {
			log.Fatal(err)
		}
		defer f.Close()
		w = bufio.NewWriter(f)
	}
	var data Svg
	data.input()
	data.updateHW()
	//fmt.Println(data.height, data.width)
	fmt.Fprintf(w, `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
<svg height="%f" width="%f" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
	<g id="lines" stroke="#369" stroke-width="4">`, data.height*2, data.width*2)
	for _, l := range data.lines {
		fmt.Fprintf(w, `<line x1="%f" x2="%f" y1="%f" y2="%f" />`, l.start.x, l.end.x, l.start.y, l.end.y)
	}
	w.WriteString(`</g><g fill="#f73" id="points">`)
	for _, p := range data.points {
		fmt.Fprintf(w, `<circle cx="%f" cy="%f" r="3" />`, p.x, p.y)
	}
	w.WriteString(`</g></svg>`)
	w.Flush()
}
