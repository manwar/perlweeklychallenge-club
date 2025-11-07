#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn longest_parenthesis(s: &str) -> usize {
    let mut stack = vec![-1];
    let mut max_len = 0;
    for (i, c) in s.chars().enumerate() {
        if c == '(' {
            stack.push(i as i32);
        } else {
            stack.pop();
            if stack.is_empty() {
                stack.push(i as i32);
            } else {
                max_len = max_len.max(i as i32 - stack[stack.len() - 1]);
            }
        }
    }
    max_len as usize
}

#[test]
fn example() {
    assert_eq!(longest_parenthesis("(()())"), 6);
    assert_eq!(longest_parenthesis(")()())"), 4);
    assert_eq!(longest_parenthesis("((()))()(((("), 8);
    assert_eq!(longest_parenthesis("))))(()("), 2);
    assert_eq!(longest_parenthesis("()(()"), 2);
}
