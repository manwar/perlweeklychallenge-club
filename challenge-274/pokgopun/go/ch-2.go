//# https://theweeklychallenge.org/blog/perl-weekly-challenge-274/
/*#

Task 2: Bus Route

Submitted by: [58]Peter Campbell Smith
     __________________________________________________________________

   Several bus routes start from a bus stop near my home, and go to the
   same stop in town. They each run to a set timetable, but they take
   different times to get into town.

   Write a script to find the times - if any - I should let one bus leave
   and catch a strictly later one in order to get into town strictly
   sooner.

   An input timetable consists of the service interval, the offset within
   the hour, and the duration of the trip.

Example 1

Input: [ [12, 11, 41], [15, 5, 35] ]
Output: [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47]

Route 1 leaves every 12 minutes, starting at 11 minutes past the hour (so 11, 23
, ...) and takes 41 minutes. Route 2 leaves every 15 minutes, starting at 5 minu
tes past (5, 20, ...) and takes 35 minutes.

At 45 minutes past the hour I could take the route 1 bus at 47 past the hour, ar
riving at 28 minutes past the following hour, but if I wait for the route 2 bus
at 50 past I will get to town sooner, at 25 minutes past the next hour.

Example 2

Input: [ [[12, 3, 41], [15, 9, 35], [30, 5, 25] ]
Output: [ 0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51
, 55, 56, 57, 58, 59 ]
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 23rd June 2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"slices"

	"github.com/google/go-cmp/cmp"
)

type busInfo struct {
	freq, start, dur int
}

func busRoute(bis ...busInfo) []int {
	t2d := make(map[int]int)
	var (
		dur, tm int
		ok      bool
		bi      busInfo
	)
	for _, bi = range bis {
		tm = bi.start
		for tm < 60 {
			dur, ok = t2d[tm]
			if !ok || bi.dur < dur {
				t2d[tm] = bi.dur
			}
			tm += bi.freq
		}
	}
	l := len(t2d)
	bs := make([]string, l)
	var i, j, k, v int
	for k, v = range t2d {
		bs[i] = string([]byte{byte(k), byte(v)})
		i++
	}
	slices.Sort(bs)
	var (
		br   []int
		d, g [2]byte
		t    [3]byte
		gap  byte
	)
	for i = 0; i < l; i++ {
		for j = 0; j < 3; j++ {
			t[j] = bs[(i+j)%l][0] + 60*byte((i+j)/l)
			if j > 0 {
				g[j-1] = (t[j] - t[j-1]) % 60
				d[j-1] = bs[(i+j)%l][1]
			}
		}
		if g[1]+d[1] < d[0] {
			for gap = range g[0] {
				br = append(br, int((t[0]+gap+1)%60))
			}
		}
	}
	slices.Sort(br)
	return br
}

func main() {
	for _, data := range []struct {
		input  []busInfo
		output []int
	}{
		{
			[]busInfo{
				busInfo{12, 11, 41},
				busInfo{15, 5, 35},
			},
			[]int{36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47},
		},
		{
			[]busInfo{
				busInfo{12, 3, 41},
				busInfo{15, 9, 35},
				busInfo{30, 5, 25},
			},
			[]int{0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59},
		},
	} {
		io.WriteString(os.Stdout, cmp.Diff(busRoute(data.input...), data.output)) // blank if ok, otherwise show the difference
	}
}
