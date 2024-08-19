fn main() {
    let ints = vec![3, 3, 1];
    proc(ints);
    let ints2 = vec![3, 2, 4, 2, 4];
    proc(ints2);
    let ints3 = vec![1];
    proc(ints3);
}

fn proc(ints :Vec<i32>) {
    println!( "Input: ints = {:?}", ints);
    let mut num = 0;
    for i in 0..ints.len() {
	let mut found = 0;
	let elem = ints[i];
	for j in 0..ints.len() {
	    if i == j {
		continue;
	    }
	    let new_elem = ints[j];
	    if elem == new_elem {
		found = 1;
	    }
	}
	if found == 0 {
	    num = elem;
	    break;
	}
    }
    println!("Output: {num}");
}
