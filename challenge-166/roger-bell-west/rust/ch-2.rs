#! /bin/sh
//usr/bin/env rustc $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::cmp::max;
use std::collections::{HashMap, HashSet};
use std::fs;

fn kdd(dirlist0: Vec<String>) -> Vec<Vec<String>> {
    let mut dirlist = dirlist0;
    dirlist.sort();
    let mut fx: HashMap<String, HashSet<String>> = HashMap::new();
    for d in &dirlist {
        for e in fs::read_dir(&d).unwrap() {
            let entry = e.unwrap();
            let mut nn = entry.file_name().to_string_lossy().to_string();
            if entry.file_type().unwrap().is_dir() {
                nn.push('/');
            }
            let en = fx.entry(nn).or_insert(HashSet::new());
            (*en).insert(d.clone());
        }
    }
    let mm = (&dirlist).len();
    let mut out: Vec<Vec<String>> = vec![dirlist.clone()];
    let mut ff = fx.keys().map(|i| format!("{}", i)).collect::<Vec<String>>();
    ff.sort();
    for f in ff {
        if fx.get(&f).unwrap().len() != mm {
            let mut l: Vec<String> = Vec::new();
            for d in &dirlist {
                if fx.get(&f).unwrap().contains(d) {
                    l.push((*f).to_string());
                } else {
                    l.push("".to_string());
                }
            }
            out.push(l);
        }
    }
    out
}

fn strpad(x: &String, width: usize) -> String {
    let mut y = x.clone();
    while y.len() < width {
        y.push(' ');
    }
    return y;
}

fn tabular(d: Vec<Vec<String>>) {
    let mut columnlength = vec![0; d[0].len()];
    for row in &d {
        for (i, col) in row.iter().enumerate() {
            columnlength[i] = max(columnlength[i], col.len());
        }
    }
    for row in &d {
        for (i, col) in row.iter().enumerate() {
            if i > 0 {
                print!(" | ")
            }
            print!("{}", strpad(col, columnlength[i]));
        }
        println!("");
    }
}

fn main() {
    tabular(kdd(vec![
        "dir_a".to_string(),
        "dir_b".to_string(),
        "dir_c".to_string(),
    ]));
}
