use rand::seq::SliceRandom;
use rand::thread_rng;
use regex::Captures;
use regex::Regex;
use std::io::{self, BufRead, BufReader};

fn jumble(a: &str) -> String {
    let mut p = a.chars().collect::<Vec<_>>();
    p.shuffle(&mut thread_rng());
    p.into_iter().collect()
}

fn main() {
    let reader = BufReader::new(io::stdin());
    let wordre =
        Regex::new(r"([A-Za-z])([A-Za-z][A-Za-z]+)([A-Za-z])").unwrap();
    for l in reader.lines() {
        let line = l.unwrap();
        let result = wordre.replace_all(&line, |caps: &Captures| {
            format!("{}{}{}", &caps[1], jumble(&caps[2]), &caps[3])
        });
        println!("{}", result);
    }
}
