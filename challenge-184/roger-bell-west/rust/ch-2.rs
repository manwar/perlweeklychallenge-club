#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        splitarray(vec!["a 1 2 b 0", "3 c 4 d"]),
        (vec![vec![1, 2, 0], vec![3, 4]], vec![vec!['a', 'b'], vec!['c', 'd']])
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        splitarray(vec!["1 2", "p q r", "s 3", "4 5 t"]),
        (
            vec![vec![1, 2], vec![3], vec![4, 5]],
            vec![vec!['p', 'q', 'r'], vec!['s'], vec!['t']]
        )
    );
}

fn splitarray(list: Vec<&str>) -> (Vec<Vec<u8>>, Vec<Vec<char>>) {
    let mut out = (Vec::new(), Vec::new());
    for ins in list {
        let mut av: Vec<u8> = Vec::new();
        let mut bv: Vec<char> = Vec::new();
        for c in ins.chars() {
            match c {
                '0'..='9' => av.push(c.to_digit(10).unwrap() as u8),
                'a'..='z' => bv.push(c),
                _ => {}
            }
        }
        if av.len() > 0 {
            out.0.push(av);
        }
        if bv.len() > 0 {
            out.1.push(bv);
        }
    }
    out
}
