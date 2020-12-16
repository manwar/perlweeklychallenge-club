#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(jg(vec![1,2,1,2]),1);
}

#[test]
fn test_ex2() {
    assert_eq!(jg(vec![2,1,1,0,2]),0);
}

fn jg(n: Vec<i64>) -> i64 {
    //  my $mx=$#{$n};
    let mx=n.len()-1;
    let mut p=0;
    loop {
        p += n[p] as usize;
        if p==mx {
            return 1;
        } else if p > mx || n[p]==0 {
            return 0;
        }
    }
}
