fn main() {
    let hours = vec![12, 12, 30, 24, 24];
    proc(hours);
    let hours2 = vec![72, 48, 24, 5];
    proc(hours2);
    let hours3 = vec![12, 18, 24];
    proc(hours3);
}

fn proc(hours : Vec<i32>) {
    println!( "Input: {:?}", hours);
    let mut tally = 0;
    for i in 0 .. hours.len() - 1 {
	for j in i + 1 .. hours.len() {
	    let sum = hours[i] + hours[j];
	    if sum % 24 == 0 {
		tally += 1;
	    }
	}
    }
    println!( "Output: {tally}" );
}
