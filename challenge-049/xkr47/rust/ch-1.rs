use std::env;
use regex::Regex;

fn main() {
    let multiplier = env::args().skip(1).next().expect("Please give multiplier as argument");
    let multiplier: u64 = multiplier.parse().expect("Bad multiplier specified as argument");
    let ones_and_zeroes = Regex::new(r"^[01]+$").unwrap();
    println!("{}",
             (1_u64..)
                 .map(|num| num * multiplier)
                 .filter(|num| ones_and_zeroes.is_match(&num.to_string()))
                 .next()
                 .unwrap());
}
