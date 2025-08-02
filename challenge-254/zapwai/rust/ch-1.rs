fn main() {
    for n in [27, 0, 6] {
	println!("Input: {}\nOutput: {}", n, proc(n));
    }
}

fn proc(n : i32) -> bool {
    if n < 3 {return false;}
    for i in 1 .. {
	if n % i32::pow(3,i) != 0 {
	   if n / i32::pow(3,i-1) == 1 {
		return true;
	   } else {
		return false;
	   }
	}
    }
    return true;
}