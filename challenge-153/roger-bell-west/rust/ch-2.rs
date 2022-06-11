#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(factorion(145), true);
}

#[test]
fn test_ex2() {
    assert_eq!(factorion(125), false);
}

fn factorion(input: u32) -> bool {
    if input == 0 {
        return false;
    }
    let mut fd: [u32; 10] = [1; 10];
    let mut ff: u32 = 1;
    for i in 1..=9 {
        ff *= i as u32;
        fd[i] = ff;
    }
    let mut working = input;
    let mut dsum = 0;
    while working > 0 {
        dsum += fd[(working % 10) as usize];
        working /= 10;
    }
    input == dsum
}
