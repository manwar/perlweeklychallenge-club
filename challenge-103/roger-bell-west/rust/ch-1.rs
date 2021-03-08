#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(cz(2017),"Fire Rooster");
}

#[test]
fn test_ex2() {
    assert_eq!(cz(1938),"Earth Tiger");
}

fn cz(yy: i32) -> String {
    let mut y: i32=yy;
    if y<0 {
        y += 1;
    }
    y %= 60;
    while y<0 {
        y += 60;
    }
    let yu: usize=y as usize;
    let mut out="".to_string();
    out.push_str(vec!["Metal","Water","Wood","Fire","Earth"][(yu/2)%5]);
    out.push_str(" ");
    out.push_str(vec!["Monkey","Rooster","Dog","Pig","Rat","Water Buffalo","Tiger","Cat","Dragon","Snake","Horse","Goat"][yu%12]);
    return out;
}
