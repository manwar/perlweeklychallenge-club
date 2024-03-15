fn has_distinct_digits(num :i32) -> bool {
    let dig = num.to_string().chars().collect::<Vec<_>>();
    let mut count = [0; 10];
    for d in dig {
	if let Some(digit) = d.to_digit(10) {
	    count[digit as usize] += 1;
	} else {
	    return false;
	}
    }
    for &d in count.iter() {
	if d > 1 {
	    return false;
	}
    }
    return true;
}

fn main() {
    let v = (1 .. 1500).collect::<Vec<i32>>();
    for i in v {
	if has_distinct_digits(i*i) && (i*i).to_string().len() == 5 {
	    println!("{} -> {}", i, i*i);
	    break;
	}
    }
}
