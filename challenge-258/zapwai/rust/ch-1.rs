fn main() {
    let ints = vec![10, 1, 111, 24, 1000];
    let ints2 = vec![111, 1, 11111];
    let ints3 = vec![2, 8, 1024, 256];
    proc(ints);
    proc(ints2);
    proc(ints3);
}

fn proc(ints : Vec<i32>) {
    let mut cnt = 0;
    for i in &ints {
	if i.to_string().len() % 2 == 0 {
	    cnt += 1;
	}
    }
    println!("Input: {:?}", ints);
    println!("Output: {cnt}");
}
