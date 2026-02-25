#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(spellboundsorting(vec![6, 7, 8, 9, 10]), vec![8, 9, 7, 6, 10]);
}

#[test]
fn test_ex2() {
    assert_eq!(spellboundsorting(vec![-3, 0, 1000, 99]), vec![-3, 99, 1000, 0]);
}

#[test]
fn test_ex3() {
    assert_eq!(spellboundsorting(vec![1, 2, 3, 4, 5]), vec![5, 4, 1, 3, 2]);
}

#[test]
fn test_ex4() {
    assert_eq!(
        spellboundsorting(vec![0, -1, -2, -3, -4]),
        vec![-4, -1, -3, -2, 0]
    );
}

#[test]
fn test_ex5() {
    assert_eq!(spellboundsorting(vec![100, 101, 102]), vec![100, 101, 102]);
}

fn spellboundsorting(a: Vec<i32>) -> Vec<i32> {
    let mut o = a.clone();
    o.sort_unstable_by_key(|x| towords(*x));
    o
}

fn towords(a: i32) -> String {
    if a == 0 {
        return "zero".to_string();
    }
    let mut components = Vec::<String>::new();
    let mut b = a;
    if a < 0 {
        b = -a;
        components.push("minus".to_string());
    }
    let vw = vec![
        (1000000000, "milliard"),
        (1000000, "million"),
        (1000, "thousand"),
        (100, "hundred"),
        (90, "ninety"),
        (80, "eighty"),
        (70, "seventy"),
        (60, "sixty"),
        (50, "fifty"),
        (40, "forty"),
        (30, "thirty"),
        (20, "twenty"),
        (19, "nineteen"),
        (18, "eighteen"),
        (17, "seventeen"),
        (16, "sixteen"),
        (15, "fifteen"),
        (14, "fourteen"),
        (13, "thirteen"),
        (12, "twelve"),
        (11, "eleven"),
        (10, "ten"),
        (9, "nine"),
        (8, "eight"),
        (7, "seven"),
        (6, "six"),
        (5, "five"),
        (4, "four"),
        (3, "three"),
        (2, "two"),
        (1, "one"),
    ];
    for w in cw(b, &vw) {
        components.push(w)
    }
    components.join(" ")
}

fn cw(n: i32, vw: &Vec<(i32, &str)>) -> Vec<String> {
    let mut res = Vec::<String>::new();
    for (val, word) in vw {
        if n >= *val {
            let mut andflag = false;
            if n >= 100 {
                andflag = true;
                for w in cw(n / val, &vw) {
                    res.push(w);
                }
            }
            res.push(word.to_string());
            let p = n % val;
            if p > 0 {
                if andflag {
                    res.push("and".to_string());
                }
                for w in cw(p, &vw) {
                    res.push(w);
                }
            }
            break;
        }
    }
    res
}
