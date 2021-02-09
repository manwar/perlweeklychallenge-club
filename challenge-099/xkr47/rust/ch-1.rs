#![allow(dead_code)]

use std::env;

fn main() {
    let mut args = env::args().skip(1).take(2).collect::<Vec<_>>();
    let (text, pattern) = (args.remove(0), args.remove(0));

    let is_match = do_match(&text, &pattern);

    println!("{}", if is_match { 1 } else { 0 });
}

fn do_match(text: &str, pattern: &str) -> bool {
    fn inner(text: &[char], pattern: &[char]) -> bool {
        if pattern.is_empty() {
            text.is_empty()
        } else {
            match pattern[0] {
                '*' =>
                    inner(text, &pattern[1..]) ||
                        (!text.is_empty() && inner(&text[1..], pattern)),
                '?' =>
                    !text.is_empty() && inner(&text[1..], &pattern[1..]),
                ch =>
                    text.get(0) == Some(&ch) && inner(&text[1..], &pattern[1..])
            }
        }
    }
    inner(&text.chars().collect::<Vec<char>>(), &pattern.chars().collect::<Vec<char>>())
}

#[cfg(test)]
mod tests {
    use crate::*;

    // from assignment

    #[test]
    fn do_test1() {
        assert_eq!(do_match("abcde", "a*e"), true);
    }

    #[test]
    fn do_test2() {
        assert_eq!(do_match("abcde", "a*d"), false);
    }

    #[test]
    fn do_test3() {
        assert_eq!(do_match("abcde", "?b*d"), false);
    }

    #[test]
    fn do_test4() {
        assert_eq!(do_match("abcde", "a*c?e"), true);
    }

    // additional

    #[test]
    fn do_test10() {
        assert_eq!(do_match("abc", "a*c?"), false);
    }

    #[test]
    fn do_test11() {
        assert_eq!(do_match("abc", "a*c*"), true);
    }

    #[test]
    fn do_test12() {
        assert_eq!(do_match("abc", "**"), true);
    }

    #[test]
    fn do_test13() {
        assert_eq!(do_match("", "**"), true);
    }

    #[test]
    fn do_test14() {
        assert_eq!(do_match("a", "*?"), true);
    }

    #[test]
    fn do_test15() {
        assert_eq!(do_match("få", "f*"), true);
    }
}
