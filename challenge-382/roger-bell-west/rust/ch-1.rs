#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::{HashMap, HashSet};

fn isqrt(s: u32) -> u32 {
    if s <= 1 {
        return s;
    }
    let mut x0 = s / 2;
    let mut x1 = (x0 + s / x0) / 2;
    while x1 < x0 {
        x0 = x1;
        x1 = (x0 + s / x0) / 2;
    }
    return x0;
}

fn is_adjacentsquared(param: u32, hc: Vec<u32>) {
    let mut hcs = hc.clone();
    hcs.sort();
    assert_eq!(hcs, (1..=param).collect::<Vec<u32>>());
    for i in 0..=(param as usize) - 2 {
        let pn = hc[i] + hc[i + 1];
        let sn = isqrt(pn);
        assert_eq!(pn, sn * sn);
    }
    let pn = hc[0] + hc[hc.len() - 1];
    let sn = isqrt(pn * pn);
    assert_eq!(pn, sn);
}

#[test]
fn test_ex1() {
    is_adjacentsquared(32, hamiltoniancycle(32));
}

#[test]
fn test_ex2() {
    assert_eq!(hamiltoniancycle(15), Vec::<u32>::new());
}

#[test]
fn test_ex3() {
    is_adjacentsquared(34, hamiltoniancycle(34));
}

fn hamiltoniancycle(a: u32) -> Vec<u32> {
    if a < 31 {
        return Vec::new();
    }
    let mut perfectsquares = HashSet::new();
    {
        let lim = a * 2;
        for p in 1..=a {
            let ps = p * p;
            if ps > lim {
                break;
            }
            perfectsquares.insert(ps);
        }
    }
    let mut neighbours = HashMap::new();
    for x in 1..=a {
        for y in &perfectsquares {
            if *y > x {
                let z = ((*y as i32) - (x as i32)) as u32;
                if z <= a {
                    {
                        let en = neighbours.entry(x).or_insert(HashSet::new());
                        (*en).insert(z);
                    }
                    {
                        let en = neighbours.entry(z).or_insert(HashSet::new());
                        (*en).insert(x);
                    }
                }
            }
        }
    }
    let sl = a as usize;
    let mut stack: Vec<Vec<u32>> = vec![vec![1]];
    while let Some(lst) = stack.pop() {
        if lst.len() == sl {
            if perfectsquares.contains(&(lst[0] + lst[lst.len() - 1])) {
                return lst;
            }
        } else {
            for candidate in neighbours.get(&lst[lst.len() - 1]).unwrap() {
                if !lst.contains(&candidate) {
                    let mut nlst = lst.clone();
                    nlst.push(*candidate);
                    stack.push(nlst);
                }
            }
        }
    }
    Vec::new()
}
