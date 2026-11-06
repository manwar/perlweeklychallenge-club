#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(stringdifference(vec!["ab", "bc", "cd", "zy"]), "zy");
}

#[test]
fn test_ex2() {
    assert_eq!(stringdifference(vec!["cba", "fed", "azy"]), "azy");
}

#[test]
fn test_ex3() {
    assert_eq!(stringdifference(vec!["pop", "ada", "beb", "cfc"]), "pop");
}

#[test]
fn test_ex4() {
    assert_eq!(stringdifference(vec!["aaaa", "zzzz", "mmmm", "aaba"]), "aaba");
}

#[test]
fn test_ex5() {
    assert_eq!(stringdifference(vec!["aceg", "bdfh", "cegi", "azbz"]), "azbz");
}

fn stringdifference(a: Vec<&str>) -> String {
    let mut da = Vec::new();
    for s in &a {
        let mut p = Vec::new();
        for d in s.chars().collect::<Vec<_>>().windows(2) {
            p.push((d[1] as i32) - (d[0] as i32));
        }
        da.push(p);
    }
    let mut dx = 0;
    for b in 1..a.len() {
        if da[0] != da[b] {
            if dx > 0 {
                dx = 0;
                break;
            } else {
                dx = b;
            }
        }
    }
    a[dx].to_string()
}
