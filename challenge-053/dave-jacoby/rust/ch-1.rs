fn main() {
    let my_str = "".to_string();
    vowel_strings(2,my_str);
}

fn vowel_strings ( max_len:i32 , my_str:String) -> bool {
    let rts_ym : String = my_str.chars().rev().collect();
    let my_len = my_str.len();
    let mut last = "";
    let mut vnext : Vec<String> = Vec::new();

    if  max_len as usize == my_len {
        println!("{}",my_str);
        return true
    }

    if my_len > 0 {
        last = &rts_ym[0..1];
    }

    if  last == "a" {
        vnext.push("e".to_string());
        vnext.push("i".to_string());
    } else if last == "e" {
        vnext.push("i".to_string());
    } else if last == "i" {
        vnext.push("a".to_string());
        vnext.push("e".to_string());
        vnext.push("o".to_string());
        vnext.push("u".to_string());
    } else if last == "o" {
        vnext.push("a".to_string());
        vnext.push("o".to_string());
    } else if last == "u" {
        vnext.push("e".to_string());
        vnext.push("o".to_string());
    } else {
        vnext.push("a".to_string());
        vnext.push("e".to_string());
        vnext.push("i".to_string());
        vnext.push("o".to_string());
        vnext.push("u".to_string());

    }

    for next in &vnext {
        let next_str = format!("{}{}",my_str,next);
        vowel_strings(max_len,next_str);
    }
    true
}