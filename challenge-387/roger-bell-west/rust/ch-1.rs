#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(rearrangebinarystring("111000"), 0);
}

#[test]
fn test_ex2() {
    assert_eq!(rearrangebinarystring("00011"), 4);
}

#[test]
fn test_ex3() {
    assert_eq!(rearrangebinarystring("01011"), 3);
}

#[test]
fn test_ex4() {
    assert_eq!(rearrangebinarystring("010101"), 3);
}

#[test]
fn test_ex5() {
    assert_eq!(rearrangebinarystring("00001"), 4);
}

fn rearrangebinarystring(a0: &str) -> usize {
    let mut ct = 0;
    let mut a = a0.to_owned().clone();
    loop {
        let mut dirty = false;
        let mut b = String::new();
        let c = a.chars().collect::<Vec<char>>();
        let mut ci = 0;
        while ci < c.len() {
            if c[ci] == '0' && ci + 1 < c.len() && c[ci + 1] == '1' {
                b.push('1');
                b.push('0');
                ci += 2;
                dirty = true;
            } else {
                b.push(c[ci]);
                ci += 1;
            }
        }
        if dirty {
            ct += 1;
            a = b.clone();
        } else {
            break;
        }
    }
    ct
}
