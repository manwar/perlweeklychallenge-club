use std::collections::HashMap;

fn find_highest_lucky_num(ints: &[i64]) -> i64 {
    let mut counts = HashMap::new();

    for i in ints {
        *counts.entry(*i).or_insert(0) += 1;
    }

    let luckies = counts.iter().filter(|t| t.0 == t.1).map(|t| t.0);
    match luckies.max() {
        Some(x) => *x,
        None => -1,
    }
}

fn main() {
    let inputs = vec![vec![2, 2, 3, 4], vec![1, 2, 2, 3, 3, 3], vec![1, 1, 1, 3]];

    for input in &inputs {
        let lucky_num = find_highest_lucky_num(input);
        println!("{:?}  => {}", input, lucky_num);
    }
}
