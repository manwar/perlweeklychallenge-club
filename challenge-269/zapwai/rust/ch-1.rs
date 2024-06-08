fn main() {
    let ints = vec![1, 2, 3, 4, 5];
    let ints2 = vec![2, 3, 8, 16];
    let ints3 = vec![1, 3, 5, 7, 9];
    proc(ints);
    proc(ints2);
    proc(ints3);
}

fn truth(ints : Vec<i32>) -> bool {
    let N :u32 = ints.len() as u32;
    for i in 0 .. 2_i32.pow(N) - 1 {
	let d = format!("{:b}",i);
	let mut D : Vec<&str> = d.split("").collect();
	D.pop();
	D.reverse();
	D.pop();
	D.reverse();
	for _j in 0 .. N - (d.len() as u32) {
	    D.insert(0, "0");
	}
	let mut current_list : Vec<i32> = Vec::new();
	for j in 0 .. D.len() {
	    if "1" == D[j] {
		current_list.push(ints[j]);
	    }
	}
	
	if 1 >= current_list.len() {
	    continue;
	}
	let mut tally = 0;
	for c in &current_list {
	    tally = tally | c;
	}

	let x = format!("{:b}", tally);
	let last_bin_dig = x.chars().last().unwrap();
	
	if last_bin_dig == '0' {
	    print!("\t{} <--> {:?} ", x, current_list);
	    return true;
	}
    }
    return false;
}

fn proc(ints : Vec<i32>) {
    println!("Input: ints = {:?}", ints);
    print!("Output: ");
    if truth(ints) {
	println!("true");
    } else {
	println!("false");
    }
}

