fn splittable_string(s: &str) -> bool {
    let mut counter: u32 = 0;
    let vowels: Vec<char> = "AEIOUaeiou".chars().collect();
    for c in s.chars() {
        if vowels.contains(&c) {
            counter = (counter + 1) % 2;
        }
    }
    counter == 0
}

fn main() {
    let inputs = [
        "perl",
        "book",
        "good morning",
        "hello",
        "heloOlo",
        "heloeOlo",
    ];
    for input in inputs.iter() {
        println!("{} => {}", input, splittable_string(input));
    }
}
