package main

import "core:fmt"
import "core:strings"

replace_question_mark :: proc(str: string) -> []string {
	length := len(str)

	// tot up
	mark_count: u32 = 0
	for c in str do mark_count += u32(c == '?')
	out_count := 1 << mark_count

	// make builders
	builders := make([]strings.Builder, out_count)
	for i in 0 ..< out_count do builders[i] = strings.builder_make(0, length)

	// fill in ?s
	bit := mark_count - 1
	for c in str {
		if c == '?' {
			for i in 0 ..< out_count do strings.write_byte(&builders[i], u8(
				'0' + ((i >> bit) & 1)
			))
			bit -= 1
		} else {
			for i in 0 ..< out_count do strings.write_rune(&builders[i], c)
		}
	}

	// make strings
	out := make([]string, out_count)
	for sb, i in builders do out[i] = strings.to_string(sb)
	delete(builders)

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

