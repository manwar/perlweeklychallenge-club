use std::collections::HashSet;

fn is_palindrome (instr : &str) -> bool {
    return instr == instr.chars().rev().collect::<String>()
}

fn find_palindromes (input : &str) {
    print!("{}: ", input);
    let mut seen = HashSet::new();
    for start in 0..input.len() {
        for endstr in start+1..=input.len() {
            let cand = &input[start .. endstr];
            if is_palindrome(&cand) && !seen.contains(&cand) {
                print!("{} ", cand);
                seen.insert(cand);
            }
        }
    }
    println!(" ");
}

fn main () {
    let tests = vec!["redivider", "rotors", "challenge"];
    for test in tests.into_iter() {
        find_palindromes(test);
    }
}
