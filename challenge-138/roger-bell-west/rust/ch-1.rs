#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(workdays(2021),260);
}

#[test]
fn test_ex2() {
    assert_eq!(workdays(2020),262);
}

fn p(y: i32) -> i32 {
    (y+y/4-y/100+y/400) % 7
}

fn leapyear(y: i32) -> bool {
    y%4==0 && (y%100!=0 || y%400==0)
}

fn workdays(y: i32) -> i32 {
    let mut i=p(y);
    if leapyear(y) {
        i+=7;
    }
    260+vec![0,1,1,1,1,0,0,1,2,2,2,2,1][i as usize]
}
