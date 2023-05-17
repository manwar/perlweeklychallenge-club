#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(maxnumber(vec![1, 23]), 231);
}

#[test]
fn test_ex2() {
    assert_eq!(maxnumber(vec![10, 3, 2]), 3210);
}

#[test]
fn test_ex3() {
    assert_eq!(maxnumber(vec![31, 2, 4, 10]), 431210);
}

#[test]
fn test_ex4() {
    assert_eq!(maxnumber(vec![5, 11, 4, 1, 2]), 542111);
}

#[test]
fn test_ex5() {
    assert_eq!(maxnumber(vec![1, 10]), 110);
}

fn maxnumber(lst: Vec<u32>) -> u32 {
    let po = lst.iter().map(|i| i.to_string()).collect::<Vec<String>>();
    let pl = po.iter().map(|i| i.len()).max().unwrap();
    let mut pm: Vec<String> = Vec::new();
    for so in &po {
        let mut sm = so.clone();
        let q = so.chars().collect::<Vec<char>>();
        if q.len() < pl {
            let c = q.last().unwrap();
            for _ in 1..=pl - q.len() {
                sm.push(*c);
            }
        }
        pm.push(sm);
    }
    let mut pi = (0..pm.len()).collect::<Vec<usize>>();
    pi.sort_by_key(|i| &pm[*i]);
    pi.reverse();
    let mut out: String = String::new();
    for st in pi {
        out.push_str(&po[st]);
    }
    out.parse::<u32>().unwrap()
}
