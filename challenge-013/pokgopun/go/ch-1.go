/* https://theweeklychallenge.org/blog/perl-weekly-challenge-013/

Challenge #1

     Write a script to print the date of last Friday of every month of a
     given year. For example, if the given year is 2019 then it should
     print the following:

2019/01/25
2019/02/22
2019/03/29
2019/04/26
2019/05/31
2019/06/28
2019/07/26
2019/08/30
2019/09/27
2019/10/25
2019/11/29
2019/12/27
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
	var year uint = 2019
	fmt.Sscanf(strings.Join(os.Args[1:], ""), "%d", &year)
	fmt.Println(lastweekday.New(time.Friday, year, "2006/01/02"))
}
