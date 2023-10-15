use std::collections::HashMap;
use once_cell::sync::Lazy;
use std::sync::Mutex;
use std::env;

static DIGIT_WEIGHT: Lazy<Mutex<HashMap<i32, i32>>> = Lazy::new(|| {
    Mutex::new(HashMap::new())
});

fn calculate_digit_weight(num: i32) -> i32 {
    let mut cache = DIGIT_WEIGHT.lock().unwrap();

    if let Some(&cached) = cache.get(&num) {
        return cached;
    }

    let mut n = num;
    let mut count = 0;

    while n > 9 {
        count += 1;
        let mut tmp = 1;
        for digit in n.to_string().chars() {
            tmp *= digit.to_digit(10).unwrap() as i32;
        }
        n = tmp;
    }

    cache.insert(num, count);
    count
}

fn persistence_sort(array: &Vec<i32>) -> Vec<i32> {
    let mut sorted_array = array.clone();

    sorted_array.sort_by(|a, b| {
        let weight_a = calculate_digit_weight(*a);
        let weight_b = calculate_digit_weight(*b);

        if weight_a != weight_b {
            weight_a.cmp(&weight_b)
        } else {
            a.cmp(b)
        }
    });

    sorted_array
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_calculate_digit_weight() {
        assert_eq!(calculate_digit_weight(9), 0);
        assert_eq!(calculate_digit_weight(15), 1);
        assert_eq!(calculate_digit_weight(99), 2);
        assert_eq!(calculate_digit_weight(12347), 4);
    }

    #[test]
    fn test_persistence_sort() {
        let test_cases = vec![
            (vec![15, 99, 1, 34], vec![1, 15, 34, 99]),
            (vec![50, 25, 33, 22], vec![22, 33, 50, 25]),
            (vec![12347, 2347, 347, 47, 7], vec![7, 47, 347, 2347, 12347]),
        ];

        for (input, want) in test_cases {
            let output = persistence_sort(&input);
            assert_eq!(output, want);
        }
    }
}

fn main() {
    // Get command-line arguments, excluding the program name
    let args: Vec<String> = env::args().collect();

    // Create a Vec<i32> by parsing the command-line arguments
    let in_vec: Vec<i32> = args
        .iter()
        .skip(1) // Skip the first argument, which is the program name
        .filter_map(|arg| arg.parse().ok())
        .collect();

    // Print the resulting Vec<i32>
    let out_vec: Vec<i32> = persistence_sort(&in_vec);
    println!("      Input: {:?}", in_vec);
    println!("Running Sum: {:?}", out_vec);
}
