#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(numbercollision(vec![2, 3, -1]), vec![2, 3]);
}

#[test]
fn test_ex2() {
    assert_eq!(numbercollision(vec![3, 2, -4]), vec![-4]);
}

#[test]
fn test_ex3() {
    assert_eq!(numbercollision(vec![1, -1]), Vec::<i32>::new());
}

fn numbercollision(aa: Vec<i32>) -> Vec<i32> {
    let mut a = aa.clone();
    let mut dirty: bool = true;
    while dirty {
        let mut b = Vec::new();
        dirty = false;
        let mut i = 0;
        while i + 1 <= a.len() {
            if i + 1 < a.len() && a[i] > 0 && a[i + 1] < 0 {
                let ab = a[i + 1].abs();
                if a[i] > ab {
                    b.push(a[i]);
                } else if a[i] < ab {
                    b.push(a[i + 1]);
                }
                i += 2;
                dirty = true;
            } else {
                b.push(a[i]);
                i += 1;
            }
        }
        a = b;
    }
    a
}
