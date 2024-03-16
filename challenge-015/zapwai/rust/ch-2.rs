use std::convert::TryInto;
fn vigenere(mode :i32, the_key :&str, msg :&str) -> String {
    let alph = "abcdefghijklmnopqrstuvwxyz";
    let mut q = msg.len() / the_key.len();
    let mut key = String::from(the_key);
    while q > 0 {
        key.push_str(&the_key);
        q -= 1;
    }
    while key.len() > msg.len() {
        key = (&key[0..key.len() - 1]).to_string();
    }
    let msg_letters = msg.chars().collect::<Vec<char>>();
    let key_letters = key.chars().collect::<Vec<char>>();
    let mut rots :Vec<i32> = Vec::new();
    for i in key_letters {
        rots.push(alph.chars().position(|c| c == i).unwrap().try_into().unwrap());
    }
    let mut ans_letters :Vec<char>= Vec::new();
    for i in 0 .. msg_letters.len() {
	if !msg_letters[i].is_alphabetic() {
	    ans_letters.push(msg_letters[i]);
            continue;
	}
        let v = alph.chars().position(|c| c == msg_letters[i]).unwrap() as i32;
	let mut x;
        if mode == 0 {
	    x = (v + rots[i]) % 26;
	}
	else {
	    x = (26 + v - rots[i]) % 26;
	}
        let letter = alph.chars().nth(x as usize).unwrap();
        ans_letters.push(letter);
    }
    return ans_letters.iter().collect();

}

fn main() {
    let msg = "hello world";
    let key = "test";
    let enc = vigenere(0, key, msg);
    let dec = vigenere(1, key, &enc);
    println!("{}", enc);
    println!("{}", dec);
}
