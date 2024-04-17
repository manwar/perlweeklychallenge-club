fn main() {
    let ints = vec![1,2,3,3,3,3,4,2];
    let ints2 = vec![1,1];
    let ints3 = vec![1,2,3];
    proc(ints);
    proc(ints2);
    proc(ints3);
}

fn proc(ints : Vec<i32>) {
    println!("Input: ints = {:?}", ints);
    let third : f32 = ints.len() as f32 / 3.0;
    let mut freq : Vec<i32> = vec![0,0,0,0,0];
    for i in ints {
	freq[i as usize] += 1;
    }
    let mut ans : Vec<i32> = Vec::new();
    for val in 0 .. freq.len() {
	if freq[val] as f32 >= third {
	    ans.push(val as i32);
	}
    }
    ans.sort();
    println!("Output: {}", ans[0]);
}
