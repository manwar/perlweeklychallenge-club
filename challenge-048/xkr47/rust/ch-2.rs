use chrono::prelude::*;
use std::iter::FromIterator;

fn main() {
    let dates: Vec<String> = (2000..=2999)
        .map(|y| {
            let ys = y.to_string();
            let revchars: Vec<char> = ys.chars().rev().collect();
            let m = String::from_iter(&revchars[0..2]).parse::<u32>().unwrap();
            let d = String::from_iter(&revchars[2..4]).parse::<u32>().unwrap();
            chrono::Utc.ymd_opt(y, m, d)
        })
        .flat_map(|date| date.earliest())
        .map(|date| format!("{}", date.format("%m%d%Y")))
        .collect();

    println!("{:?}", dates);
}
