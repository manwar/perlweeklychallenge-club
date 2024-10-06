fn main() {
    let ints = vec![5, 6, 4, 1];
    proc(ints);
    let ints2 = vec![4, 5];
    proc(ints2);
    let ints3 = vec![1, 2, 2, 3];
    proc(ints3);
}

fn proc(ints : Vec<i32>) {
    println!("Input: {:?}", ints);
    let mut ans = ints.iter().max().unwrap();
    let mut new1 : Vec<i32> = Vec::new();
    for i in 0 .. ints.len() {
	if ints[i] != *ans {
	    new1.push(ints[i]);
	}
    }
    let mut new2 : Vec<i32> = Vec::new();
    if new1.len() > 0 {
	let m2 = new1.iter().max().unwrap();
	for i in 0 .. new1.len() {
	    if new1[i] != *m2 {
		new2.push(new1[i]);
	    }
	}
	if new2.len() > 0 {
	    ans = new2.iter().max().unwrap();
	}
    }
    println!( "Output: {ans}");
}
