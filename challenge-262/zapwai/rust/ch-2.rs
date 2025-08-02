fn main() {
    let ints = vec![3, 1, 2, 2, 2, 1, 3];
    let k = 2;
    println!("Input: ints = {:?}, k = {k}", ints);
    let mut cnt = 0;
    for i in 0 .. ints.len() - 1 {
	for j in i + 1 .. ints.len() {
	    if ints[i] != ints[j] {
		continue;
	    }
	    if i * j % k == 0 {
		cnt += 1;
	    }
	}
    }
    println!("Output: {cnt}");
}
