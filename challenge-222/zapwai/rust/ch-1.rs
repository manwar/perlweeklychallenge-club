fn main() {
    let ints1 = vec![1, 1, 4, 2, 1, 3];
    let ints2 = vec![5, 1, 2, 3, 4];
    let ints3 = vec![1, 2, 3, 4, 5];

    let input_arrays = vec![ints1, ints2, ints3];

    for ints in input_arrays {
        let mut copy = ints.to_vec();

        copy.sort();

        let cnt = ints.iter().zip(copy.iter()).filter(|(&a, &b)| a == b).count();

        println!("Input: {:?}", ints);
        println!("Sorted: {:?}", copy);
        println!("Count: {}", cnt);
    }
}
