fn proc(ints :&Vec<i32>) {
    let mut cnts = vec![0; ints.len()];
    for i in 0..ints.len() { cnts[i] = 0; }
    for i in 0..ints.len() {
	for j in 0..ints.len() {
	    if ints[i] > ints[j] {
		cnts[i] += 1;
	    }
	}
    }
    println!("Input : ints = {:?}", ints);
    println!("Output: cnts = {:?}", cnts);
}

fn main() {
    let ints = vec![5, 2, 1, 6];
    proc(&ints);
    let ints2 = vec![2, 1, 0, 3];
    proc(&ints2);
    let ints3 = vec![0, 1];
    proc(&ints3);
}
