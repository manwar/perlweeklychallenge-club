use regex::{Regex, RegexBuilder};

fn check_broken_words(line: &str, chars: &[char]) -> usize {
    let letter_string = r"\S*[".to_string() + &String::from_iter(chars) + r"]\S*";
    let letters_re = RegexBuilder::new(&letter_string)
        .case_insensitive(true)
        .build()
        .unwrap();
    let matches: Vec<_> = letters_re.find_iter(line).map(|m| m.as_str()).collect();

    let words_re = Regex::new(r"\S+").unwrap();
    let words_count: Vec<_> = words_re.find_iter(line).map(|m| m.as_str()).collect();
    words_count.len() - matches.len()
}

fn main() {
    let lines = vec![
        ("Perl Weekly Challenge", vec!['l', 'a']),
        ("Perl and Raku", vec!['a']),
        ("Well done Team PWC", vec!['l', 'o']),
        ("The joys of polyglottism", vec!['T']),
        ("The joys o*f polyglottism", vec!['*', 'T', 'p']),
    ];

    for line in lines {
        let count = check_broken_words(line.0, &line.1);
        println!("{}, {} => {}", line.0, String::from_iter(line.1), count);
    }
}
