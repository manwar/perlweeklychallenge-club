fn main() {
    let stringy = "a1c1e1";
    proc(stringy);
    let stringy2 = "a1b2c3d4";
    proc(stringy2);
    let stringy3 = "b2b";
    proc(stringy3);
}

fn proc(stringy : &str) {
    println!("Input: str = {stringy}");
    let mut lets : Vec<char> = Vec::new();
    let mut puts : Vec<char> = Vec::new();
    for i in 0 .. stringy.len() {
	if i % 2 == 0 {
	    let mylet = stringy.chars().nth(i).unwrap();
	    lets.push(mylet);
	} else {
	    let put = shifty(lets.last().unwrap(), stringy.chars().nth(i).unwrap().to_digit(10).unwrap() as usize );
	    puts.push(put);
	}
    }
    print!("Output: ");
    for j in 0 .. (stringy.len()/2) {
	print!("{}{}", lets[j], puts[j]);
    }
    if (stringy.len()) % 2 == 1 {
	print!("{}",lets.last().unwrap());
    }
    println!();

}

fn shifty(chr : &char, d : usize) -> char {
    let alph = "abcdefghijklmnopqrstuvwxyz";
    let ind = alph.chars().position(|c| c == *chr).unwrap();
    return alph.chars().nth(d + ind).unwrap();
}
