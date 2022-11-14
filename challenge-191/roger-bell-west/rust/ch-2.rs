#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(cutelist(2), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(cutelist(10), 700);
}

#[test]
fn test_ex3() {
    assert_eq!(cutelist(15), 24679);
}

fn cutelist(n: usize) -> usize {
    let mut tab: Vec<Vec<bool>> = Vec::new();
    tab.push(Vec::new());
    for _ in 1..=n {
        tab.push(vec![false; n + 1]);
    }
    for x in 1..=n {
        for y in 1..=x {
            if x % y != 0 && y % x != 0 {
                tab[x][y] = true;
                tab[y][x] = true;
            }
        }
    }
    let mut count = 0;
    let mut stackl: Vec<Vec<usize>> = vec![Vec::new()];
    let mut stackc: Vec<Vec<usize>> = Vec::new();
    stackc.push((1..=n).collect::<Vec<usize>>());
    while stackl.len() > 0 {
        let l = stackl.pop().unwrap();
        let c = stackc.pop().unwrap();
        if c.len() == 0 && l.len() == n {
            count += 1;
        } else {
            let place = l.len() + 1;
            for &candidate in &c {
                if !tab[place][candidate] {
                    let mut q = l.clone();
                    q.push(candidate);
                    stackl.push(q);
                    stackc.push(
                        c.iter()
                            .filter(|i| **i != candidate)
                            .map(|i| *i)
                            .collect::<Vec<usize>>(),
                    );
                }
            }
        }
    }
    count
}
