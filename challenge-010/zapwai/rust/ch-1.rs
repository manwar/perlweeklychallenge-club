#![allow(unused)]

fn main() {
    convert_from_roman(String::from("CCXLVI"));
    convert_to_roman(39);
}

fn roman(c : char) -> i32 {
    let r = vec!['I', 'V', 'X', 'L', 'C', 'D', 'M'];
    let v = vec![1, 5, 10, 50, 100, 500, 1000];
    for i in 0 .. r.len() {
        if r[i] == c {
            return v[i];
	}
    }
    return -1;
}

fn convert_from_roman(mut s : String) {
    let basic = vec![ "IIII", "VIIII", "XXXX", "LXXXX", "CCCC", "DCCCC" ];
    let modern = vec![ "IV", "IX", "XL", "XC", "CD", "CM" ];
    println!("Input: {} ",s);
    for i in 0..basic.len() {
        let key = modern[i]; 
        let val = basic[i];
	s = s.replace(key, val);
    }
    let mut sum = 0;
    for c in s.chars() {
        sum += roman(c);
    }
    println!("Output: {}", sum);
}

fn convert_to_roman(n :i32) {
    let r = vec!['I', 'V', 'X', 'L', 'C', 'D', 'M'];
    let v = vec![1, 5, 10, 50, 100, 500, 1000];
    let basic = vec![ "IIII", "VIIII", "XXXX", "LXXXX", "CCCC", "DCCCC" ];
    let modern = vec![ "IV", "IX", "XL", "XC", "CD", "CM" ];
    println!("Input: {}", n);
    let mut ans = Vec::new();
    let mut stack = vec![];
    for i in 0 .. r.len() {
        if n >= v[i] {
	    stack.push(v[i]);
	}
    }
    let mut i = stack.len() - 1;
    let mut num = n;
    while i > 0 {
        let x = stack.pop().unwrap();
        let d = num/x;
        for _j in 0 .. d {
            ans.push(r[i]);
	}
        num -= d*x;
        i -= 1;
    }
    let x = stack.pop().unwrap();
    let d = num/x;
    for _j in 0 .. d {
        ans.push(r[0]);
    }

    let mut answer :String = ans.iter().collect();    
    for i in 0 ..basic.len() {
        let key = basic[basic.len() - 1 - i];
        let val = modern[basic.len() - 1 - i];
	answer = answer.replace(key, val);
    }
    println!("Output: {}", answer);
}

