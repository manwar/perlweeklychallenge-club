package main

import (
	"fmt"
	"os"
	"strings"
	"time"
)

func main() {
	year := 2021
	fmt.Sscanf(strings.Join(os.Args[1:], " "), "%d", &year)
	workdays := 52 * 5 // every year has at least 52 weeks each of which has 5 work days
	daysLeft := 1      // non-leap year has 365 - (52 - 7) = 1 day left to check if it is a working day
	if year%4 == 0 {   // a leap year will add another day to daysLeft
		daysLeft++
	}
	// check if there a workday in daysLeft, start at the end of the year
	t := time.Date(year, time.December, 31, 0, 0, 0, 0, time.UTC)
	for d := 0; d < daysLeft; d++ {
		if wd := t.AddDate(0, 0, -d).Weekday(); wd > time.Sunday && wd < time.Saturday {
			workdays++
		}
	}
	fmt.Printf("Input: year = %d\nOutput: %d\n", year, workdays)
}
