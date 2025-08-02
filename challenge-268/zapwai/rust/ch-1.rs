fn main() {
    let x = vec![3, 7, 5];
    let y = vec![9, 5, 7];
    proc(x, y);
}

fn check(x : Vec<i32>, y : &Vec<i32>) -> bool {
    let mut cnt = 0;
    for i in 0 .. x.len() {
	if x[i] == y[i] {
	    cnt += 1;
	}
    }
    return cnt == x.len();
}

fn proc(x : Vec<i32>, y : Vec<i32>) {
    println!("Input:  x = {:?} \n\ty = {:?}", x, y);
    print!("Output: ");
    let mut myx = x.clone();
    myx.sort();
    let mut myy = y.clone();
    myy.sort();
    for i in -99 .. 99 {
	let mut n : Vec<i32> = Vec::new();
	for j in 0 .. x.len() {
	    n.push(myx[j] + i);
	}
	if check(n, &myy) {
	    println!("{i}");
	}
    }
}
