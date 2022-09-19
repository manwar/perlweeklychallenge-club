package main

// Write a script to display months from the year 1900 to 2019 where you find 5 weekends i.e. 5 Friday, 5 Saturday and 5 Sunday.
// From further analysis, this is only the case for a 31-days month which 1st of the month is Friday
import (
	"fmt"
	"time"
)

func main() {
	startY := 1900
	endY := 2019
	for y := startY; y <= endY; y++ {
		fmt.Println(y, happyMonths(y))
	}
}
func happyMonths(y int) (hm []time.Month) {
	for _, m := range monthsWith31Days() {
		t := time.Date(y, m, 1, 0, 0, 0, 0, time.UTC)
		if t.Weekday() == time.Friday {
			hm = append(hm, m)
		}
	}
	return hm
}
func monthsWith31Days() [7]time.Month {
	return [7]time.Month{
		time.January,
		time.March,
		time.May,
		time.July,
		time.August,
		time.October,
		time.December,
	}
}
