/*
Task 1: Banking Day Offset
Submitted by: Lee Johnson

You are given a start date and offset counter. Optionally you also get bank holiday date list.

Given a number (of days) and a start date, return the number (of days) adjusted to take into account non-banking days. In other words: convert a banking day offset to a calendar day offset.

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
*/

package main

import (
    "fmt"
    "log"
    "strings"
    "time"
)

func contains(s []string, str string) bool {
    for _, v := range s {
        if v == str {
            return true
        }
    }
    return false
}

func no_banking_day(t time.Time, bank_holidays []string) bool {
    ymd := t.Format("2006-01-02")
    if (t.Weekday() == 0 || t.Weekday() == 6 || contains(bank_holidays, ymd)) {
        return true
    }
    return false
}

func banking_day_offset(start_date string, offset int, bank_holidays []string) {
    t, err := time.Parse("2006-01-02", start_date)
    if err != nil {
        log.Fatal(err)
    }

    for i := 1; i <= offset; i++ {
        t = t.AddDate(0, 0, 1)
        for no_banking_day(t, bank_holidays) {
            t = t.AddDate(0, 0, 1)
        }
    }

    fmt.Printf("start %s offset %d Bank holidays [%s]) -> %s\n",
        start_date, offset,
        strings.Join(bank_holidays, " "),
        t.Format("2006-01-02"))
}

func main() {
    start_date := "2018-06-28"
    offset := 3;
    bank_holidays := []string{"2018-07-03"}
    banking_day_offset(start_date, offset, bank_holidays)

    start_date = "2018-06-28"
    offset = 3;
    bank_holidays = []string{}
    banking_day_offset(start_date, offset, bank_holidays)
}

