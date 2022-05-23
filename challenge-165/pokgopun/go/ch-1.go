/*
### Interactively enter points and lines and output to STDOUT:

go run ch-1.go

Enter 'x1,y1' for a point or 'x1,y1,x2,y2' for a line, or 'done' when done
53,10
53,10,23,30
23,30
done
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
<svg height="60.000000" width="106.000000" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
	<g id="lines" stroke="#369" stroke-width="4"><line x1="53.000000" x2="23.000000" y1="10.000000" y2="30.000000" /></g><g fill="#f73" id="points"><circle cx="53.000000" cy="10.000000" r="3" /><circle cx="23.000000" cy="30.000000" r="3" /></g></svg>

### Pass point and line data via STDIN and output to file ch-1.svg:

echo -e "53,10\n53,10,23,30\n23,30" | go run ch-1.go ch-1.svg

### Pass point and line data via STDIN and start http.Server at localhost:8080 to show the result:

go run ch-2.go | go run ch-1.go :8080

*/
package main

import (
	"bufio"
	"bytes"
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"regexp"
	"time"
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

func (svg *Svg) input(r io.Reader) {
	var (
		x1, y1, x2, y2 float64
		text           string
	)
	guide := "Enter 'x1,y1' for a point or 'x1,y1,x2,y2' for a line, or 'done' when done"
	scanner := bufio.NewScanner(r)
	for scanner.Scan() {
		text = scanner.Text()
		if text == "done" {
			break
		} else {
			n, err := fmt.Sscanf(text, "%f,%f,%f,%f\n", &x1, &y1, &x2, &y2)
			if err != nil {
				_, err := fmt.Sscanf(text, "%f,%f\n", &x1, &y1)
				if err != nil {
					fmt.Fprintln(os.Stderr, guide)
					continue
				}
			}
			if n == 4 {
				svg.lines = append(svg.lines, line{point{x1, y1}, point{x2, y2}})
			} else {
				svg.points = append(svg.points, point{x1, y1})
			}
		}
	}
	svg.updateHW()
}
func (svg Svg) output(w io.Writer) {
	bw := bufio.NewWriter(w)
	fmt.Fprintf(bw, `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
<svg height="%f" width="%f" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
	<g id="lines" stroke="#369" stroke-width="4">`, svg.height*2, svg.width*2)
	for _, l := range svg.lines {
		fmt.Fprintf(bw, `<line x1="%f" x2="%f" y1="%f" y2="%f" />`, l.start.x, l.end.x, l.start.y, l.end.y)
	}
	bw.WriteString(`</g><g fill="#f73" id="points">`)
	for _, p := range svg.points {
		fmt.Fprintf(bw, `<circle cx="%f" cy="%f" r="3" />`, p.x, p.y)
	}
	bw.WriteString(`</g></svg>`)
	bw.Flush()
}

func (svg Svg) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	buf := bytes.NewBuffer([]byte{})
	svg.output(buf)
	w.Write(buf.Bytes())
	//w.Write([]byte(fmt.Sprint(time.Now())))
}

func main() {
	var data Svg
	data.input(os.Stdin)
	if len(os.Args) > 1 {
		out := os.Args[1]
		if regexp.MustCompile(`^:\d+$`).MatchString(out) {
			s := http.Server{
				Addr:         out,
				ReadTimeout:  30 * time.Second,
				WriteTimeout: 90 * time.Second,
				IdleTimeout:  120 * time.Second,
				Handler:      data,
			}
			fmt.Printf("Start http.Server at localhost%s to show the result\n", out)
			err := s.ListenAndServe()
			if err != nil {
				if err != http.ErrServerClosed {
					panic(err)
				}
			}
		} else {
			w, err := os.Create(out)
			if err != nil {
				log.Fatal(err)
			}
			defer w.Close()
			data.output(w)
		}
	} else {
		data.output(os.Stdout)
	}

}
