#! /bin/sh
//usr/bin/env rustc $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::io::{self, BufRead, BufReader};

fn median(s0: Vec<f64>) -> f64 {
    let mut s = s0;
    s.sort_by(|a, b| a.partial_cmp(b).unwrap());
    s[s.len() / 2]
}

fn main() {
    let mut points: Vec<Vec<f64>> = Vec::new();
    let reader = BufReader::new(io::stdin());
    for line in reader.lines() {
        let line = line.unwrap();
        for phrase in line.split_whitespace() {
            if phrase.len() > 0 {
                println!("{}", phrase);
                let f = phrase
                    .split(',')
                    .filter_map(|i| i.parse::<f64>().ok())
                    .collect::<Vec<f64>>();
                points.push(f);
            }
        }
    }

    let mut slope: Vec<f64> = Vec::new();
    for i in 0..points.len() - 1 {
        for j in i + 1..points.len() {
            if points[i][0] != points[j][0] {
                slope.push(
                    (points[j][1] - points[i][1])
                        / (points[j][0] - points[i][0]),
                );
            }
        }
    }
    let m = median(slope);
    let c =
        median(points.iter().map(|i| i[1] - m * i[0]).collect::<Vec<f64>>());

    let mut x = points.iter().map(|i| i[0]).collect::<Vec<f64>>();
    x.sort_by(|a, b| a.partial_cmp(b).unwrap());
    let mut l = Vec::new();
    for xb in vec![x[0], x[x.len() - 1]] {
        l.push(xb);
        l.push(xb * m + c);
    }
    println!(
        "{}",
        l.iter().map(|i| format!("{}", i)).collect::<Vec<_>>().join(",")
    );
}
