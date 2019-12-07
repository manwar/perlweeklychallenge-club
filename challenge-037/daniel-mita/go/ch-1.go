package main

import (
	"fmt"
	"time"
)

const Year = 2019

func main() {
	t := time.Date(Year, time.January, 1, 0, 0, 0, 0, time.UTC)

	var count uint
	for t.Year() == Year {
		if t.Weekday() != time.Saturday && t.Weekday() != time.Sunday {
			count++
		}

		// Add 1 day
		d, _ := time.ParseDuration("24h")
		if t.Month() != t.Add(d).Month() {
			fmt.Println(t.Month().String()+":", count)
			count = 0
		}
		t = t.Add(d)
	}

}
