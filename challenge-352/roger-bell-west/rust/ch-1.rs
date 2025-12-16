#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        matchstring(vec![
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
}

#[test]
fn test_ex2() {
    assert_eq!(
        matchstring(vec![
            "hello",
            "hell",
            "world",
            "wor",
            "ellow",
            "elloworld"
        ]),
        vec!["hell", "world", "wor", "ellow"]
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        matchstring(vec!["a", "aa", "aaa", "aaaa"]),
        vec!["a", "aa", "aaa"]
    );
}

#[test]
fn test_ex4() {
    assert_eq!(
        matchstring(vec!["flower", "flow", "flight", "fl", "fli", "ig", "ght"]),
        vec!["flow", "fl", "fli", "ig", "ght"]
    );
}

#[test]
fn test_ex5() {
    assert_eq!(
        matchstring(vec![
            "car",
            "carpet",
            "carpenter",
            "pet",
            "enter",
            "pen",
            "pent"
        ]),
        vec!["car", "pet", "enter", "pen", "pent"]
    );
}

fn matchstring(a: Vec<&str>) -> Vec<String> {
    let mut out = Vec::new();
    for x in &a {
        if !out.contains(x) {
            for y in &a {
                if y.len() > x.len() && y.contains(x) {
                    out.push(x);
                    break;
                }
            }
        }
    }
    out.into_iter().map(|x| x.to_string()).collect::<Vec<String>>()
}
