#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        linecounts(
            "abcdefghijklmnopqrstuvwxyz",
            vec![
                10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
                10, 10, 10, 10, 10, 10, 10, 10, 10, 10
            ]
        ),
        vec![3, 60]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        linecounts(
            "bbbcccdddaaa",
            vec![
                4, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
                10, 10, 10, 10, 10, 10, 10, 10, 10, 10
            ]
        ),
        vec![2, 4]
    );
}

fn linecounts(a: &str, w: Vec<u32>) -> Vec<u32> {
    let mut linecount = 1;
    let mut linewidth = 0;
    let asize = 'a' as usize;
    for c in a.chars() {
        let wd = w[c as usize - asize];
        if linewidth + wd > 100 {
            linecount += 1;
            linewidth = wd;
        } else {
            linewidth += wd;
        }
    }
    vec![linecount, linewidth]
}
