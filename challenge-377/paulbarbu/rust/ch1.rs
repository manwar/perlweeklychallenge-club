use std::collections::HashSet;
// Type your code here, or load an example.

// As of Rust 1.75, small functions are automatically
// marked as `#[inline]` so they will not show up in
// the output when compiling with optimisations. Use
// `#[unsafe(no_mangle)]` or `#[inline(never)]` to
// work around this issue.
// See https://github.com/compiler-explorer/compiler-explorer/issues/5939
#[unsafe(no_mangle)]
pub fn square(num: i32) -> i32 {
    num * num
}

fn reverse_existence(s: &str) -> bool
{

    if s.len() <= 2 {
        return false;
    }
    let rev = s.chars().rev().collect::<Vec<char>>();
    // println!("{:?}", end);
    for i in 0..s.len()-2 {
        // println!("{}",i);
        let candidate = s.chars().skip(i).take(2).collect::<Vec<char>>();

        for j in 0..s.len()-2 {
            let rev_candidate = rev.clone().into_iter().skip(j).take(2).collect::<Vec<char>>();
            // println!("{:?}",candidate);
            if rev_candidate == candidate {
                return true;
            }
        }
    }
    false
}

fn reverse_existence_better(s: &str) -> bool
{
    let str: Vec<char> = s.chars().collect();
    let mut seen : HashSet<[char;2]>= HashSet::new();
    for w in str.windows(2){
        let current = [w[0], w[1]];
        let rev = [w[1], w[0]];
        if seen.contains(&rev)
        {
            return true;

        }

        seen.insert(current);
    }
    return false;
}


// If you use `main()`, declare it as `pub` to see it in the output:
pub fn main() { 
    println!("{:?}",  reverse_existence_better("abcba"));
    println!("{:?}",  reverse_existence_better("racecar"));
    println!("{:?}",  reverse_existence_better("abcd"));
    println!("{:?}",  reverse_existence_better("banana"));
    println!("{:?}",  reverse_existence_better("hello"));
}

