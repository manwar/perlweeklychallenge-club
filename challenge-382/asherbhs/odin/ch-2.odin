package main

import "core:fmt"
import "core:strings"

replace_question_mark :: proc(str: string) -> []string {
	n: u32 = 0
	for c in str do n += u32(c == '?')
	n = 1 << n
	out := make([dynamic]string, 0, n)
	for m in 0 ..< n {
		m := m
		sb := strings.builder_make()
		for c in str {
			if c == '?' {
				strings.write_byte(&sb, bool(m & 1) ? '1' : '0')
				m = m >> 1
			} else {
				strings.write_rune(&sb, c)
			}
		}
		append(&out, strings.to_string(sb))
	}
	return out[:]
}

main :: proc() {
	inputs: []string = {
		"01??0",
		"101",
		"???",
		"1?10",
		"1?1?0",
	} 
	for str in inputs {
		out := replace_question_mark(str)
		fmt.println(out)
		for s in out do delete(s)
		delete(out)
	}
}

