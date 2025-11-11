package main

import run "github.com/ysth/runweeklychallenge-go"

func LongestBalancedParentheses(inputString string) (int) {

    longest_length := 0
    nested_depth := 0
    start_index := []int{}

    for index, rune := range inputString {
        if rune == '(' {
            // opening parenthesis

            nested_depth++

            // a new potentially balanced string starts here, unless we just had a close paren for this same depth
            if (len(start_index) < nested_depth) {
                start_index = append(start_index, index)
            }
        } else if nested_depth > 0 {
            // closing parenthesis and there's something to close

            nested_depth--

            length := index - start_index[nested_depth] + 1
            if (length > longest_length) {
                longest_length = length
            }

            // starting indexes deeper than this just closed depth are no longer relevant
            start_index = start_index[:nested_depth+1]
        } else {
            // bad closing parenthesis; nothing before this is relevant anymore

            start_index = []int{}
            nested_depth = 0
        }
    }

    return longest_length;
}

func main() {
    runSolution := func(inputs any) (any, error) {
        return LongestBalancedParentheses(inputs.(string)), nil
    }

    inputExample := `"()()"`

    inputSchema := `{
        "type": "string"
    }`

    run.RunWeeklyChallenge(runSolution, inputExample, inputSchema)
}
