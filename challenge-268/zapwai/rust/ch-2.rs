use std::collections::VecDeque;

fn main() {
    let ints = vec![2, 5, 3, 4];
    proc(ints);
}

fn proc(mut ints : Vec<i32>) {
    println!("Input: {:?}", ints);
    let mut new : Vec<i32> = Vec::new();
    ints.sort();
    let mut my_ints = VecDeque::new();
    for obj in ints {
	my_ints.push_back(obj);
    }
    while my_ints.len() > 0 {
	let x = my_ints.pop_front().unwrap();
	let y = my_ints.pop_front().unwrap();
	new.push(y);
	new.push(x);
    } 
    println!("Output: {:?}", new);
}
