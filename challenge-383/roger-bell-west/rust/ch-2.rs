#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(nearestrgb("#F4B2D1"), "#FF99CC");
}

#[test]
fn test_ex2() {
    assert_eq!(nearestrgb("#15E6E5"), "#00FFCC");
}

#[test]
fn test_ex3() {
    assert_eq!(nearestrgb("#191A65"), "#003366");
}

#[test]
fn test_ex4() {
    assert_eq!(nearestrgb("#2D5A1B"), "#336633");
}

#[test]
fn test_ex5() {
    assert_eq!(nearestrgb("#00FF66"), "#00FF66");
}

fn nearestrgb(a: &str) -> String {
    let b = a.strip_prefix("#").unwrap();
    let s = u32::from_str_radix(&b, 16).unwrap();
    let mut rgb = Vec::new();
    for bs in [16, 8, 0] {
        let cs = (s >> bs) & 0xff;
        let mut ct = cs / 51 * 51;
        if cs - ct > 25 {
            ct += 51;
        }
        rgb.push(ct);
    }
    format!("#{:02X}{:02X}{:02X}", rgb[0], rgb[1], rgb[2])
}
