package main

import "core:fmt"
import "core:strings"

outermost_parentheses :: proc(str: string) -> string {
	sb := strings.builder_make()
	depth := 0
	for c in str do switch c {
		case '(':
			depth += 1
			if depth > 1 do strings.write_rune(&sb, '(')
		case ')':
			if depth > 1 do strings.write_rune(&sb, ')')
			depth -= 1
	}
	return strings.to_string(sb)
}

main :: proc() {
	out: string

	out = outermost_parentheses("()()()")
	fmt.println(out)
	delete(out)

	out = outermost_parentheses("(((())))")
	fmt.println(out)
	delete(out)
	
	out = outermost_parentheses("(()())(())")
	fmt.println(out)
	delete(out)
	
	out = outermost_parentheses("()((()))()")
	fmt.println(out)
	delete(out)
	
	out = outermost_parentheses("(()(()))(()())")
	fmt.println(out)
	delete(out)
}

