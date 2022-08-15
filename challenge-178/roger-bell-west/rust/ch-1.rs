#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(r2qi(4), "10300".to_string());
}

#[test]
fn test_ex2() {
    assert_eq!(qi2r("10300"), 4);
}

fn r2qi(n: isize) -> String {
    c2qi(n, 0)
}

fn c2qi(r0: isize, i0: isize) -> String {
    let mut l = Vec::new();
    for n0 in [i0, r0] {
        let mut n = n0;
        let mut digits = Vec::new();
        while n != 0 {
            let mut digit = n % -4;
            n /= -4;
            if digit < 0 {
                digit += 4;
                n += 1;
            }
            digits.push(digit);
        }
        l.push(digits);
    }
    let ld: isize = l[0].len() as isize - l[1].len() as isize;
    if ld < 0 {
        let mut t = vec![0; (-ld - 1) as usize];
        t.append(&mut l[0]);
        l[0] = t;
    } else if ld > 1 {
        let mut t = vec![0; ld as usize];
        t.append(&mut l[1]);
        l[1] = t;
    }
    let mut o = "".to_string();
    for i in (0..l[1].len()).rev() {
        for b in 0..=1 {
            if l[b].len() > i {
                o.push_str(&l[b][i].to_string());
            }
        }
    }
    o
}

fn qi2r(n: &str) -> isize {
    qi2c(n)[0]
}

fn qi2c(n: &str) -> Vec<isize> {
    let mut pow = 1isize;
    let mut ri = 0;
    let mut o = vec![0isize; 2];
    for ch in n.chars().rev() {
        o[ri] += (ch.to_digit(10).unwrap() as isize) * pow;
        ri += 1;
        pow *= 2;
        if ri == 2 {
            ri = 0;
            pow = -pow;
        }
    }
    o
}
