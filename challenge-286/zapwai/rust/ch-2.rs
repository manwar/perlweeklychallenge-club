use std::cmp::{max, min};

fn main() {
    let mut ints = vec![2, 1, 4, 5, 6, 3, 0, 2];
    proc(ints);
    let ints2 = vec![0, 5, 3, 2];
    proc(ints2);
    let ints3 = vec![9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8];
    proc(ints3);
}

fn proc(mut ints : Vec<i32>) {
    println!("Input: ints = {:?}", ints);
    while ints.len() > 2 {
	let mut l : Vec<i32> = Vec::new();
	for i in 0 .. ints.len()/2 {
	    if i % 2 == 0 {
		l.push(min(ints[2*i], ints[2*i + 1]));
	    } else {
		l.push(max(ints[2*i], ints[2*i + 1]));
	    }
	}
	ints = l;
    }
    println!("Output: {}",  ints.iter().min().unwrap());
}
