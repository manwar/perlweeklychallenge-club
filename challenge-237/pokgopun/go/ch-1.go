//# https://theweeklychallenge.org/blog/perl-weekly-challenge-237/
/*#

Task 1: Seize The Day

Submitted by: [44]Mark Anderson
     __________________________________________________________________

   Given a year, a month, a weekday of month, and a day of week (1 (Mon)
   .. 7 (Sun)), print the day.

Example 1

Input: Year = 2024, Month = 4, Weekday of month = 3, day of week = 2
Output: 16

The 3rd Tue of Apr 2024 is the 16th

Example 2

Input: Year = 2025, Month = 10, Weekday of month = 2, day of week = 4
Output: 9

The 2nd Thu of Oct 2025 is the 9th

Example 3

Input: Year = 2026, Month = 8, Weekday of month = 5, day of week = 3
Output: 0

There isn't a 5th Wed in Aug 2026

Task 2: Maximise Greatness
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"fmt"
	"time"
)

func main() {
	for _, data := range []struct {
		mDate  mDate
		output int
	}{
		{mDate{2024, 4, 3, 2}, 16},
		{mDate{2025, 10, 2, 4}, 9},
		{mDate{2026, 8, 5, 3}, 0},
	} {
		fmt.Println(data.mDate.day() == data.output)
	}
}

type mDate struct {
	y      int
	m      time.Month
	mw, wd int
}

func (md mDate) day() int {
	d := time.Date(md.y, md.m, 1, 0, 0, 0, 0, time.UTC)
	wdd := (md.wd % 7) - int(d.Weekday())
	if wdd < 0 {
		wdd += 7
	}
	d = d.AddDate(0, 0, 7*(md.mw-1)+wdd)
	if d.Month() != md.m {
		return 0
	}
	return d.Day()
}
