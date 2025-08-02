#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(reverseword("challenge", 'e'), "acehllnge");
}

#[test]
fn test_ex2() {
    assert_eq!(reverseword("programming", 'a'), "agoprrmming");
}

#[test]
fn test_ex3() {
    assert_eq!(reverseword("champion", 'b'), "champion");
}

fn reverseword(a: &str, c: char) -> String {
    match a.find(c) {
        Some(s) => {
            let b = a.bytes().collect::<Vec<_>>();
            let mut c: Vec<u8> = b[0..=s].to_vec();
            c.sort();
            c.append(&mut b[s + 1..b.len()].to_vec());
            return std::str::from_utf8(&c).unwrap().to_string();
        }
        _ => {
            return a.to_string();
        }
    };
}
