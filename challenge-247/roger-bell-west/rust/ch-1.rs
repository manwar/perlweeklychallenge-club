#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;
use std::iter::FromIterator;

#[test]
fn test_ex1() {
    assert_eq!(
        secretsanta(vec![
            "Mr. Wall",
            "Mrs. Wall",
            "Mr. Anwar",
            "Mrs. Anwar",
            "Mr. Conway",
            "Mr. Cross"
        ]),
        true
    );
}

#[test]
fn test_ex2() {
    assert_eq!(secretsanta(vec!["Mr. Wall", "Mrs. Wall", "Mr. Anwar"]), true);
}

fn secretsanta(name: Vec<&str>) -> bool {
    let mut family = Vec::new();
    for n in &name {
        let surname = n.split(' ').last().unwrap();
        family.push(surname);
    }
    let mut receivers: HashSet<usize> = HashSet::from_iter(0..name.len());
    let mut gifting: Vec<Vec<String>> = Vec::new();
    for giver in 0..name.len() {
        let mut done = false;
        let mut r = 0;
        for recipient in &receivers {
            if family[giver] != family[*recipient] {
                r = *recipient;
                done = true;
                break;
            }
        }
        if !done {
            for recipient in &receivers {
                if recipient != &giver {
                    r = *recipient;
                    break;
                }
            }
        }
        receivers.remove(&r);
        gifting.push(vec![name[giver].to_string(), name[r].to_string()]);
    }
    for p in gifting {
        println!("{} -> {}", p[0], p[1]);
    }
    println!("");
    true
}
