fn double_me (ints :&Vec<i32>, start :&mut i32) -> i32 {
    let mut flag = true;
    while flag {
	flag = false;
	for i in ints {
	    if i == start {
		flag = true;
		*start *= 2;
	    }
	}
    }
    return *start;
}

fn main() {
    let ints = vec![5, 3, 6, 1, 12];
    let mut start = 3;
    println!("Input: ints = {:?}, start = {start}", ints);
    println!("Output: {}", double_me(&ints, &mut start));
}

