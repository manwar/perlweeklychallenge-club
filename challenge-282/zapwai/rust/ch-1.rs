fn main() {
    let int = 123444567;
    proc(int);
    let int2 = 1233334;
    proc(int2);
    let int3 = 10020003;
    proc(int3);
}
fn proc(int :i32) {
    println!( "Input: {int}");
    let mut numb = -1;
    let mut current = 0;
    let mut prev = 0;
    let mut cnt = 0;
    let mut num :Vec<i32>= Vec::new();
    let mut t = int;
    while t != 0 {
	num.push(t % 10);
	t = t / 10;
    }
    for i in 0 .. num.len() {
	prev = current;
	current = num[i];
	if prev == current {
	    cnt += 1;
	} else {
	    if cnt == 2 {
		numb = prev;
		break;
	    } else {
		cnt = 0;
	    }
	}
    }
    println!( "Output: {}", numb);
}
