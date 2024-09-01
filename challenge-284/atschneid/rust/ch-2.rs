use std::collections::HashMap;

fn relative_sort(list1: &[i64], list2: &[i64]) -> std::vec::Vec<i64> {
    let mut ordering = HashMap::new();

    for (idx, val) in list2.iter().enumerate() {
        ordering.insert(val, idx);
    }

    let mut prefix: Vec<&i64> = list1.iter().filter(|e| ordering.contains_key(e)).collect();
    prefix.sort_by(|a, b| ordering[a].cmp(&ordering[b]));

    let mut suffix: Vec<&i64> = list1.iter().filter(|e| !ordering.contains_key(e)).collect();
    suffix.sort();

    prefix.append(&mut suffix);
    prefix.into_iter().map(|r| *r).collect()
}

fn main() {
    // let inputs = vec![vec![2, 2, 3, 4], vec![1, 2, 2, 3, 3, 3], vec![1, 1, 1, 3]];

    // for input in &inputs {
    // 	let lucky_num = find_highest_lucky_num( input );
    // 	println!("{:?}  => {}", input, lucky_num);
    // }
    let list1 = vec![1, 2, 3, 4, 6, 7, 11, 8];
    let list2 = vec![5, 4, 3, 2];
    let sorted = relative_sort(&list1, &list2);
    println!("{:?}, {:?} => {:?}", list1, list2, sorted);
}
