#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit
fn magic_expression(s: &str, target: i32) -> Vec<String> {
    fn eval(expr: &str) -> i32 {
        let mut terms = Vec::new();
        let mut current = 0;
        let mut op = '+';
        for c in expr.chars().chain(std::iter::once('+')) {
            if c.is_ascii_digit() {
                current = current * 10 + c.to_digit(10).unwrap() as i32;
            } else {
                let value = if op == '*' {
                    terms.pop().unwrap() * current
                } else {
                    current * if op == '-' { -1 } else { 1 }
                };
                terms.push(value);
                current = 0;
                op = c;
            }
        }
        terms.iter().sum()
    }

    fn generate(s: &str, pos: usize, expr: String, target: i32, result: &mut Vec<String>) {
        if pos == s.len() {
            if eval(&expr) == target {
                result.push(expr);
            }
            return;
        }
        let ch = s.chars().nth(pos).unwrap();
        if pos == 0 {
            generate(s, pos + 1, ch.to_string(), target, result);
        } else {
            for &op in &['+', '-', '*'] {
                generate(s, pos + 1, format!("{}{}{}", expr, op, ch), target, result);
            }
        }
    }

    let mut result = Vec::new();
    generate(s, 0, String::new(), target, &mut result);
    result
}

#[test]
fn example() {
    assert_eq!(magic_expression("123", 6), vec!["1*2*3", "1+2+3"]);
    assert_eq!(magic_expression("105", 5), vec!["1*0+5", "10-5"]);
    assert_eq!(magic_expression("232", 8), vec!["2*3+2", "2+3*2"]);
    assert_eq!(magic_expression("1234", 10), vec!["1*2*3+4", "1+2+3+4"]);
    assert_eq!(
        magic_expression("1001", 2),
        vec!["1+0*0+1", "1+0+0+1", "1+0-0+1", "1-0*0+1", "1-0+0+1", "1-0-0+1"]
    );
}
