#![allow(non_snake_case)]

fn main() {
    let ints = vec![0, 1, 2, 3, 4, 5, 6, 7, 8];
    proc(ints);
    let ints2 = vec![1024, 512, 256, 128, 64];
    proc(ints2);
}

fn proc(ints : Vec<i32>) {
    println!("Input: {:?}", ints);
    let mut count : Vec<i32> = Vec::new();
    for _i in 0 .. ints.len() {
	count.push(0);
    }

    for i in 0 .. ints.len() {
	let d = format!("{:b}",ints[i]);
	let mut D : Vec<&str> = d.split("").collect();
	D.pop();
	D.reverse();
	D.pop();
	D.reverse();
	for dig in D {
	    if dig == "1" {
		count[i] += 1;
	    }
	}
    }
    let mut ord = ints.clone();
    let mut c = 1;
    while c != 0 {
	c = 0;
	for i in 0 .. ints.len()-1 {
	    if count[i] > count[i+1] {
		c += 1;
		let tmp_cnt = count[i];
		let tmp_int = ord[i];
		count[i] = count[i+1];
		count[i+1] = tmp_cnt;
		ord[i] = ord[i+1];
		ord[i+1] = tmp_int;
	    }
	}
    }
    c = 1;
    while c != 0 {
	c = 0;
	for i in 0 .. ints.len()-1 {
	    if count[i] != count[i+1] {
		continue;
	    }
	    if ord[i] > ord[i+1] {
		c += 1;
		let tmp_int = ord[i];
		ord[i] = ord[i+1];
		ord[i+1] = tmp_int;
		let tmp_cnt = count[i];
		count[i] = count[i+1];
		count[i+1] = tmp_cnt;
	    }
	}
    }
    println!("Output: {:?}", ord);
}
