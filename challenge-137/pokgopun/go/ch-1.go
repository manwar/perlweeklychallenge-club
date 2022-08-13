package main

import (
	"fmt"
	"time"
)

func main() {
	startY, endY := 1900, 2100
	var longYear []int
	for y := startY; y <= endY; y++ {
		t := time.Date(y, time.January, 1, 0, 0, 0, 0, time.UTC)
		for i := 0; i <= 1; i++ {
			if t.AddDate(i, 0, -i).Weekday() == time.Thursday {
				longYear = append(longYear, y)
				break
			}
		}
	}
	fmt.Println(longYear)
}
