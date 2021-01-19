
fn reverse_words(x: String) -> String {
    return x.split_whitespace().rev()
            .collect::<Vec<&str>>()
            .join(" ");
}

fn main() {
    let examples: [&str; 3] = [
        "The Weekly Challenge",
        "    Perl and   Raku are  part of the same family  ",
        "join reverse split $S"
    ];

    for x in examples.iter() {
        println!("Input: {}", x);
        println!("Output: {}", reverse_words(x.to_string()));
    }
}
