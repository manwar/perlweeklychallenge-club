use std::cmp::min;
fn main() {
    let ints = vec![1, 2, 3, 4, 5];
    proc(ints);
    let ints2 = vec![5, 7, 1, 7];
    proc(ints2);
}

fn proc(ints : Vec<i32>) {
    println!("Input: {:?}", ints);
    let mut cnt = 0;
    for i in 0 .. ints.len() - 1 {
	for j in i + 1 .. ints.len() {
	    if ints[i] != ints[j] && (ints[i] - ints[j]).abs() < min(ints[i],ints[j]) {
		cnt += 1;
	    }
	}
    }
    println!("Output: {cnt}");
}
