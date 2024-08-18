fn good_integer(input: &u64) -> Vec<String> {
    let input_string = input.to_string();
    if input_string.len() < 3 {
        return ["-1".to_string()].to_vec();
    }

    let mut vec = Vec::new();
    let mut count = 1;
    let mut chars = input_string.chars();
    let mut last = chars.next().unwrap();
    for current in chars {
        if last == current {
            count += 1;
        } else {
            if count == 3 {
                vec.push(format!("{}{}{}", last, last, last));
            }
            count = 1;
        }
        last = current;
    }
    // catch possible trailing valid ints
    if count == 3 {
        vec.push(format!("{}{}{}", last, last, last));
    }

    if vec.len() > 0 {
        return vec;
    }
    ["-1".to_string()].to_vec()
}

fn main() {
    let inputs = [12333, 12333455557, 1233345557, 1233333, 333, 3331, 3333];
    for input in inputs {
        let goodness = good_integer(&input);
        println!("{} => {:?}", input, goodness);
    }
}
