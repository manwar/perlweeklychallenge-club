#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn common_characters(words: &[&str]) -> Vec<char> {
    if words.is_empty() {
        return Vec::new();
    }
    let mut result = words[0].chars().collect::<Vec<_>>();
    for word in &words[1..] {
        let mut word_chars = word.chars().collect::<Vec<_>>();
        result.retain(|&c| {
            if let Some(pos) = word_chars.iter().position(|&x| x == c) {
                word_chars.remove(pos);
                true
            } else {
                false
            }
        });
    }
    result
}

#[test]
fn example() {
    assert_eq!(
        common_characters(&["bella", "label", "roller"]),
        vec!['e', 'l', 'l']
    );
    assert_eq!(common_characters(&["cool", "lock", "cook"]), vec!['c', 'o']);
    assert_eq!(
        common_characters(&["hello", "world", "pole"]),
        vec!['l', 'o']
    );
    assert_eq!(common_characters(&["abc", "def", "ghi"]), vec![]);
    assert_eq!(common_characters(&["aab", "aac", "aaa"]), vec!['a', 'a']);
}
