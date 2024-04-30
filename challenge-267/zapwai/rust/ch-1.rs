fn main() {
    let ints = vec![-1, -2, -3, -4, 3, 2, 1];
    proc(ints);
    let ints2 = vec![1, 2, 0, -2, -1];
    proc(ints2);
    let ints3 = vec![-1, -1, 1, -1, 2];
    proc(ints3);
}

fn proc(ints : Vec<i32>) {
    println!("Input: ints = {:?}", ints);
    println!("Output: {}", sign_of_prod(ints));
}

fn sign_of_prod(ints : Vec<i32>) -> i32 {
    let mut num_of_negs = 0;
    for i in ints {
	if i < 0 {
	    num_of_negs += 1;
	} else if i == 0 {
	    return 0;
	}
    }
    if num_of_negs % 2 == 0 {
	return 1;
    } else {
	return -1;
    }
}
