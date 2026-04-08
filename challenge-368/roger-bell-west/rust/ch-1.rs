#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(makeitbigger("15456", "5"), "1546");
}

#[test]
fn test_ex2() {
    assert_eq!(makeitbigger("7332", "3"), "732");
}

#[test]
fn test_ex3() {
    assert_eq!(makeitbigger("2231", "2"), "231");
}

#[test]
fn test_ex4() {
    assert_eq!(makeitbigger("543251", "5"), "54321");
}

#[test]
fn test_ex5() {
    assert_eq!(makeitbigger("1921", "1"), "921");
}

fn makeitbigger(st: &str, ch: &str) -> String {
    let cc = st.chars().collect::<Vec<char>>();
    let cx = ch.chars().nth(0).unwrap();
    let mut nn = Vec::new();
    for i in 0 .. cc.len() {
        if cc[i] == cx {
            let mut nv = cc[0 .. i].to_vec();
            nv.append(&mut cc[i + 1 .. ].to_vec());
            nn.push(nv.into_iter().collect::<String>().parse::<u32>().unwrap());
        }
    }
    nn.into_iter().max().unwrap().to_string()
}
