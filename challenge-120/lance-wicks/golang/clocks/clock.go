package main

import (
    "fmt"
    "os"
	"strconv"
	"strings"
)

func main() {
	fmt.Print("Output: ")
	fmt.Println(angle(os.Args[1]))
}

func angle(s string) float64 {
	parts := strings.Split(s, ":")
	angleH := hourAngle(parts[0], parts[1])
	angleM := minuteAngle(parts[0], parts[1])

	return angleH - angleM
}

func hourAngle(h string, m string) float64 {
	hour, _ := strconv.ParseFloat(h, 32)
	min, _ := strconv.ParseFloat(m, 32)

	angle := ((hour * 60) + min) * .5
	return angle
}

func minuteAngle(h string, m string) float64 {
	min, _ := strconv.ParseFloat(m, 32)

	angle := (6 * min)
	return angle
}
