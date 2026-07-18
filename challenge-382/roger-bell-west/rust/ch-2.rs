#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        replacequestionmark("01??0"),
        vec!["01000", "01010", "01100", "01110"]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(replacequestionmark("101"), vec!["101"]);
}

#[test]
fn test_ex3() {
    assert_eq!(
        replacequestionmark("???"),
        vec!["000", "001", "010", "011", "100", "101", "110", "111"]
    );
}

#[test]
fn test_ex4() {
    assert_eq!(replacequestionmark("1?10"), vec!["1010", "1110"]);
}

#[test]
fn test_ex5() {
    assert_eq!(
        replacequestionmark("1?1?0"),
        vec!["10100", "10110", "11100", "11110"]
    );
}

fn replacequestionmark(a: &str) -> Vec<String> {
    let template = a.chars().collect::<Vec<char>>();
    let q = template.iter().filter(|x| **x == '?').count();
    if q == 0 {
        return vec![a.to_string()];
    }
    let mut out = Vec::new();
    for n in 0..(1 << q) {
        let mut qm = Vec::new();
        let mut nn = n;
        while nn > 0 {
            qm.push(if nn % 2 == 1 { '1' } else { '0' });
            nn /= 2;
        }
        while qm.len() < q {
            qm.push('0');
        }
        let mut entry = String::new();
        for tc in template.iter() {
            match tc {
                '?' => {
                    entry.push(qm.pop().unwrap());
                }
                _ => {
                    entry.push(*tc);
                }
            };
        }
        out.push(entry.to_string());
    }
    out
}
