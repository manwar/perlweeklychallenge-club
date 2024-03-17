fn vaneck(seq :&mut Vec<i32>) {
    if seq.len() == 1 {
	seq.push(0);
    }
    else {
	let pop = seq[seq.len() - 1];
	let mut done_flag = false;
	let mut j = seq.len() - 2;
	while j > 0 {
	    if !done_flag && pop == seq[j] {
		done_flag = true;
		seq.push((seq.len()- 1 - j).try_into().unwrap());
	    }
	    j -= 1;
	}
	if !done_flag && pop == seq[0] {
	    done_flag = true;
	    seq.push((seq.len()- 1).try_into().unwrap());
	}
	if !done_flag {
	    seq.push(0);
	}
    }
}

fn main() {
    let n = 19;
    let mut seq = vec![0];
    for _i in 0 .. n {
	vaneck(&mut seq);
    }
    println!("{:?}", seq);
}
