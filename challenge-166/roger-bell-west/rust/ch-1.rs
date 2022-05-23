use itertools::Itertools;
use std::collections::HashMap;
use std::fs::File;
use std::io::{prelude::*, BufReader};

#[test]
fn test_ex1() {
    assert_eq!(hexwords(2, 8, 8).len(), 1463);
}

#[test]
fn test_ex2() {
    assert_eq!(hexwords(8, 8, 8).len(), 164);
}

#[test]
fn test_ex3() {
    assert_eq!(hexwords(2, 8, 0).len(), 45);
}

#[test]
fn test_ex4() {
    assert_eq!(hexwords(2, 8, 1).len(), 244);
}

#[test]
fn test_ex5() {
    assert_eq!(combiwords(hexwords(4, 4, 0), 8).len(), 144);
}

#[test]
fn test_ex6() {
    assert_eq!(combiwords(hexwords(3, 5, 0), 8).len(), 274);
}

fn hexwords(lo: usize, hi: usize, sb: usize) -> Vec<String> {
    let mut out: Vec<String> = Vec::new();
    let file = File::open("dictionary.txt").unwrap();
    let reader = BufReader::new(file);
    for lx in reader.lines() {
        let line = lx.unwrap();
        if line.len() >= lo && line.len() <= hi {
            let mut valid = true;
            let mut sbc = 0;
            for c in line.chars() {
                if c == 'o' || c == 'i' || c == 'l' || c == 's' || c == 't' {
                    sbc += 1;
                    if sbc > sb {
                        valid = false;
                    }
                } else if c < 'a' || c > 'f' {
                    valid = false;
                }
                if !valid {
                    break;
                }
            }
            if valid {
                out.push(line);
            }
        }
    }
    out
}

fn combiwords(wl: Vec<String>, l: usize) -> Vec<String> {
    let mut wh: HashMap<usize, Vec<String>> = HashMap::new();
    for w in wl {
        let en = wh.entry(w.len()).or_insert(Vec::new());
        (*en).push(w);
    }
    let mut tmap: Vec<Vec<usize>> = vec![Vec::new()];
    let mut omap: Vec<Vec<usize>> = Vec::new();
    while tmap.len() > 0 {
        let mut c = tmap.pop().unwrap();
        let s = &c.iter().sum::<usize>();
        let ls = l - s;
        for j in 1..ls {
            if wh.contains_key(&j) {
                let mut cc = c.clone();
                cc.push(j);
                tmap.push(cc);
            }
        }
        if wh.contains_key(&ls) {
            c.push(ls);
            omap.push(c);
        }
    }
    let mut out: Vec<String> = Vec::new();
    for pat in omap {
        for ss in pat.iter().map(|i| &wh[i]).multi_cartesian_product() {
            out.push(ss.iter().join(""));
        }
    }
    out
}
