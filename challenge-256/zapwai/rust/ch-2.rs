fn main() {
    let str1a = "abcd"; let str2a = "1234";
    let str1b = "abc"; let str2b = "12345";
    let str1c = "abcde"; let str2c = "123";
    proc(str1a, str2a);
    proc(str1b, str2b);
    proc(str1c, str2c);    
}

fn proc(str1: &str, str2: &str) {
    let m;
    let ending;
    if str1.len() < str2.len() {
	m = str1.len();
	ending = str2[m..].to_string();
    }
    else {
	m = str2.len();
	ending = str1[m..].to_string();
    }
    let mut ans = "".to_string();
    let mut i = 0;
    loop {
	ans = [ans,
	       str1.chars().nth(i).unwrap().to_string(), 
	       str2.chars().nth(i).unwrap().to_string()
	].join("");
	i += 1;
	if i >= m { break; }
    }
    ans = [ans, ending].join("");
    println!("Input: str1 = {str1}, str2 = {str2}");
    println!("Output: {ans}");
}
