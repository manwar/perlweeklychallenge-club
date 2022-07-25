/* https://theweeklychallenge.org/blog/perl-weekly-challenge-175/
Task 1: Last Sunday
Submitted by: Mohammad S Anwar
Write a script to list Last Sunday of every month in the given year.

For example, for year 2022, we should get the following:


2022-01-30
2022-02-27
2022-03-27
2022-04-24
2022-05-29
2022-06-26
2022-07-31
2022-08-28
2022-09-25
2022-10-30
2022-11-27
2022-12-25
*/
package main

import (
	"fmt"
	"os"
	"strings"
	"time"

	"github.com/pokgopun/go/lastweekday"
)

func main() {
	var year uint = 2022
	fmt.Sscanf(strings.Join(os.Args[1:], ""), "%d", &year)
	fmt.Println(lastweekday.New(time.Sunday, year, "2006-01-02"))
}
