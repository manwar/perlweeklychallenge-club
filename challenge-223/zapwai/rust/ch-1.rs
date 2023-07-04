use std::env;

fn is_prime(num: i32) -> bool {
    if num <= 1 {
	return false;
    }

    let s = (num as f32).sqrt() as i32;

    for d in 2 ..= s {
	if num % d == 0 {
	    return false;
	}
    }
    true
}

fn fill(n: i32, list: &mut Vec<i32>) {
    for i in 2 ..= n {
	if is_prime(i) {
	    list.push(i);
	}
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() != 2 {
	println!("Please enter one value for n.");
	return;
    }
    let n : i32 = match args[1].parse() {
	Ok(num) => num,
	Err(_) => {
	    println!("Invalid Entry");
	    return;
	}
    };

    let mut list : Vec<i32> = vec![];
    fill(n, &mut list);
    
    println!("Input: n = {n}");
    println!("Output: {}", list.len());
    
    println!("{:?}", list);    
}
