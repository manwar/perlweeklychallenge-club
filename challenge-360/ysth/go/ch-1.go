package main

// https://theweeklychallenge.org/blog/perl-weekly-challenge-360/#TASK1

import (
    "errors"
    "fmt"
    "strings"
    "github.com/clipperhouse/displaywidth"
    run "github.com/ysth/runweeklychallenge-go"
)

func TextJustifier(str string, width int) (string, error) {
    padding := width - displaywidth.String(str)
    if padding < 0 {
        return "", errors.New("string does not fit within width")
    }
    justifiedString := fmt.Sprintf(
        "%s%s%s", 
        strings.Repeat("*", int(padding / 2)),
        str,
        strings.Repeat("*", int((padding + 1) / 2)),
    )

    return justifiedString, nil
}

func main() {
    run.RunWeeklyChallenge(
        func(inputs any) (string, error) {
            justifiedString, err := TextJustifier(run.AsString(inputs,"str"), run.AsInt(inputs,"width"))
            if err != nil {
                return "", err
            } else {
                return run.JSONEncode(justifiedString), nil
            }
        },
        `{"str": "Hi", "width":5}`,
        `{
            "type": "object",
            "properties": {
                "str": {"type": "string"},
                "width": {"type": "integer", "minimum": 0}
            },
            "required": ["str", "width"],
            "additionalProperties": false
        }`,
    )
}
