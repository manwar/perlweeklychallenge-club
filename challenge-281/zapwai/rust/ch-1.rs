fn main() {
    let coord = "d3";
    proc(coord);
    let coord2 = "g5";
    proc(coord2);
    let coord3 = "e6";
    proc(coord3);
}

fn proc(coord : &str) {
    println!("Input: {coord}");
    let l = coord.chars().nth(0).unwrap();
    let n = coord.chars().nth(1).unwrap() as i32;
    if l == 'a' || l == 'c' || l == 'e' || l == 'g' {
	if n % 2 == 0 {
	    println!("Output: True");
	} else {
	    println!("Output: False");
	}
    } else {
	if n % 2 == 1 {
	    println!("Output: True");
	} else {
	    println!("Output: False");
	}
    }
}
