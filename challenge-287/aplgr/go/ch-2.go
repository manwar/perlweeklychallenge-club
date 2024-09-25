package main

import (
    "regexp"
)

// isValidNumber checks if the given string is a valid number.
func isValidNumber(str string) bool {
    regex := `^[+-]?((\d+(\.\d*)?)|(\.\d+))([eE][+-]?\d+)?$`
    matched, _ := regexp.MatchString(regex, str)
    return matched
}
