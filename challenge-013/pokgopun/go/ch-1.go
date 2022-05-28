package main

import (
	"fmt"
	"time"
)

func main() {
	fmt.Println(newLastWeekdayOfMonth(time.Friday, 2019))
}
func monthdayCount(y int) (r [12]int) {
	r = [12]int{31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
	if y%4 == 0 {
		r[time.February]++
	}
	return r
}

type lastWeekdayOfMonth [12]time.Time

func (lwdom lastWeekdayOfMonth) String() (r string) {
	for _, t := range lwdom {
		r += fmt.Sprintln(t.Format("2006/01/02"))
	}
	return r
}
func newLastWeekdayOfMonth(wd time.Weekday, y int) (lwdom lastWeekdayOfMonth) {
	for i, v := range monthdayCount(y) {
		// Find offset between the last day of the month and the specified weekday
		t := time.Date(y, time.Month(i+1), v, 0, 0, 0, 0, time.UTC)
		o := int(wd - t.Weekday())
		// The offset is the number of day we need to go back to the latest specified weekday in certain month
		if o != 0 {
			// plus sign indicate the offset between specified weekday and the current weekday of the previous week
			if o > 0 {
				o -= 7
			}
		}
		lwdom[i] = t.AddDate(0, 0, o)
	}
	return lwdom
}
