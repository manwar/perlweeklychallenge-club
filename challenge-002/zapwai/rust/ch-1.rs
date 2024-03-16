fn main() {
    let x = "003407";
    let mut y = vec![];
    let mut on = false;
    for c in x.chars() {
	if c == '0' {
	    if on {
		y.push(c.to_string());
	    }
	} else {
	    on = true;
	    y.push(c.to_string());
	}
    }
    println!("Input: {x}");    
    println!("Output: {}", y.join(""));
}
