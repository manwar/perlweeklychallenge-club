package main

import (
	"fmt"
	"time"
)

const Year = 2019

func main() {
	count := map[time.Month]uint{}
	t := time.Date(Year, time.January, 1, 0, 0, 0, 0, time.UTC)

	for t.Year() == Year {
		if t.Weekday() != time.Saturday && t.Weekday() != time.Sunday {
			count[t.Month()]++
		}

		// Add 1 day
		d, _ := time.ParseDuration("24h")
		t = t.Add(d)
	}

	for i := time.January; i <= time.December; i++ {
		fmt.Println(i.String()+":", count[i])
	}
}
