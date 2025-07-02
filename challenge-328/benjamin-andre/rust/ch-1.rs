#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn replace(s: &str) -> String {
    let mut res: Vec<char> = s.chars().collect();
    let n = res.len();
    for i in 0..n {
        if res[i] == '?' {
            for c in 'a'..='z' {
                if (i == 0 || res[i - 1] != c) && (i == n - 1 || res[i + 1] != c) {
                    res[i] = c;
                    break;
                }
            }
        }
    }
    res.into_iter().collect()
}

#[test]
fn example() {
    assert_eq!(replace("a?z"), "abz");
    assert_eq!(replace("pe?k"), "peak");
    assert_eq!(replace("gra?te"), "grabte");
}
