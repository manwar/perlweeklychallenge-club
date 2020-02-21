use chrono::prelude::*;
use std::iter::FromIterator;

fn main() {
    let dates: Vec<String> = (2000..=2999)
        .map(|y| {
            let ys = y.to_string();
            let (m, d): (Vec<(usize, char)>, Vec<(usize, char)>) = ys.chars().rev().enumerate().partition(|(i, _)| *i < 2usize);
            let m = String::from_iter(m.iter().map(|(_, val)| val)).parse::<u32>().unwrap();
            let d = String::from_iter(d.iter().map(|(_, val)| val)).parse::<u32>().unwrap();
            chrono::Utc.ymd_opt(y, m, d)
        })
        .flat_map(|date| date.earliest())
        .map(|date| format!("{}", date.format("%m%d%y")))
        .collect();

    println!("{:?}", dates);
}
