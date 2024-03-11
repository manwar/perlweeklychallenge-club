//# https://theweeklychallenge.org/blog/perl-weekly-challenge-259/
/*#

Task 1: Banking Day Offset

Submitted by: [42]Lee Johnson
     __________________________________________________________________

   You are given a start date and offset counter. Optionally you also get
   bank holiday date list.

   Given a number (of days) and a start date, return the number (of days)
   adjusted to take into account non-banking days. In other words: convert
   a banking day offset to a calendar day offset.

   Non-banking days are:
a) Weekends
b) Bank holidays

Example 1

Input: $start_date = '2018-06-28', $offset = 3, $bank_holidays = ['2018-07-03']
Output: '2018-07-04'

Thursday bumped to Wednesday (3 day offset, with Monday a bank holiday)

Example 2

Input: $start_date = '2018-06-28', $offset = 3
Output: '2018-07-03'

Task 2: Line Parser
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"log"
	"os"
	"slices"
	"time"

	"github.com/google/go-cmp/cmp"
)

const datePttrn = "2006-01-02"

// logic is similar to python version
func bankingDayOffset(startDate string, offset uint, bankHolidays []string) string {
	dstart, err := time.Parse(datePttrn, startDate)
	if err != nil {
		log.Fatal("invalid date string")
	}
	switch dstart.Weekday() { // skip back to Friday if start at weekend
	case time.Saturday:
		dstart = dstart.AddDate(0, 0, -1)
	case time.Sunday:
		dstart = dstart.AddDate(0, 0, -2)
	}
	days := 7*(int(offset)/5) + int(offset)%5    // convert workday offset to everyday offset => 7 days * weekCount (i.e. int(offset)/5) + partial week offset
	if int(dstart.Weekday())+int(offset)%5 > 5 { // skip weekend if partial week offset int(offset)%5 move dstart beyond current weekday
		days += 2
	}
	dend := dstart.AddDate(0, 0, days)
	for _, hol := range newHolidays(bankHolidays) {
		if dstart.Before(hol) && !dend.Before(hol) { // move forward with holidays one by one
			dend = dend.AddDate(0, 0, 1)
			if dend.Weekday() > time.Friday { // skip to next monday if such move hit Saturday
				dend = dend.AddDate(0, 0, 2)
			}
		}
	}
	return dend.Format(datePttrn)
}

type holidays []time.Time

// newHolidays silently filter out invalid and duplicated date strings and weekend, dates will be sorted ascendingly as well
func newHolidays(dateStrs []string) holidays {
	var hols holidays
	m := make(map[time.Time]struct{})
	slices.Sort(dateStrs)
	for _, dateStr := range dateStrs {
		date, err := time.Parse(datePttrn, dateStr)
		if err == nil {
			switch date.Weekday() {
			case time.Saturday, time.Sunday:
				continue
			}
			_, ok := m[date]
			if !ok {
				m[date] = struct{}{}
				hols = append(hols, date)
			}
		}
	}
	return hols
}

func main() {
	for _, data := range []struct {
		output, start string
		offset        uint
		holidays      []string
	}{
		{"2018-07-04", "2018-06-28", 3, []string{"2018-07-03"}},
		{"2018-07-03", "2018-06-28", 3, []string{}},
		{"2018-07-05", "2018-06-28", 3, []string{"2018-07-02", "2018-07-03"}},
		{"2018-07-05", "2018-06-28", 3, []string{"2018-07-06", "2018-07-03", "2018-07-02"}},
		{"2018-07-06", "2018-06-28", 3, []string{"2018-07-02", "2018-07-03", "2018-07-05"}},
		{"2018-07-06", "2018-06-28", 3, []string{"2018-07-02", "2018-07-03", "2018-07-05", "2024-03-05"}},
		{"2018-07-06", "2018-06-28", 3, []string{"2018-07-02", "2018-07-03", "2018-07-05", "1979-07-09"}},
		{"2018-07-13", "2018-06-28", 8, []string{"2018-07-02", "2018-07-03", "2018-07-05", "1979-07-09"}},
		{"2018-07-16", "2018-06-28", 9, []string{"2018-07-02", "2018-07-03", "2018-07-05", "1979-07-09"}},
		{"2018-07-23", "2018-06-28", 14, []string{"2018-07-02", "2018-07-03", "2018-07-05", "1979-07-09"}},
		{"2018-07-25", "2018-06-28", 14, []string{"2018-07-02", "2018-07-03", "2018-07-05", "2018-07-11", "2018-07-18"}},
		{"2018-07-05", "2018-06-29", 3, []string{"2018-07-03"}},
		{"2018-07-05", "2018-06-30", 3, []string{"2018-07-03"}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(bankingDayOffset(data.start, data.offset, data.holidays), data.output)) // blank if ok, otherwise show the differences
	}
}
