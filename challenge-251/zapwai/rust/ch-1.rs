fn main() {
    let ints = vec![6, 12, 25, 1];
    let ints2 = vec![10, 7, 31, 5, 2, 2];
    let ints3 = vec![1, 2, 10];
    proc(ints);
    proc(ints2);
    proc(ints3);    
}

fn proc (mut ints : Vec<i32>) {
    println!("Input: ints = {:?}", ints);
    let mut sum = 0;
    while ints.len() > 1
    {
	let a = ints.remove(0);
	let b = ints.pop().unwrap();
	let x = format!("{:?}{:?}",a,b);
	sum += x.parse::<i32>().unwrap();
	
    }
    if ints.len() == 1 {
	sum += ints[0];
    }
    println!("Output: {sum}");
}
