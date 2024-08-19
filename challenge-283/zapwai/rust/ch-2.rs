fn main() {
    let ints :Vec<i32> = vec![1, 2, 1, 0];
    proc(ints);
    let ints2 :Vec<i32> = vec![0, 3, 0];
    proc(ints2);
}

fn proc(ints : Vec<i32>) {
    println!("Input: ints = {:?}", ints);
    let mut veracity = "true";
    for i in 0 .. ints.len() {
	let freq = ints[i];
	let mut cnt = 0;
	for elem in &ints {
	    if *elem as usize == i {
		cnt += 1;
	    }
	}
	if cnt != freq {
	    veracity = "false";
	    break;
	}
    }
    println!("Output: {veracity}");
}
