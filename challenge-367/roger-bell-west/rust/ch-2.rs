#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        conflictevents(vec!["10:00", "12:00"], vec!["11:00", "13:00"]),
        true
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        conflictevents(vec!["09:00", "10:30"], vec!["10:30", "12:00"]),
        false
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        conflictevents(vec!["14:00", "15:30"], vec!["14:30", "16:00"]),
        true
    );
}

#[test]
fn test_ex4() {
    assert_eq!(
        conflictevents(vec!["08:00", "09:00"], vec!["09:01", "10:00"]),
        false
    );
}

#[test]
fn test_ex5() {
    assert_eq!(
        conflictevents(vec!["23:30", "00:30"], vec!["00:00", "01:00"]),
        true
    );
}

//#[derive(Clone, Copy)]
struct Range {
    start: u16,
    end: u16,
}

fn parsetime(t: &str) -> u16 {
    let p = t.split(':').collect::<Vec<_>>();
    p[0].parse::<u16>().unwrap() * 60 + p[1].parse::<u16>().unwrap()
}

fn conflictevents(a: Vec<&str>, b: Vec<&str>) -> bool {
    let mut r = Vec::new();
    for t in [a, b] {
        let st = parsetime(t[0]);
        let en = parsetime(t[1]);
        if st < en {
            r.push(vec![Range { start: st, end: en - 1 }]);
        } else {
            r.push(vec![
                Range { start: st, end: 1440 - 1 },
                Range { start: 0, end: en - 1 },
            ]);
        }
    }
    for ra in &r[0] {
        for rb in &r[1] {
            if ra.start <= rb.end && rb.start <= ra.end {
                return true;
            }
        }
    }
    false
}
