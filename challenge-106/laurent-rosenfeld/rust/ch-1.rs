fn main () {
    let mut test = vec![2, 9, 3, 5];
    test.sort();
    let gaps: Vec<i32> = (1..test.len()).map(|i| test[i] - test[i-1]).collect();
    println!("Max gap is: {:?}",  gaps.iter().max());
}
