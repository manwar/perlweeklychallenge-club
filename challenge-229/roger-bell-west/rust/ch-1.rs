#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(lexicographic(vec!["abc", "bce", "cae"]), 1);
}

#[test]
fn test_ex2() {
    assert_eq!(lexicographic(vec!["yxz", "cba", "mon"]), 2);
}

fn lexicographic(a: Vec<&str>) -> u32 {
    let mut t = 0;
    for st in a {
        let mut q = st.chars().collect::<Vec<char>>();
        q.sort();
        if q.iter().collect::<String>() == st {
            continue;
        }
        q.reverse();
        if q.iter().collect::<String>() == st {
            continue;
        }
        t += 1;
    }
    t
}
