fn main() {
    let start = "g2";
    let end = "a8";
    proc(start, end);

    let start2 = "g2";
    let end2 = "h2";
    proc(start2, end2);
}

fn proc(start :&str, end :&str) {
    println!("Input: {start} to {end}");
    let mut list :Vec<Vec<String>> = vec![moves(&start.to_string())];
    let mut round = 0;
    let mut found = 0;
    while found == 0 {
	round += 1;
	for old_move in &list[round - 1] {
	    if old_move == end {
		found = 1;
	    }
	}
	if found == 1 {
	    break;
	} else {
	    let mut move_list :Vec<String> = Vec::new();
	    for old_move in &list[round - 1] {
		for new_move in moves(old_move) {
		    move_list.push(new_move);
		}
	    }
	    let mut uniq_mv_list :Vec<String> = Vec::new();
	    for elem in move_list {
		let mut elem_flag = 0;
		for q in &uniq_mv_list {
		    if *q == elem {
			elem_flag = 1;
		    }
		}
		if elem_flag == 0 {
		    uniq_mv_list.push(elem);
		}
	    }
	    list.push(uniq_mv_list);
	}
    }
    println!("Output: {round}");
}

fn moves(coord :&String) -> Vec<String> {
    let l = coord.chars().nth(0).unwrap();
    let row:i32 = coord.chars().nth(1).unwrap().to_digit(10).unwrap() as i32;
    let cols = "abcdefgh";
    let col :i32 = 1 + cols.chars().position(|c| c == l).unwrap() as i32;
    let mut r :Vec<i32> = Vec::new();
    let mut c :Vec<i32> = Vec::new();
    for i in [-2, 2] {
	for j in [-1, 1] {
	    c.push(col + i);
	    r.push(row + j);
	}
    }
    for i in [-1, 1] {
	for j in [-2, 2] {
	    c.push(col + i);
	    r.push(row + j);
	}
    }
    let mut list :Vec<String> = Vec::new();
    for i in 0 .. 8 {
	if c[i] < 1 || c[i] > 8 { continue; }
	if r[i] < 1 || r[i] > 8 { continue; }
	let newmove = format!("{}{}", cols.chars().nth((c[i] as usize)-1).unwrap(), r[i]);
	list.push(newmove);
    }
    return list;
}
