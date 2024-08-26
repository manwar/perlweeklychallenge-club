fn main() {
    let ints = vec![2, 2, 3, 4];
    proc(ints);
    let ints2 = vec![1, 2, 2, 3, 3, 3];
    proc(ints2);
    let ints3 = vec![1, 1, 1, 3];
    proc(ints3);
}
fn proc(ints :Vec<i32>) {
    println!("Input: ints = {:?}", ints);
    let mut lucky : i32 = -1;
    let mut freq = vec![0];
    for _j in 0 .. 1 + ints.iter().max().unwrap() {
	freq.push(0);
    }
    for item in ints {
	freq[item as usize] += 1;
    }
    for i in 1 .. freq.len() {
	if i == freq[i] {
	    lucky = i as i32;
	}
    }
    println!("Output: {lucky}");
}
