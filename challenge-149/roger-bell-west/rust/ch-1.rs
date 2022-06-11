#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(fds(8),vec![0, 1, 2, 3, 5, 8, 10, 11]);
}

#[test]
fn test_ex2() {
    assert_eq!(fds(20),vec![0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44]);
}

#[test]
fn test_ex3() {
    assert_eq!(fds(61),vec![0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44, 49, 50, 53, 58, 62, 67, 71, 76, 80, 85, 94, 100, 101, 102, 104, 107, 110, 111, 113, 116, 120, 122, 125, 131, 134, 139, 140, 143, 148, 152, 157, 161, 166, 170, 175, 184, 193, 200, 201, 203, 206]);
}

fn fds(n: u32) -> Vec<u32> {
    let mut o=Vec::new();
    let mut f=[1,0];
    let mut ft: HashSet<u32>=HashSet::from(f);
    let mut k=0;
    while o.len() < n as usize {
        let mut ds=0;
        let mut j=k;
        while j > 0 {
            ds += j % 10;
            j /= 10;
        }
        while f[0] < ds {
            let t=f[1]+f[0];
            f[1]=f[0];
            f[0]=t;
            ft.insert(f[0]);
        }
        if ft.contains(&ds) {
            o.push(k);
        }
        k += 1;
    }
    o
}
