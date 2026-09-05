#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(
        reordernotes(
            "Mozart",
            vec!["C", "D", "E", "F", "G", "A", "B"],
            vec![7, 1, 6, 2, 5, 3, 4]
        ),
        HashMap::from([(
            "Mozart".to_string(),
            vec![
                "D".to_string(),
                "F".to_string(),
                "A".to_string(),
                "B".to_string(),
                "G".to_string(),
                "E".to_string(),
                "C".to_string()
            ]
        )])
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        reordernotes(
            "Chopin",
            vec!["C", "C#", "D", "D#", "E", "F"],
            vec![6, 5, 4, 3, 2, 1]
        ),
        HashMap::from([(
            "Chopin".to_string(),
            vec![
                "F".to_string(),
                "E".to_string(),
                "D#".to_string(),
                "D".to_string(),
                "C#".to_string(),
                "C".to_string()
            ]
        )])
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        reordernotes(
            "Vivaldi",
            vec!["A", "B", "C", "D", "E"],
            vec![1, 2, 3, 4, 5]
        ),
        HashMap::from([(
            "Vivaldi".to_string(),
            vec![
                "A".to_string(),
                "B".to_string(),
                "C".to_string(),
                "D".to_string(),
                "E".to_string()
            ]
        )])
    );
}

#[test]
fn test_ex4() {
    assert_eq!(
        reordernotes(
            "Debussy",
            vec!["C", "D", "F", "G", "A"],
            vec![1, 3, 5, 2, 4]
        ),
        HashMap::from([(
            "Debussy".to_string(),
            vec![
                "C".to_string(),
                "G".to_string(),
                "D".to_string(),
                "A".to_string(),
                "F".to_string()
            ]
        )])
    );
}

#[test]
fn test_ex5() {
    assert_eq!(
        reordernotes("Stravinsky", vec!["C#"], vec![1]),
        HashMap::from([("Stravinsky".to_string(), vec!["C#".to_string()])])
    );
}

fn reordernotes(
    composer: &str,
    notes: Vec<&str>,
    order: Vec<usize>,
) -> HashMap<String, Vec<String>> {
    let mut out = vec!["".to_string(); order.len()];
    for (i, n) in order.iter().enumerate() {
        out[n - 1] = notes[i].to_string();
    }
    HashMap::from([(composer.to_string(), out.clone())])
}
