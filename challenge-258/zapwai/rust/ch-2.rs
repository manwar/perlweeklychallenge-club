fn proc(k : i32, ints : Vec<i32>) {
    println!("Input: {:?}, k = {k}", ints);
    let mut sum = 0;
    let mut ind = Vec::new();
    for i in 0 .. ints.len() {
	let mut tally = 0;
	let s = format!("{:b}", i);
	for c in s.to_string().chars() {
	    if c == '1' {
		tally += 1;
	    }
	}
	if tally == k {
	    ind.push(i);
	}
    }
    for i in ind {
	sum += ints[i];
    }
    println!("Output: {sum}");
}

fn main() {
    let ints1 = vec![2, 5, 9, 11, 3]; let k1 = 1;
    let ints2 = vec![2, 5, 9, 11, 3]; let k2 = 2;
    let ints3 = vec![2, 5, 9, 11, 3]; let k3 = 0;
    proc(k1, ints1);
    proc(k2, ints2);
    proc(k3, ints3);
}
