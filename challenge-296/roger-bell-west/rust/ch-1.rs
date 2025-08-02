#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(stringcompression("abbc"), "a2bc");
}

#[test]
fn test_ex2() {
    assert_eq!(stringcompression("aaabccc"), "3ab3c");
}

#[test]
fn test_ex3() {
    assert_eq!(stringcompression("abcc"), "ab2c");
}

#[test]
fn test_ex4() {
    assert_eq!(stringdecompression("a2bc"), "abbc");
}

#[test]
fn test_ex5() {
    assert_eq!(stringdecompression("3ab3c"), "aaabccc");
}

#[test]
fn test_ex6() {
    assert_eq!(stringdecompression("ab2c"), "abcc");
}

fn compressedunit(count: usize, letter: char) -> String {
    let mut out = String::new();
    if count > 1 {
        out.push_str(&count.to_string());
    }
    out.push(letter);
    out
}

fn stringcompression(a: &str) -> String {
    let mut out = String::new();
    let mut lastchar: Option<char> = None;
    let mut count = 0;
    for c in a.chars() {
        if count == 0 || Some(c) != lastchar {
            if count > 0 {
                out.push_str(&compressedunit(count, lastchar.unwrap()));
            }
            lastchar = Some(c);
            count = 0;
        }
        count += 1;
    }
    if count > 0 {
        out.push_str(&compressedunit(count, lastchar.unwrap()));
    }
    out
}

fn stringdecompression(a: &str) -> String {
    let mut out = String::new();
    let mut count: usize = 0;
    for c in a.chars() {
        if c >= '0' && c <= '9' {
            count *= 10;
            count += c.to_digit(10).unwrap() as usize;
        } else {
            if count == 0 {
                count = 1;
            }
            out.push_str(&c.to_string().repeat(count));
            count = 0;
        }
    }
    out
}
