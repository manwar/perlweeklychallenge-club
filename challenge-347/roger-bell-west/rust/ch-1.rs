#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(formatdate("1st Jan 2025"), "2025-01-01");
}

#[test]
fn test_ex2() {
    assert_eq!(formatdate("22nd Feb 2025"), "2025-02-22");
}

#[test]
fn test_ex3() {
    assert_eq!(formatdate("15th Apr 2025"), "2025-04-15");
}

#[test]
fn test_ex4() {
    assert_eq!(formatdate("23rd Oct 2025"), "2025-10-23");
}

#[test]
fn test_ex5() {
    assert_eq!(formatdate("31st Dec 2025"), "2025-12-31");
}

fn formatdate(a: &str) -> String {
    let dmy = a.split(' ').collect::<Vec<&str>>();
    let mut out = Vec::new();
    out.push(dmy[2].parse::<u32>().unwrap());
    out.push(match dmy[1] {
        "Jan" => 1,
        "Feb" => 2,
        "Mar" => 3,
        "Apr" => 4,
        "May" => 5,
        "Jun" => 6,
        "Jul" => 7,
        "Aug" => 8,
        "Sep" => 9,
        "Oct" => 10,
        "Nov" => 11,
        "Dec" => 12,
        _ => 0,
    });
    out.push({
        let c = dmy[0].chars().collect::<Vec<char>>();
        if c.len() >= 2 && c[1].is_ascii_digit() {
            c[0].to_digit(10).unwrap() * 10 + c[1].to_digit(10).unwrap()
        } else {
            c[0].to_digit(10).unwrap()
        }
    });
    format!["{:04}-{:02}-{:02}", out[0], out[1], out[2]]
}
