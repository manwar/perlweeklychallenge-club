fn count_change(s: &str) -> u32 {
    if s.len() < 2 {
        return 0;
    }

    let mut count = 0;
    let binding = s.to_lowercase();
    let mut chars = binding.as_str().chars();
    let mut last = chars.next().unwrap();
    for current in chars {
        if last != current {
            count += 1;
        }
        last = current;
    }
    count
}

fn main() {
    let inputs = ["pPeERrLl", "rRr", "GoO", "gooooo", "goOOood"];
    for str in inputs {
        let changes = count_change(&str);
        println!("{} => {}", str, changes);
    }
}
