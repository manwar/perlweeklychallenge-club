fn main() {
    let s = "17893729974";
    proc(s);
    let s2 = "4137 8947 1175 5904";
    proc(s2);
    let s3 = "4137 8974 1175 5904";
    proc(s3);
}

fn proc(s : &str) {
    println!( "Input: {}", s);
    let mut digit :Vec<u32> = s.chars()
	.filter(|c| c.is_digit(10))
	.map(|c| c.to_digit(10).unwrap())
	.collect();
    let payload = digit.pop().unwrap();
    digit.reverse();
    let mut sum = 0;
    for i in 0 .. digit.len() {
	if i % 2 == 0 {
	    let x = 2*digit[i];
	    if x > 9 {
		let a = x / 10;
		let b = x % 10;
		sum += a + b;
	    } else {
		sum += x;
	    }
	} else {
	    sum += digit[i];
	}
    }
    let mut ans = "false";
    if (sum + payload) % 10 == 0 {
	ans = "true";
    }
    println!("Output : {ans}");
}

