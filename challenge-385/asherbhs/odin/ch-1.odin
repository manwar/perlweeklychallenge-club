package main

import "core:fmt"
import "core:strings"

uncommon_words :: proc(sentence1, sentence2: string) -> []string {
	counts := make(map[string]int)
	defer delete(counts)
	{
		words := strings.split(sentence1, " ")
		defer delete(words)
		for word in words {
			if word in counts {
				counts[word] += 1
			} else {
				counts[word] = 1
			}
		}
	}
	{
		words := strings.split(sentence2, " ")
		defer delete(words)
		for word in words {
			if word in counts {
				counts[word] += 1
			} else {
				counts[word] = 1
			}
		}
	}
	words := make([dynamic]string)
	for word, count in counts do if count == 1 do append(&words, word)
	return words[:]
}

main :: proc() {
	words: []string

	words = uncommon_words("apple banana apple", "banana orange")
	fmt.println(words)
	delete(words)

	words = uncommon_words("cat dog", "bird fish")
	fmt.println(words)
	delete(words)

	words = uncommon_words("the quick brown fox", "the quick")
	fmt.println(words)
	delete(words)

	words = uncommon_words("hello", "hello")
	fmt.println(words)
	delete(words)

	words = uncommon_words("blue blue red", "red green green yellow")
	fmt.println(words)
	delete(words)
}
