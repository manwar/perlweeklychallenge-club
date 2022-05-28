package main

// Write a script to list dates for Sunday Christmas between 2019 and 2100. For example, 25 Dec 2022 is Sunday.
import (
	"fmt"
	"time"
)

const debug = 0

func main() {
	startY := 2019
	endY := 2100
	for y := startY; y <= endY; y++ {
		t := time.Date(y, 12, 25, 0, 0, 0, 0, time.UTC)
		if t.Weekday() == time.Sunday {
			fmt.Println(t.Format("2 Jan 2006 is Monday"))
		} else if debug == 1 {
			fmt.Println("...skipping", t.Format("2 Jan 2006 is Monday"))
		}
	}
}
