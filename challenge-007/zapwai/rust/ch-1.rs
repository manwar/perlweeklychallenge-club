fn main() {
    niven(51);
}

fn niven(n :i32) {
    for i in 1 ..= n {
	let mut num = i;
	let mut tally = 0;
	while num > 0 {
	    tally += num % 10;
	    num /= 10;
	}
	if i % tally == 0 {println!("{}", i);}
    }
}
