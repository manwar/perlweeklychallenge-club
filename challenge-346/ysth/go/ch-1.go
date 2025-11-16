package main

import (
    "errors"
    "fmt"
    "strconv"
    "strings"
    "time"
    "github.com/dustin/go-humanize"
    run "github.com/ysth/runweeklychallenge-go"
)

var mon = make(map[string]int)
var day = make(map[string]int)
func init() {
    for m := 1; m < 13; m++ {
        mon[ time.Date(0,time.Month(m),1,0,0,0,0,time.UTC).Format("Jan") ] = m
    }
    for d := 1; d <= 31; d++ {
        day[ humanize.Ordinal(d) ] = d
    }
}
    
func FormatDate(dateString string) (string, error) {
    dateParts := strings.Split(dateString, " ")
    if len(dateParts) != 3 {
        return "", errors.New("invalid date format")
    }
    d := day[dateParts[0]]
    if d == 0 {
        return "", errors.New("invalid day in date")
    }
    m := mon[dateParts[1]]
    if m == 0 {
        return "", errors.New("invalid month in date")
    }
    y, err := strconv.Atoi(dateParts[2])
    if err != nil {
        return "", errors.New("invalid year in date")
    }
    if y < 1900 || y > 2100 {
        return "", errors.New("year out of range in date")
    }
    formattedDate := fmt.Sprintf("%04d-%02d-%02d", y, m, d)

    return formattedDate, nil
}

func main() {
    runSolution := func(inputs any) (any, error) {
        return FormatDate(inputs.(string))
    }

    inputExample := `"()()"`

    inputSchema := `{
        "type": "string"
    }`

    run.RunWeeklyChallenge(runSolution, inputExample, inputSchema)
}
