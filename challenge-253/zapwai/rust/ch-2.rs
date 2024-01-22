fn main () {
    // let m = [
    //     [1, 0, 0, 0],
    //     [1, 1, 1, 1],
    //     [1, 0, 0, 0],
    //     [1, 0, 0, 0]
    // ];

    let m = [
        [1, 1, 0, 0, 0],
        [1, 1, 1, 1, 0],
        [1, 0, 0, 0, 0],
        [1, 1, 0, 0, 0],
        [1, 1, 1, 1, 1]
    ];
    let mut r : Vec<i32> = Vec::new();
    println!("Input: \n  m = ");
    for i in 0 .. m.len() {
	r.push(0);
	println!(" {:?}", m[i]);
	for d in m[i] {
	   if d == 1 {
		r[i] += 1;
	   }
	}
    }
    let mut ans : Vec<usize> = Vec::new();
    for i in 0 .. m.len() {
	ans.push(i);
    }
    // sort ans array
    let mut cnt = 1;
    while cnt > 0 {
	cnt = 0;
	for i in 0 .. m.len()-1 {
	   if !rowcmp(ans[i],ans[i+1], &r) {
		let x = ans[i];
		ans[i] = ans[i+1];
		ans[i+1] = x;
		cnt += 1;
	   }
	}
    } 
    println!("Output: {:?}", ans);
}

// return true if rowi < rowj, else false
fn rowcmp( i: usize, j :usize, r :&Vec<i32>) -> bool {
    if r[i] < r[j] {
	return true;
    } else if r[i] > r[j] {
	return false;
    } else {
	return if i < j {true} else {false};
    }
}