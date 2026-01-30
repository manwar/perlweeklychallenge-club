package main

// https://theweeklychallenge.org/blog/perl-weekly-challenge-358/#TASK2

import (
    run "github.com/ysth/runweeklychallenge-go"
)

func EncryptedString(str string, shift int) string {
    shiftRune := rune(shift % 26)
    runes := []rune(str)
    encryptedRunes := make([]rune, len(runes))
    for i, r := range runes {
        if r >= 'a' && r <= 'z' {
            r = 'a' + (r - 'a' + shiftRune) % 26
        } else if r >= 'A' || r <= 'Z' {
            r = 'A' + (r - 'A' + shiftRune) % 26
        }
        encryptedRunes[i] = r
    }
    return string(encryptedRunes)
}

func main() {
    run.RunWeeklyChallenge(
        func(inputs any) (string, error) { return run.JSONEncode(EncryptedString(inputs.(map[string]any)["str"].(string), run.AsInt(inputs, "int"))), nil },
        `{"str": "abc", "int": 1}`,
        `{
            "type":"object",
            "properties": {
                "str": {"type": "string"},
                "int": {"type": "integer"}
            },
            "required":["str","int"],
            "additionalProperties": false
        }`,
    )
}
