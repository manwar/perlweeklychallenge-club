#![allow(unused)]
fn is_reduced(m : &Vec<Vec<i32>>) -> bool {
    let (r, c) = (m.len(), m[0].len());
    for i in 0 .. r {
	for j in 0 .. c {
	    if m[i][j] == 0 {
		continue;
	    } else if m[i][j] == 1 {
		break;
	    } else {
		return false;
	    }
	}
    }
    let fv = c - r;
    for j in 0 .. c-fv {
	let mut cnt = 0;
	for i in 0 .. r {
	    if m[i][j] != 0 {
		cnt += 1;
	    }
	}
	if cnt > 1 {
	    return false;
	}
    }
    return true;
}

fn is_echelon(m : &Vec<Vec<i32>>) -> bool {
    let (r, c) = (m.len(), m[0].len());
    let mut zcnt = 0;
    for i in 0 .. r {
	let mut cnt = 0;
	for j in 0 .. c {
	    if (m[i][j] == 0) {
		cnt += 1;
	    } else {
		break;
	    }
	}
	if (cnt < zcnt) {
	    return false;
	} else {
	    zcnt = cnt;
	}
    }
    return true;
}

fn check(m : &Vec<Vec<i32>>) -> bool { return is_echelon(m) && is_reduced(m); }

fn proc(m : &Vec<Vec<i32>>) {
    println!("Input: M = [");
    let mut i = 0;
    loop {
	println!("\t{:?}", m[i]);
	i += 1;
	if i == m.len() { break; }
    }
    println!("]");    

    println!("Output: {}", check(m));    
}

fn main() {
    let m1 = vec![
	vec![1,0,0,1],
	vec![0,1,0,2],
	vec![0,0,1,3]
    ];

    let m2 = vec![
	vec![1, 1, 0],
	vec![0, 1, 0],
	vec![0, 0, 0]
    ];

    let m3 = vec![
	vec![0, 1,-2, 0, 1],
	vec![0, 0, 0, 1, 3],
	vec![0, 0, 0, 0, 0],
	vec![0, 0, 0, 0, 0]
    ];

    let m4 = vec![
	vec![1, 0, 0, 4],
	vec![0, 1, 0, 7],
	vec![0, 0, 1,-1]
    ];

    let m5 = vec![
        vec![0, 1,-2, 0, 1],
        vec![0, 0, 0, 0, 0],
        vec![0, 0, 0, 1, 3],
        vec![0, 0, 0, 0, 0]
    ];

    let m6 = vec![
        vec![0, 1, 0],
        vec![1, 0, 0],
        vec![0, 0, 0]
    ];

    let m7 = vec![
        vec![4, 0, 0, 0],
        vec![0, 1, 0, 7],
        vec![0, 0, 1,-1]
    ];
    
    for k in [&m1, &m2, &m3, &m4, &m5, &m6, &m7] { proc(k); }    
}
