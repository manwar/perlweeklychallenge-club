package main

import (
	"regexp"
)

func countRepeats(password string) int {
    repeats := 0
    count := 1

    for i := 1; i < len(password); i++ {
        if password[i] == password[i-1] {
            count++
        } else {
            repeats += count / 3
            count = 1
        }
    }
    repeats += count / 3
    return repeats
}

func minimumStepsToStrongPassword(password string) int {
    length := len(password)

    // Use regex to check for character types
    hasLower := regexp.MustCompile(`[a-z]`).MatchString(password)
    hasUpper := regexp.MustCompile(`[A-Z]`).MatchString(password)
    hasDigit := regexp.MustCompile(`\d`).MatchString(password)

    // Calculate the number of types needed
    typesNeeded := boolToInt(!hasLower) + boolToInt(!hasUpper) + boolToInt(!hasDigit)

    repeats := countRepeats(password)

    // Return the minimum steps based on the length of the password
    if length < 6 {
        return max(6-length, typesNeeded)
    }
    return typesNeeded + repeats
}


func boolToInt(b bool) int {
    if b {
        return 1
    }
    return 0
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
