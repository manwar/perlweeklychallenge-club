fn main() {
    let t = vec!["perl", "2", "000", "python", "r4ku"];
    let t2 = vec!["001", "1", "000", "0001"];
    proc(t);
    proc(t2);    
}

fn proc(t :Vec<&str>) {
    let mut max :i32 = 0;
    for i in t.iter() {
	let c = val(i);
	if max < c {
	    max = c;
	}
    }
    println!("Input: str = {:?}",t);
    println!("Output: {max}");
}

fn val(i :&str) -> i32 {
    return if is_num(i) {
	i.parse::<i32>().unwrap()
    } else {
	i.len() as i32
    };
}

fn is_num (i :&str) -> bool {
    let mut cnt = 0;
    for c in i.chars() {
	if c.is_digit(10) {
	    cnt += 1;
	}
    }
    return if cnt == i.len() {true} else {false};
}
