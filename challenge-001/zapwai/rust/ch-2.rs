fn main() {
    for i in 0 .. 21 {
	let mut flag = true;
	if i % 3 == 0 {
	    flag = false;
	    print!("fizz");
	}
	if i % 5 == 0 {
	    flag = false;
	    print!("buzz");
	}
	if flag {
	    print!("{i}");
	}
	println!();
    }
}
