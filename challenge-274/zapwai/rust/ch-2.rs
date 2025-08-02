fn main() {
    let r1 = vec![11, 23, 35, 47, 59];
    let r2 = vec![5, 20, 35, 50, 65];
    let length_one = 41;
    let length_two = 35;
    let mut out : Vec<i32> = Vec::new();
    for t in 1 .. 60 {
	let delta_one = delta(t, &r1);
	let delta_two = delta(t, &r2);
	let time_taken_one = length_one + delta_one;
	let time_taken_two = length_two + delta_two;
	if (delta_one < delta_two) && (time_taken_one > time_taken_two) {
	    out.push(t);
	}
    }
    println!("{:?}", out);
}

fn delta(t : i32, ran : &Vec<i32>) -> i32 {
    for r in ran {
	if r < &t {
	    continue;
	}
	return r - t;
    }
    return 0;
}
