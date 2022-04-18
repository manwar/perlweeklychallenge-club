use rand::prelude::*;
use std::collections::HashMap;
use std::io::{self, BufRead, BufReader};

fn main() {
    let mut rng = thread_rng();
    let mut f: HashMap<String, usize> = HashMap::new();
    let mut r: HashMap<usize, String> = HashMap::new();
    let reader = BufReader::new(io::stdin());
    for line in reader.lines() {
        let line = line.unwrap();
        let mut b = 1;
        let mut v: usize = 0;
        for l in 'a'..='z' {
            if line.contains(l) {
                v |= b;
            }
            b <<= 1;
        }
        if !r.contains_key(&v) || r.get(&v).unwrap().len() > line.len() {
            f.insert(line.clone(), v);
            r.insert(v, line);
        }
    }

    let mut w: Vec<String> = Vec::new();
    let lt = (1 << 26) - 1;
    let mut lu: Vec<usize> = vec![0];
    while *lu.last().unwrap() != lt {
        let mut wn: String = "".to_string();
        if w.len() > 0 {
            let mut mode = 0;
            let mut sc: Vec<String> = Vec::new();
            for wv in r.keys() {
                if (wv & lu.last().unwrap()) == 0 {
                    if mode == 0 {
                        mode = 1;
                        sc = Vec::new();
                    }
                    sc.push(r.get(wv).unwrap().to_string());
                } else if mode == 0
                    && (wv | lu.last().unwrap()) != *lu.last().unwrap()
                {
                    sc.push(r.get(wv).unwrap().to_string());
                }
            }
            if sc.len() == 0 {
                w.pop();
                lu.pop();
            } else {
                wn = sc[rng.gen_range(0..sc.len())].clone();
            }
        } else {
            let x: usize = thread_rng().gen_range(0..f.len());
            wn = f.keys().skip(x).next().unwrap().clone();
        }
        if wn.len() > 0 {
            w.push(wn.clone());
            lu.push(lu.last().unwrap() | f.get(&wn).unwrap());
        }
    }
    println!("{}", w.join(" "));
}
