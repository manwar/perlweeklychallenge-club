fn main() {
    for n in [5, 7, 1] {
	proc(n);
    }
}
fn proc(n : i32) {   
    println!("Input: n = {n}");
    let mut v = Vec::new();
    if n%2 == 1 {
	v.push(0);
    }
    let k = n/2;
    for i in 1 ..= k {
	v.push(i);
	v.push(-i);
    }
    println!("Output: {:?}",v);
}