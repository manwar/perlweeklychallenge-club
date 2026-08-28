#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(dyckwords(1), vec!["UD"]);
}

#[test]
fn test_ex2() {
    assert_eq!(dyckwords(2), vec!["UDUD", "UUDD"]);
}

#[test]
fn test_ex3() {
    assert_eq!(
        dyckwords(3),
        vec!["UDUDUD", "UDUUDD", "UUDDUD", "UUDUDD", "UUUDDD"]
    );
}

#[test]
fn test_ex4() {
    assert_eq!(dyckwords(0), vec![""]);
}

#[test]
fn test_ex5() {
    assert_eq!(
        dyckwords(4),
        vec![
            "UDUDUDUD", "UDUDUUDD", "UDUUDDUD", "UDUUDUDD", "UDUUUDDD",
            "UUDDUDUD", "UUDDUUDD", "UUDUDDUD", "UUDUDUDD", "UUDUUDDD",
            "UUUDDDUD", "UUUDDUDD", "UUUDUDDD", "UUUUDDDD"
        ]
    );
}

use std::collections::VecDeque;

fn dyckwords(order: usize) -> Vec<String> {
    let mut out: Vec<String> = Vec::new();
    let mut queue: VecDeque<String> = VecDeque::new();
    queue.push_back(String::new());
    while let Some(st) = queue.pop_front() {
        let dcount = st.chars().filter(|c| *c == 'D').count();
        if st.len() == order * 2 {
            if dcount == order {
                out.push(st);
            }
        } else {
            if dcount * 2 < st.len() {
                let mut sc = st.clone();
                sc.push('D');
                queue.push_back(sc);
            }
            let mut sc = st.clone();
            sc.push('U');
            queue.push_back(sc);
        }
    }
    out
}
