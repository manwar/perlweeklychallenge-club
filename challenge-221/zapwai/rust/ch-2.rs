use std::convert::TryInto;

fn main() {
    let ints1 = vec![9, 4, 7, 2, 10];
    let ints2 = vec![3, 6, 9, 12];
    let ints3 = vec![20, 1, 15, 3, 10, 5, 8];
    find_long_subseq(&ints1);
    find_long_subseq(&ints2);
    find_long_subseq(&ints3);    
}

fn find_long_subseq(ints : &Vec<i32>) {
    let d = ints.len().try_into().unwrap();
    let e = d as usize;
    let mut max = 0;
    let mut win = Vec::new();
    for seed in 1 .. u32::pow(2, d) {
	let s = format!("{seed:0>e$b}");
	let b = s.split("");
	let mut bits = b.collect::<Vec<&str>>();
	bits.remove(0);
	bits.pop();
	let mut subseq = Vec::new();
	for i in 0 .. e {
	    if bits[i] == "1" {
		subseq.push(ints[i]);
	    }
	}
	if subseq.len() < 3 { continue }
	if is_arit(&subseq) {
	    if max < subseq.len() {
		max = subseq.len();
		win = subseq;
	    }
	}
    }

    println!("Input: @ints = {:?}", ints);
    println!("Output: {max}");
    println!("\t{:?}", win);    
}

fn is_arit (seq: &Vec<i32>) -> bool {
    let k = seq[1] - seq[0];
    for i in 2 .. seq.len() {
	let j = seq[i] - seq[i-1];
	if j != k {
	    return false;
	}
    }
    return true;
}
