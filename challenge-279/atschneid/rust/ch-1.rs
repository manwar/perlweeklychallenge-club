fn sort_letters(letters: &[char], weights: &[u64]) -> String {
    if letters.len() != weights.len() {
        panic!("inputs must be same length")
    }

    let mut list_of_pairs: Vec<(&u64, &char)> = weights.iter().zip(letters.iter()).collect();
    list_of_pairs.sort_by_key(|k| k.0);
    list_of_pairs
        .iter()
        .map(|x| x.1.to_string())
        .collect::<Vec<String>>()
        .join("")
}

#[derive(Debug)]
struct Input {
    letters: Vec<char>,
    weights: Vec<u64>,
}

fn main() {
    let inputs = vec![
        Input {
            letters: vec!['R', 'E', 'P', 'L'],
            weights: vec![3, 2, 1, 4],
        },
        Input {
            letters: vec!['A', 'U', 'R', 'K'],
            weights: vec![2, 4, 1, 3],
        },
        Input {
            letters: vec!['O', 'H', 'Y', 'N', 'P', 'T'],
            weights: vec![5, 4, 2, 6, 1, 3],
        },
        Input {
            letters: vec!['O', 'H', 'Y', 'N', 'P', 'A', 'T'],
            weights: vec![5, 4, 2, 6, 1, 3, 3],
        },
    ];

    for input in inputs.iter() {
        let letters = &input.letters;
        let weights = &input.weights;
        let sorted = sort_letters(letters, weights);
        println!("{:?} :: {:?} => {}", letters, weights, sorted);
    }
}
