fn fill_digits(s: &str) -> String {
    let mut last = ' ';
    s.chars()
        .map(|x| {
            if x.is_digit(10) {
                ((last as u8) + (x as u8) - ('0' as u8)) as char
            } else {
                last = x;
                x
            }
        })
        .collect::<String>()
}

fn main() {
    let inputs = vec![
        "a1c1e1",
        "a1b2c3d4",
        "b2b",
        "a16z",
        "H01234ell01234o, w01234orld01234!",
    ];

    for instring in inputs {
        let fs = fill_digits(instring);
        println!("input: {} => {}", instring, fs);
    }
}
