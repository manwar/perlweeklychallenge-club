fn digits_sum(ints :&Vec<i32>) -> i32 {
    let mut sum = 0;
    for i in 0 .. ints.len() {
	let mut val = ints[i];
	while val != 0 {
	    sum += val % 10;
	    val /= 10;
	}
    }
    return sum;
}

fn sum(ints :&Vec<i32>) -> i32 {
    let mut sum = 0;
    for i in 0 .. ints.len() {
	sum += ints[i];
    }
    return sum;
}

fn main() {
    let ints = vec![1,2,3,45];
    println!("Input: ints = {:?}", ints);
    let value = sum(&ints) - digits_sum(&ints);
    println!("Output: {}", value.abs());
}
