use regex::Regex;

fn main() {
    let pattern = Regex::new(r"((\d{4}|\+\d{2}|\(\d{2}\))\s+\d{10})").unwrap();
    let test = "foo 0044 1148820341 42 xyz +44 1148820342 abc
        44-11-4882-0343 (44) 1148820344 00 1148820345";
    for matches in pattern.captures_iter(test) {
        println!("{:?}", &matches[0]);
    }
}
