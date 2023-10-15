use std::env;

fn running_sum(array: &Vec<i32>) -> Vec<i32> {
    let mut sum = Vec::new();
    sum.push(array[0]);

    for i in 1..array.len() {
        sum.push(array[i] + sum[i - 1]);
    }

    sum
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_running_sum() {
        let test_cases = vec![
            (vec![1, 2, 3, 4, 5], vec![1, 3, 6, 10, 15]),
            (vec![1, 1, 1, 1, 1], vec![1, 2, 3, 4, 5]),
            (vec![0, -1, 1, 2], vec![0, -1, 0, 2]),
        ];

        for (input, want) in test_cases {
            let got = running_sum(&input);
            assert_eq!(got, want);
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
    let out_vec: Vec<i32> = running_sum(&in_vec);
    println!("      Input: {:?}", in_vec);
    println!("Running Sum: {:?}", out_vec);
}
