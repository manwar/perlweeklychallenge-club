#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(whowins("HAHAHH"), "Team 2 defeated Team 6");
}

#[test]
fn test_ex2() {
    assert_eq!(whowins("HHHHHH"), "Team 1 defeated Team 2");
}

#[test]
fn test_ex3() {
    assert_eq!(whowins("HHHAHA"), "Team 4 defeated Team 2");
}

#[test]
fn test_ex4() {
    assert_eq!(whowins("HAHAAH"), "Team 4 defeated Team 6");
}

#[test]
fn test_ex5() {
    assert_eq!(whowins("AAHHAA"), "Team 6 defeated Team 1");
}

fn whowins(a: &str) -> String {
    let mut round2 = HashSet::new();
    let mut round3 = HashSet::new();
    for (i, c) in a.chars().enumerate() {
        match i {
            0 => {
                if c == 'H' {
                    round2.insert(2);
                } else {
                    round2.insert(7);
                }
            }
            1 => {
                if c == 'H' {
                    round2.insert(3);
                } else {
                    round2.insert(6);
                }
            }
            2 => {
                if c == 'H' {
                    round2.insert(4);
                } else {
                    round2.insert(5);
                }
            }
            3 => {
                if c == 'H' {
                    round3.insert(1);
                } else {
                    round3.insert(*round2.iter().max().unwrap());
                }
            }
            4 => {
                let mut k = round2.iter().collect::<Vec<_>>();
                k.sort();
                let _ = k.pop();
                if c == 'H' {
                    round3.insert(*k[0]);
                } else {
                    round3.insert(*k[1]);
                }
            }
            5 => {
                let mut k = round3.iter().collect::<Vec<_>>();
                k.sort();
                if c == 'H' {
                    return format!("Team {} defeated Team {}", k[0], k[1]);
                } else {
                    return format!("Team {} defeated Team {}", k[1], k[0]);
                }
            }
            _ => {}
        };
    }
    String::new()
}
