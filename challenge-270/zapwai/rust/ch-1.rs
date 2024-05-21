#![allow(non_snake_case)]

fn is_special(m : &Vec<Vec<i32>>, M : i32, N : i32, i : usize, j : usize) -> bool {
    if m[i][j] != 1 {
	return false;
    }
    for k in 0 .. M as usize {
	if k == i {
	    continue;
	}
	if m[k][j] != 0 {
	    return false;
	}
    }
    for k in 0 .. N as usize {
	if k == j {
	    continue;
	}
	if m[i][k] != 0 {
	    return false;
	}
    }
    return true;
}

fn proc(m : Vec<Vec<i32>>, M : i32, N : i32) {
    println!("Input: m = {:?}", m);
    let mut cnt = 0;
    for i in 0 .. M {
	for j in 0 .. N {
	    if is_special(&m, M, N, i as usize, j as usize) {
		cnt += 1;
	    }
	}
    }
    println!("Output: {cnt}");
}

fn main() {
    let matrix = vec![
	vec![1, 0, 0],
	vec![0, 0, 1],
	vec![1, 0, 0],
    ];

    let matrix2 = vec![
	vec![1, 0, 0],
	vec![0, 1, 0],
	vec![0, 0, 1],
    ];

    proc(matrix, 3, 3);
    proc(matrix2, 3, 3);
}

