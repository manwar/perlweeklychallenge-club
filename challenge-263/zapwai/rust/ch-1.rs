fn main() {
    let mut ints1 = vec![1, 5, 3, 2, 4, 2]; let k1 = 2;
    let mut ints2 = vec![1, 2, 4, 3, 5]; let k2 = 6;
    let mut ints3 = vec![5, 3, 2, 4, 2, 1]; let k3 = 4;
    proc(k1, ints1);
    proc(k2, ints2);
    proc(k3, ints3);
}

fn proc(k :i32, mut ints :Vec<i32>) {
    println!("Input: {:?}", ints);
    ints.sort();
    let mut ind : Vec<i32> = Vec::new();
    for i in 0 .. ints.len() {
	if ints[i] == k {
	    ind.push(i as i32)
	}
    }
    println!("Output: {:?}", ind);
}
