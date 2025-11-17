package main

import (
    run "github.com/ysth/runweeklychallenge-go"
)

func FormatPhoneNumber(phoneNumber string) (string) {
    formattedPhoneNumber := make([]rune, 0, len(phoneNumber)+(len(phoneNumber)-1)/3)
    count := 0
    for _, r := range phoneNumber {
        if r >= '0' && r <= '9' {
            if count == 3 {
                count = 0
                formattedPhoneNumber = append(formattedPhoneNumber, '-')
            }
            formattedPhoneNumber = append(formattedPhoneNumber, r)
            count++
        }
    }
    count = len(formattedPhoneNumber)
    if count > 4 && formattedPhoneNumber[count-2] == '-' {
        formattedPhoneNumber[count-2], formattedPhoneNumber[count-3] =
            formattedPhoneNumber[count-3], formattedPhoneNumber[count-2]
    }
    return string(formattedPhoneNumber)
}

func main() {
    runSolution := func(inputs any) (any, error) {
        return FormatPhoneNumber(inputs.(string)), nil
    }

    inputExample := `"12 345-6789"`

    inputSchema := `{
        "type": "string"
    }`

    run.RunWeeklyChallenge(runSolution, inputExample, inputSchema)
}
