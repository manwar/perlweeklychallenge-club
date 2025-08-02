/*
Task 1: Goat Latin
Submitted by: Mohammad Sajid Anwar

You are given a sentence, $sentance.
Write a script to convert the given sentence to Goat Latin, a made up language similar to Pig Latin.
Rules for Goat Latin:

1) If a word begins with a vowel ("a", "e", "i", "o", "u"), append
   "ma" to the end of the word.
2) If a word begins with consonant i.e. not a vowel, remove first
   letter and append it to the end then add "ma".
3) Add letter "a" to the end of first word in the sentence, "aa" to
   the second word, etc etc.

Example 1
Input: $sentence = "I love Perl"
Output: "Imaa ovelmaaa erlPmaaaa"

Example 2
Input: $sentence = "Perl and Raku are friends"
Output: "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa"

Example 3
Input: $sentence = "The Weekly Challenge"
Output: "heTmaa eeklyWmaaa hallengeCmaaaa"
*/

package main

import (
  "fmt"
  "regexp"
  "strings"
)

func head2tail(w string) string {
    matched, _ := regexp.MatchString("(?i)^[aeiou]", w)
    if (matched) {
        return w
    } else {
        return w[1:len(w)] + w[0:1]
    }
}

func goat_latin(sentence string) {
    stringSlice := strings.Split(sentence, " ")
    tail := "a"
    new_sentence := ""
    for _, val := range stringSlice {
	new_sentence += head2tail(val) + "ma" + tail + " "
        tail += "a"
    }
    new_sentence = new_sentence[:len(new_sentence)-1]

    fmt.Printf("sentence '%s' -> '%s'\n", sentence, new_sentence)
}

func main() {
    sentence := "I love Perl"
    goat_latin(sentence)

    sentence = "Perl and Raku are friends"
    goat_latin(sentence)

    sentence = "The Weekly Challenge"
    goat_latin(sentence)
}

