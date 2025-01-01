#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(onesandzeroes(vec!["10", "0001", "111001", "1", "0"], 5, 3), 4);
}

#[test]
fn test_ex2() {
    assert_eq!(onesandzeroes(vec!["10", "1", "0"], 1, 1), 2);
}

fn onesandzeroes(a: Vec<&str>, zeroes: usize, ones: usize) -> usize {
    let mut ax = Vec::new();
    for ns in a {
        let mut o = 0;
        let mut n = 0;
        for c in ns.chars() {
            match c {
                '0' => { o += 1; },
                '1' => { n += 1; },
                _ => panic!("Bad digit"),
            };
        }
        ax.push((o, n));
    }
    let mut mx = 0;
    for mask in 1 .. (1 << ax.len()) {
        let mut o = 0;
        let mut n = 0;
        let mut ct = 0;
        for (i, x) in ax.iter().enumerate() {
             if mask & (1 << i) > 0 {
                o += x.0;
                n += x.1;
                ct += 1;
                if o > zeroes || n > ones {
                    break;
                }
            }
            if o <= zeroes && n <= ones {
                mx = std::cmp::max(mx, ct);
            }
        }
    }
    mx
}
