use std::io;
use rand::Rng;
fn getopt() -> char {
    println!("Perl Weekly Challenge #222");
    println!("Enter a selection method: (b)iggest, (s)mallest, (r)andom, sh(i)ft, (p)op");
    let mut entry = String::new();
    io::stdin()
	.read_line(&mut entry)
	.expect("read-line-error");
    let response = entry.chars().nth(0).unwrap();
    return response;
}
fn select(opt : char, ints : &Vec<i32>) -> usize {
    if opt == 'r' {return rand::thread_rng().gen_range(0..ints.len());}
    else if opt == 'i' {return 0;}
    else if opt == 'p' {return ints.len() - 1;}
    else if opt == 'b' {
	let mut max = -1000;
	let mut index = 0;
	for (i, v) in ints.iter().enumerate() {
	    if max < *v {
		max = *v;
		index = i;
	    }
	}
	return index;
    }
    else if opt == 's' {
	let mut min = 1000;
	let mut index = 0;
	for (i, v) in ints.iter().enumerate() {
	    if min > *v {
		min = *v;
		index = i;
	    }
	}
	return index;
    }
    else { return 0; }
}
fn main() {
    let opt = getopt();
    let mut ints = vec![2, 7, 4, 1, 8, 1];
    println!("Input: {:?}", ints);
    if ints.len() > 1 {
	loop {
	    let n1 = select(opt, &ints);
	    let x :i32  = ints.splice(n1..n1+1,vec![]).next().unwrap();
	    let n2 = select(opt, &ints);
	    let y :i32  = ints.splice(n2..n2+1,vec![]).next().unwrap();
	    if y != x {
		ints.push(y-x);
	    }
	    let mut spaces = 4;
	    if x < 0 { spaces -= 1; }
	    if y < 0 { spaces -= 1; }
	    if x.abs() > 9 { spaces -= 1; }
	    if y.abs() > 9 { spaces -= 1; }
	    loop {
		print!(" ");
		if spaces == 0 { break; }
		spaces -= 1;
	    }
	    println!("{x},{y} --> {:?}", ints);
	    if ints.len() == 1 { break; }
	}
    }
    println!("Output: {}", ints[0]);
}
