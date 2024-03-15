use std::cmp::max;

fn main() {
    let s1 = "faremviel";
    let s2 = "farmville";
    println!("{}", jw(s1, s2));
}


fn jw(s1 : &str, s2 :&str) -> f32 {
    let jsim = jsim(s1, s2);
    let p = 0.1;
    let mut l = 0;
    let l1 : Vec<char> = s1.chars().collect();
    let l2 : Vec<char> = s2.chars().collect();
    for i in 0 .. 4 {
	if l1[i] == l2[i] {
	    l += 1;
	}
    }
    let wsim = jsim + (l as f32)*p*(1. - jsim);
    return 1. - wsim;
}

fn jsim(s1 :&str, s2 :&str) -> f32 {
    let l1 = s1.len() as i32;
    let l2 = s2.len() as i32;
    let offset = max(l1, l2) / 2;
    let a = num_matches(s1, s2, offset);
    let m = a[0] as f32;
    let t = a[1] as f32;
    if m > 0.0 {
	return 1.0/3.0 * (m/(l1 as f32) + m/(l2 as f32) + (m - t)/m)
    } else {
	return 0.0;
    }
}

fn num_matches(s1 :&str, s2 :&str, offset :i32) -> [i32; 2] {
    let l1 : Vec<char> = s1.chars().collect();
    let l2 : Vec<char> = s2.chars().collect();
    let mut cnt = 0;
    let mut trans = 0;
    for i in 0 .. l1.len() {
	let mut outflag = false;
	for j in 0 .. l2.len() {
	    if !outflag {
		if (i as i32 - j as i32).abs() < offset {
		    if l1[i] == l2[j] {
			outflag = true;
			cnt += 1;
			if i != j {
			    if ((i + 1 < l1.len()) && (l1[i] == l2[i + 1]) && (l2[i] == l1[i + 1])) || ((i - 1 > 0) && (l1[i] == l2[i - 1]) && (l2[i] == l1[i - 1])) {
				trans += 1;
			    }
			}
		    }
		}
	    }
	}
    }
//    print!("{cnt}");
    return [cnt, trans/2];
}

