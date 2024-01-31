#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(reversevowels("Raku"), "Ruka");
}

#[test]
fn test_ex2() {
    assert_eq!(reversevowels("Perl"), "Perl");
}

#[test]
fn test_ex3() {
    assert_eq!(reversevowels("Julia"), "Jaliu");
}

#[test]
fn test_ex4() {
    assert_eq!(reversevowels("Uiua"), "Auiu");
}

fn is_vowel(c: char) -> bool {
    match c.to_ascii_lowercase() {
        'a' | 'e' | 'i' | 'o' | 'u' => true,
        _ => false,
    }
}

fn reversevowels(a: &str) -> String {
    let p = a.chars().collect::<Vec<_>>();
    let q = p.iter().filter(|c| is_vowel(**c)).collect::<Vec<_>>();
    let mut qi = q.len();
    let mut o: Vec<char> = Vec::new();
    for c in &p {
        if is_vowel(*c) {
            qi -= 1;
            let mut nc = *q[qi];
            if c.is_uppercase() {
                nc = nc.to_ascii_uppercase();
            } else {
                nc = nc.to_ascii_lowercase();
            }
            o.push(nc);
        } else {
            o.push(*c);
        }
    }
    o.iter().collect::<String>()
}
