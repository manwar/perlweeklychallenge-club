// fn percent_of_string_char_v1(string: &str, character: &char) -> u32 {
//     let mut sum: u32 = 0;
//     let mut string_length: u32 = 0;
//     for c in string.chars() {
//         string_length += 1;
//         if c == *character {
//             sum += 1;
//         }
//     }
//     ((sum as f64 / string_length as f64) * 100.0).round() as u32
// }

fn percent_of_string_char_v2(string: &str, character: &char) -> usize {
    let match_count = string.chars().filter(|c| c == character).count();
    let string_length = string.chars().count();
    let mc_100 = 100 * match_count;
    let (div, remainder) = (mc_100 / string_length, mc_100 % string_length);
    if remainder * 2 >= string_length {
        div + 1
    } else {
        div
    }
}

fn main() {
    let tests = vec![
        ("perl", 'e'),
        ("java", 'a'),
        ("python", 'm'),
        ("ada", 'a'),
        ("ada", 'd'),
        ("ballerina", 'l'),
        ("analitik", 'k'),
        ("rust", 'r'),
    ];

    for val in tests.iter() {
        let (string, character) = val;
        let percent = percent_of_string_char_v2(string, &character);
        println!("{string} :: {character} => {percent}");
    }
}
