package ch2

import "core:fmt"
import "core:testing"

string_difference :: proc(words: []string) -> (result: string, ok: bool) {
	counts := make(map[string]int, context.temp_allocator)
	keys := make([]string, len(words), context.temp_allocator)
	for w, i in words {
		key := ""
		for j in 0 ..< len(w) - 1 {
			d := int(w[j + 1]) - int(w[j])
			key = fmt.tprintf("%d", d) if j == 0 else fmt.tprintf("%s,%d", key, d)
		}
		keys[i] = key
		counts[key] += 1
	}

	for w, i in words {
		if counts[keys[i]] == 1 do return w, true
	}
	return "", false
}

check :: proc(t: ^testing.T, words: []string, expected: string, loc := #caller_location) {
	got, ok := string_difference(words)
	testing.expect(t, ok, "expected a result, got none", loc = loc)
	testing.expect_value(t, got, expected, loc)
}

@(test)
string_difference_test :: proc(t: ^testing.T) {
	check(t, []string{"ab", "bc", "cd", "zy"}, "zy")
	check(t, []string{"cba", "fed", "azy"}, "azy")
	check(t, []string{"pop", "ada", "beb", "cfc"}, "pop")
	check(t, []string{"aaaa", "zzzz", "mmmm", "aaba"}, "aaba")
	check(t, []string{"aceg", "bdfh", "cegi", "azbz"}, "azbz")
}
