#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        reversible(99),
        vec![
            10, 12, 14, 16, 18, 21, 23, 25, 27, 30, 32, 34, 36, 41, 43, 45, 50,
            52, 54, 61, 63, 70, 72, 81, 90
        ]
    );
}

fn reversible(mx: usize) -> Vec<usize> {
    let mut o = Vec::new();
    for n in 1..=mx {
        let mut t = n + n
            .to_string()
            .chars()
            .rev()
            .collect::<String>()
            .parse::<usize>()
            .unwrap();
        let mut q = true;
        while t > 0 {
            if t % 2 == 0 {
                q = false;
                break;
            }
            t /= 10;
        }
        if q {
            o.push(n);
        }
    }
    o
}
