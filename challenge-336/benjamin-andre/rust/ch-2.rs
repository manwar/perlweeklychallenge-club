#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn final_score(scores: &[&str]) -> i32 {
    let mut stack = Vec::new();
    for score in scores {
        match *score {
            "C" => {
                stack.pop();
            }
            "D" => {
                let last = *stack.last().unwrap();
                stack.push(last * 2);
            }
            "+" => {
                let len = stack.len();
                stack.push(stack[len - 1] + stack[len - 2]);
            }
            _ => stack.push(score.parse().unwrap()),
        }
    }
    stack.iter().sum()
}

#[test]
fn example() {
    assert_eq!(final_score(&["5", "2", "C", "D", "+"]), 30);
    assert_eq!(final_score(&["5", "-2", "4", "C", "D", "9", "+", "+"]), 27);
    assert_eq!(final_score(&["7", "D", "D", "C", "+", "3"]), 45);
    assert_eq!(final_score(&["-5", "-10", "+", "D", "C", "+"]), -55);
    assert_eq!(
        final_score(&["3", "6", "+", "D", "C", "8", "+", "D", "-2", "C", "+"]),
        128
    );
}
