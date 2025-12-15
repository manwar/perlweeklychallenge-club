#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn match_string<'a>(words: &[&'a str]) -> Vec<&'a str> {
    let mut seen = std::collections::HashSet::new();
    words
        .iter()
        .filter(|&&word| {
            words
                .iter()
                .any(|&other| other != word && other.contains(word))
        })
        .filter_map(|&word| if seen.insert(word) { Some(word) } else { None })
        .collect()
}

#[test]
fn example() {
    assert_eq!(
        match_string(&[
            "cat",
            "cats",
            "dog",
            "dogcat",
            "dogcat",
            "rat",
            "ratcatdogcat"
        ]),
        vec!["cat", "dog", "dogcat", "rat"]
    );
    assert_eq!(
        match_string(&["hello", "hell", "world", "wor", "ellow", "elloworld"]),
        vec!["hell", "world", "wor", "ellow"]
    );
    assert_eq!(
        match_string(&["a", "aa", "aaa", "aaaa"]),
        vec!["a", "aa", "aaa"]
    );
    assert_eq!(
        match_string(&["flower", "flow", "flight", "fl", "fli", "ig", "ght"]),
        vec!["flow", "fl", "fli", "ig", "ght"]
    );
    assert_eq!(
        match_string(&["car", "carpet", "carpenter", "pet", "enter", "pen", "pent"]),
        vec!["car", "pet", "enter", "pen", "pent"]
    );
}
