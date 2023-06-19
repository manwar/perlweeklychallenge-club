use rand::Rng;
fn main() {
    let mut ints = vec![2, 7, 4, 1, 8, 1];
    println!("Input: {:?}", ints);
    if ints.len() > 1 {
	loop {
	    let n1 = rand::thread_rng().gen_range(0..ints.len());
	    let x :i32  = ints.splice(n1..n1+1,vec![]).next().unwrap();
	    let n2 = rand::thread_rng().gen_range(0..ints.len());
	    let y :i32  = ints.splice(n2..n2+1,vec![]).next().unwrap();	
	    ints.push(y-x);
	    let mut spaces = 0;
	    if x < 0 { spaces += 1; }
	    if y < 0 { spaces += 1; }
	    if y-x < 0 { spaces += 1; }
	    if x.abs() > 9 { spaces += 1; }
	    if y.abs() > 9 { spaces += 1; }
	    if (y-x).abs() > 9 { spaces += 1; }
	    loop {
		print!(" ");
		if spaces == 0 { break; }
		spaces -= 1;
	    }
	    println!("\t{x},{y} --> {:?}", ints);
	    if ints.len() == 1 { break; }
	}
    }
    println!("Output: {}", ints[0]);
}
