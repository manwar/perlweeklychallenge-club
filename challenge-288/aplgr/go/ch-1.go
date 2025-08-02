package main

import (
    "strconv"
)

func isPalindrome(num int) bool {
    reversed := 0
    original := num

    for num > 0 {
        digit := num % 10
        reversed = reversed*10 + digit
        num /= 10
    }

    return original == reversed
}

func findClosest(lower, upper, original int) string {
    switch {
        case isPalindrome(lower) && lower != original:
            return strconv.Itoa(lower)
        case isPalindrome(upper) && upper != original:
            return strconv.Itoa(upper)
        case lower > 0:
            return findClosest(lower-1, upper+1, original)
        default:
            return strconv.Itoa(upper + 1)
    }
}

func closestPalindrome(str string) string {
    num, _ := strconv.Atoi(str)
    return findClosest(num-1, num+1, num)
}
