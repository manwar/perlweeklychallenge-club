package main

// https://theweeklychallenge.org/blog/perl-weekly-challenge-349/#TASK2

import (
    run "github.com/ysth/runweeklychallenge-go"
)

// meeting_point
// instructions: string of U/L/D/R characters indicating movement
// return true if movement returns to origin at any step, otherwise false
func MeetingPoint(instructions string) (bool) {
    x, y, metOrigin := 0, 0, false
    for _, r := range instructions {
        if r == 'U' {
            x++
        } else if r == 'D' {
            x--
        } else if r == 'R' {
            y++
        } else if r == 'L' {
            y--
        }
        if x == 0 && y == 0 {
            metOrigin = true
            break
        }
    }

    return metOrigin
}

func main() {
    run.RunWeeklyChallenge(
        func(inputs any) (string, error) {
            result := MeetingPoint(inputs.(string))
            var stringResult string
            if result {
                stringResult = "true"
            } else {
                stringResult = "false"
            }
            return stringResult, nil
        },
        `"ULD"`, `{"type":"string","pattern":"^[UDRL]*$"}`,
    )
}
