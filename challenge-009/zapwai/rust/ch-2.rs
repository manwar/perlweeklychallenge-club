#![allow(unused)]

fn std(a :Vec<i32>) -> Vec<i32> {
    let mut b = Vec::new();
    let mut rank = 1;
    let mut lvl = a[0];
    for i in 0 .. a.len() {
	if a[i] > lvl {
	    rank = i + 1;
	    lvl = a[i];
	}
	b.push(rank as i32);
    }
    return b;
}

fn modi(a :Vec<i32>) -> Vec<i32> {
    let mut b = Vec::new();
    let mut c = a.clone();
    c.reverse();
    let mut lvl = c[0];
    let mut rank = c.len();
    for i in 0 .. c.len() {
	if c[i] < lvl {
	    rank = c.len() - i;
	    lvl = c[i]
	}
	b.push(rank as i32);
    }
    b.reverse();
    return b;
}

fn den(a :Vec<i32>) -> Vec<i32> {
    let mut b = Vec::new();
    let mut rank = 1;
    let mut lvl = a[0];
    for i in 0 .. a.len() {
	if a[i] > lvl {
	    rank += 1;
	    lvl = a[i];
	}
	b.push(rank as i32);
    }
    return b;
}

fn proc(a :Vec<i32>) {
    println!("Input: {:?}", a);
    println!("Stand: {:?}", std(a.clone()));
    println!("Modif: {:?}", modi(a.clone()));
    println!("Dense: {:?}\n", den(a.clone()));
}

fn main() {
    let list1 = vec![1, 2, 2, 3];
    let list2 = vec![1, 4, 6, 6, 8, 10, 10];
    let list3 = vec![1, 2, 2, 4, 4, 4, 5, 7, 9, 11, 11, 11];
    let list4 = vec![3, 3, 6, 6];
    for a in [list1, list2, list3, list4] {	proc(a);    }
}
