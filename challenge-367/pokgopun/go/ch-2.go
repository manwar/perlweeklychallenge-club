//# https://theweeklychallenge.org/blog/perl-weekly-challenge-367/
/*#

Task 2: Conflict Events

Submitted by: [62]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two events start and end time.

   Write a script to find out if there is a conflict between the two
   events. A conflict happens when two events have some non-empty
   intersection.

Example 1

Input: @event1 = ("10:00", "12:00")
       @event2 = ("11:00", "13:00")
Output: true

Both events overlap from "11:00" to "12:00".

Example 2

Input: @event1 = ("09:00", "10:30")
       @event2 = ("10:30", "12:00")
Output: false

Event1 ends exactly at 10:30 when Event2 starts.
Since the problem defines intersection as non-empty, exact boundaries touching i
s not a conflict.

Example 3

Input: @event1 = ("14:00", "15:30")
       @event2 = ("14:30", "16:00")
Output: true

Both events overlap from 14:30 to 15:30.

Example 4

Input: @event1 = ("08:00", "09:00")
       @event2 = ("09:01", "10:00")
Output: false

There is a 1-minute gap from "09:00" to "09:01".

Example 5

Input: @event1 = ("23:30", "00:30")
       @event2 = ("00:00", "01:00")
Output: true

They overlap from "00:00" to "00:30".
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 5th April 2026.
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"fmt"
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type Event struct {
	Start, End int
}

func NewEvent(start, end string) *Event {
	var d [2]int
	for i, v := range []string{start, end} {
		var h, m int
		_, err := fmt.Sscanf(v, "%d:%d", &h, &m)
		if err != nil || h < 0 || h > 23 || m < 0 || m > 59 {
			return nil
		}
		d[i] = h*60 + m
	}
	if d[0] > d[1] {
		d[0] -= 24 * 60
	}
	return &Event{d[0], d[1]}
}

type Result struct {
	Val bool
}

func NewResult(b bool) *Result {
	return &Result{b}
}

func (evt *Event) Conflict(aevt *Event) *Result {
	if evt == nil || aevt == nil {
		return nil
	}
	return NewResult(!((aevt.Start <= evt.Start || aevt.Start >= evt.End) && (aevt.End <= evt.Start || aevt.End >= evt.End)))
}

func main() {
	ConflictEvents := (*Event).Conflict
	for _, data := range []struct {
		event1, event2 *Event
		output         *Result
	}{
		{NewEvent("10:00", "12:00"), NewEvent("11:00", "13:00"), NewResult(true)},
		{NewEvent("09:00", "10:30"), NewEvent("10:30", "12:00"), NewResult(false)},
		{NewEvent("14:00", "15:30"), NewEvent("14:30", "16:00"), NewResult(true)},
		{NewEvent("08:00", "09:00"), NewEvent("09:01", "10:00"), NewResult(false)},
		{NewEvent("23:30", "00:30"), NewEvent("00:00", "01:00"), NewResult(true)},
		{NewEvent("24:30", "00:30"), NewEvent("00:00", "01:00"), nil},
		{NewEvent("22:30", "00:30"), NewEvent(":00", "01:00"), nil},
		{NewEvent("whatever", ""), NewEvent(":00", "01:wth"), nil},
	} {
		io.WriteString(os.Stdout, cmp.Diff(ConflictEvents(data.event1, data.event2), data.output)) // blank if ok, otherwise show the difference
	}
}
