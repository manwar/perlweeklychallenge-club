#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(goodtriplets(vec![3, 0, 1, 1, 9, 7], 7, 2, 3), 4);
}

#[test]
fn test_ex2() {
    assert_eq!(goodtriplets(vec![1, 1, 2, 2, 3], 0, 0, 1), 0);
}

fn goodtriplets(a: Vec<isize>, x: isize, y: isize, z: isize) -> usize {
    let mut c = 0;
    for i in 0..=a.len() - 3 {
        for j in (i + 1)..=a.len() - 2 {
            if (a[i] - a[j]).abs() <= x {
                for k in (j + 1)..=a.len() - 1 {
                    if (a[j] - a[k]).abs() <= y && (a[i] - a[k]).abs() <= z {
                        c += 1;
                    }
                }
            }
        }
    }
    c
}
