package main

// https://theweeklychallenge.org/blog/perl-weekly-challenge-353/#TASK2

import (
    "errors"
    "strconv"
    "strings"
    "regexp"
    run "github.com/ysth/runweeklychallenge-go"
)

var validCoupon = regexp.MustCompile(`^\w+\z`)
var validNames = map[string]bool{"electronics": true, "grocery": true, "pharmacy": true, "restaurant": true}

func ValidateCoupons(codes []string, names []string, status []string) ([]bool, error) {
    var result = make([]bool, 0, len(codes))
    if len(codes) != len(names) || len(codes) != len(status) {
        return result, errors.New("arrays not all of the same length")
    }

    for i := 0; i < len(codes); i++ {
        var valid = validCoupon.Match([]byte(codes[i])) && validNames[names[i]] && status[i] == "true"
        result = append(result, valid)
    }

    return result, nil
}

func main() {
    run.RunWeeklyChallenge(
        func(inputs any) (string, error) {
            var b strings.Builder
            b.WriteString("[")
            var valid, err = ValidateCoupons(run.AsStringSlice(inputs,"codes"),run.AsStringSlice(inputs,"names"),run.AsStringSlice(inputs,"status"))
            if err != nil {
                return "", err
            }
            for i, value := range valid {
                if i > 0 {
                    b.WriteString(",")
                }
                b.WriteString(strconv.FormatBool(value))
            }
            b.WriteString("]")
            return b.String(), nil
        },
        `{"codes": ["A123", "B_456", "C789", "D@1", "E123"], "names": ["electronics", "restaurant", "electronics", "pharmacy", "grocery"], "status": ["true", "false", "true", "true", "true"]}`,
        `{
            "type":"object",
            "properties": {
                "codes": { "type": "array", "items": { "type": "string" } },
                "names": { "type": "array", "items": { "type": "string" } },
                "status": { "type": "array", "items": { "type": "string" } }
            },
            "required": ["codes","names","status"],
            "additionalProperties": false
        }`,
    )
}
