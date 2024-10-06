package main

import (
	"regexp"
	"sort"
	"strings"
	"testing"
)

func TestJumbleWord(t *testing.T) {
	tests := []struct {
		input string
		desc  string
	}{
		{"abc", "Test case 1: Short word remains unchanged"},
		{"word", "Test case 2: First and last letter remain the same"},
		{"jumbled", "Test case 3: First and last letter remain the same"},
	}

	for _, test := range tests {
		jumbled := jumbleWord(test.input)

		if jumbled[0] != test.input[0] {
			t.Errorf("%s - First letter remains the same", test.desc)
		}
		if jumbled[len(jumbled)-1] != test.input[len(test.input)-1] {
			t.Errorf("%s - Last letter remains the same", test.desc)
		}
		if !lettersPreserved(test.input, jumbled) {
			t.Errorf("%s - All letters are preserved", test.desc)
		}
	}
}

func lettersPreserved(original, jumbled string) bool {
	originalLetters := strings.Split(original, "")
	jumbledLetters := strings.Split(jumbled, "")

	sort.Strings(originalLetters)
	sort.Strings(jumbledLetters)

	return strings.Join(originalLetters, "") == strings.Join(jumbledLetters, "")
}

func TestJumbleText(t *testing.T) {
	inputText := "According to a research at Cambridge University, it doesn't matter in what order the letters in a word are."
	jumbledText := jumbleText(inputText)

	inputWords := regexp.MustCompile(`(\W+|_)`).Split(inputText, -1)
	jumbledWords := regexp.MustCompile(`(\W+|_)`).Split(jumbledText, -1)

	for i, word := range inputWords {
		if word == "" {
			continue
		}
		if jumbledWords[i][0] != word[0] {
			t.Errorf("First letter remains the same for '%s'", word)
		}
		if jumbledWords[i][len(jumbledWords[i])-1] != word[len(word)-1] {
			t.Errorf("Last letter remains the same for '%s'", word)
		}
		if !lettersPreserved(word, jumbledWords[i]) {
			t.Errorf("All letters are preserved for '%s'", word)
		}
	}
}
