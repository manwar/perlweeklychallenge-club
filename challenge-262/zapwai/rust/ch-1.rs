fn main() {
    let ints = vec![-3, 1, 2, -1, 3, -2, 4];
    println!("Input: {:?}", ints);
    let mut neg : i32 = 0;
    let mut pos : i32 = 0;
    for i in 0 .. ints.len() {
	if ints[i] < 0 {
	    if neg > ints[i] { 
		neg = ints[i];
	    }
	} else {
	    if pos < ints[i] {
		pos = ints[i];
	    }
	}
    }
    let mut ans = 0;
    if neg.abs() > pos {
	ans = neg.abs();
    } else {
	ans = pos;
    }
    println!("Output: {ans}");
}
