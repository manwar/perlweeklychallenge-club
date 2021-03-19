#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::process;

#[test]
fn test_ex1() {
    assert_eq!(game(12),1);
}

#[test]
fn test_ex2() {
    assert_eq!(game(10),0);
}

#[test]
fn test_ex3() {
    assert_eq!(game(14),0);
}

fn game (hh: u32) -> usize {
    let mut heap: u32=hh;
    let players=vec!["Alice","Bob"];
    let mut a: usize=0;
    while heap>0 {
        let n=play(heap);
        heap -= n;
        eprintln!("{} takes {} leaving {}",players[a],n,heap);
        if heap==0 {
            eprintln!("{} wins",players[a]);
            break;
        }
        a += 1;
        a %= 2;
    }
    return a
}

fn play(state: u32) -> u32 {
    let m=state % 4;
    if m==0 {
        return 1+(process::id()%3) as u32;
    } else {
        return m
    }
}
