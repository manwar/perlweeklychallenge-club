fn main() {
    let v = vec![1,2,3,4];
    let v2 = vec![2,7,1,19,18,3];
    proc(v);
    proc(v2);    
}

fn proc(v : Vec<i32>) {
    let mut s = Vec::new();
    println!("Input: ints = {:?}", v);
    let n = v.len();
    for k in 1 ..= n {
	if n % k == 0 {
	   s.push(v[k-1]);
	}
    }
    let mut sum = 0;
    for val in s.iter() {
	sum += val*val;
    }
    println!("Output: {sum}");
}