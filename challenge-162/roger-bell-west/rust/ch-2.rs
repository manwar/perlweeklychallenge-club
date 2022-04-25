#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::{HashMap, HashSet};

#[test]
fn test_ex1() {
    assert_eq!(
        encrypt("playfair example", "hide the gold in the tree stump"),
        "bmodzbxdnabekudmuixmmouvif"
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        decrypt("perl and raku", "siderwrdulfipaarkcrw"),
        "thewexeklychallengex"
    );
}

fn encrypt(kw: &str, plaintext: &str) -> String {
    playfair(1, kw, plaintext)
}

fn decrypt(kw: &str, ciphertext: &str) -> String {
    playfair(-1, kw, ciphertext)
}

fn posmod(a: isize, b: isize) -> usize {
    let mut m = a % b;
    while m < 0 {
        m += b;
    }
    m as usize
}

fn stripnonalpha(src: &str) -> String {
    let mut out: String = String::new();
    for c in src.chars() {
        match c {
            'j' => out.push('i'),
            'a'..='z' => out.push(c),
            'Z'..='Z' => out.push(c.to_lowercase().nth(0).unwrap()),
            _ => (),
        }
    }
    out
}

fn playfair(dir: isize, kwi0: &str, input: &str) -> String {
    let mut kw: Vec<char> = Vec::new();
    let mut k: HashSet<char> = HashSet::new();
    for c in (stripnonalpha(kwi0)
        + &stripnonalpha(&('a'..='z').collect::<String>()))
        .chars()
    {
        if !k.contains(&c) {
            kw.push(c);
            k.insert(c);
        }
    }
    let mut grid: Vec<Vec<char>> = Vec::new();
    let mut gc: HashMap<char, (usize, usize)> = HashMap::new();
    let mut index = 0;
    for row in 0..=4 {
        let mut r: Vec<char> = Vec::new();
        for column in 0..=4 {
            r.push(kw[index]);
            gc.insert(kw[index], (row, column));
            index += 1;
        }
        grid.push(r);
    }
    let ii = stripnonalpha(input).chars().collect::<Vec<char>>();
    index = 0;
    let mut out: String = String::new();
    while index < ii.len() {
        let ca = ii[index];
        let mut cb = 'x';
        if index + 1 < ii.len() {
            cb = ii[index + 1];
        }
        index += 2;
        if ca == cb {
            cb = 'x';
            index -= 1;
        }
        let (car, cac) = *gc.get(&ca).unwrap();
        let (cbr, cbc) = *gc.get(&cb).unwrap();
        let (mut oar, mut oac, mut obr, mut obc) = (car, cac, cbr, cbc);
        if car == cbr {
            oac = posmod(cac as isize + dir, 5);
            obc = posmod(cbc as isize + dir, 5);
        } else if cac == cbc {
            oar = posmod(car as isize + dir, 5);
            obr = posmod(cbr as isize + dir, 5);
        } else {
            oac = cbc;
            obc = cac;
        }
        out.push(grid[oar][oac]);
        out.push(grid[obr][obc]);
    }
    out
}
