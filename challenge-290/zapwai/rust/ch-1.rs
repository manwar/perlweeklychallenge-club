fn main() {
    let ints = vec![6, 2, 3, 3];
    proc(ints);
    let ints2 = vec![3, 1, 4, 13];
    proc(ints2);
    let ints3 = vec![2, 1, 4, 2];
    proc(ints3);
}

fn proc(ints : Vec<i32>) {
    println!( "Input: ints = {:?}", ints);
    let mut ans = "false";
    for i in 0 .. ints.len() - 1 {
	for j in i + 1 .. ints.len() {
	    if ints[i] == 2 * ints[j] || ints[j] == 2 * ints[i] {
		ans = "true";
	    }
	}
    }
    println!( "Output: {ans}");
}

