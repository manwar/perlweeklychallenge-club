package main

import (
    "fmt"
    "bufio"
    "os"
    "strings"
    "regexp"
)

//
// Helper function so we return a boolean when matching
//
func match (subject string, pattern string) bool {
    result, err := regexp . MatchString (pattern, subject)
    if (err != nil) {
        panic (fmt . Sprintf ("Pattern '%s' failed\n"))
    }
    return result
}

func main () {
    reader := bufio . NewReader (os . Stdin)
    for {
        text, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }

        //
        // Split input in hours and minutes part
        //
        parts := strings . Split (strings . TrimSuffix (text, "\n"), ":")

        hours   := parts [0]
        minutes := parts [1]

        h_times := 0
        m_times := 0

        //
        // Process hours
        //
        switch {
            case match (hours,   `^\?\?$`):       h_times = 24
            case match (hours,   `^\?[0-3]$`):    h_times =  3
            case match (hours,   `^\?[4-9]$`):    h_times =  2
            case match (hours,   `^[01]\?$`):     h_times = 10
            case match (hours,   `^2\?$`):        h_times =  4
            case match (hours,   `^[01][0-9]$`):  h_times =  1
            case match (hours,   `^2[0-3]$`):     h_times =  1
        }

        //
        // Process minutes
        //
        switch {
            case match (minutes, `^\?\?$`):       m_times = 60
            case match (minutes, `^\?[0-9]$`):    m_times =  6
            case match (minutes, `^[0-5]\?$`):    m_times = 10
            case match (minutes, `^[0-5][0-9]$`): m_times =  1
        }

        fmt . Println (h_times * m_times)
    }
}
