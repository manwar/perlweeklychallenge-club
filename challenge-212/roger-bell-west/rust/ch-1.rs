#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(jumpingletters("Perl", vec![2, 22, 19, 9]), "Raku");
}

#[test]
fn test_ex2() {
    assert_eq!(jumpingletters("Raku", vec![24, 4, 7, 17]), "Perl");
}

fn jumpingletters(word: &str, jump: Vec<u8>) -> String {
    let mut s: Vec<u8> = Vec::new();
    for (i, c) in word.bytes().enumerate() {
        let mut d = c + jump[i] % 26;
        if (c <= 90 && d > 90) || d > 122 {
            d -= 26;
        }
        s.push(d);
    }
    String::from_utf8(s).unwrap()
}
