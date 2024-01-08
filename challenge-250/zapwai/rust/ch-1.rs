fn main() {
    let v = vec![0,1,2];
    let v2 = vec![4,3,2,1];
    proc(v);
    proc(v2);    
}

fn proc(v :Vec<usize>) {
    println!("Input: ints = {:?}", v);
    let mut max :i32 = -1;
    for i in 0 .. v.len() {
	if i%10==v[i] {
	    max = i as i32;
	    break;
	}
    }
    println!("Output: {max}");
}
