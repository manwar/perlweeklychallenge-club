fn group_position(str: String) -> Vec<String> {
    let mut groups: Vec<String> = Vec::<String>::new();
    let mut i: usize = 0;
    while i < str.len() {
        let mut j: usize = i;
        while j < str.len() && str.chars().nth(j) == str.chars().nth(i) {
            j += 1;
        }
        if j - i >= 3 {
            groups.push(String::from(&str[i..j - 1]));
        }
        i = j;
    }
    groups
}

fn main() {
    println!("{:?}", group_position("abccccd".to_string()));
    println!("{:?}", group_position("aaabcddddeefff".to_string()));
    println!("{:?}", group_position("abcdd".to_string()));
}

