package main

import (
	"math/rand"
	"regexp"
	"strings"
	"time"
)

func jumbleWord(word string) string {
	if len(word) <= 3 {
		return word
	}

	middle := word[1 : len(word)-1]
	chars := []rune(middle)

	rand.Seed(time.Now().UnixNano())
	rand.Shuffle(len(chars), func(i, j int) {
		chars[i], chars[j] = chars[j], chars[i]
	})

	return string(word[0]) + string(chars) + string(word[len(word)-1])
}

func jumbleText(text string) string {
	re := regexp.MustCompile(`(\W+|_)`)
	tokens := re.Split(text, -1)
	nonWordTokens := re.FindAllString(text, -1)

	var result []string

	for i, token := range tokens {
		if isAlpha(token) {
			result = append(result, jumbleWord(token))
		}
		if i < len(nonWordTokens) {
			result = append(result, nonWordTokens[i])
		}
	}

	return strings.Join(result, "")
}

func isAlpha(s string) bool {
	re := regexp.MustCompile(`^[A-Za-z]+$`)
	return re.MatchString(s)
}
