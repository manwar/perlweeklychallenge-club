fn good_a_b_string(string: &str) -> bool {
    let mut first_b = false;
    for c in string.chars() {
        match c {
	    // on 'b' then set first_b to true
            'b' => first_b |= true,
	    // on 'a', if we've seen a 'b' then false
            'a' => {
                if first_b {
                    return false;
                }
            }
	    // otherwise no action, keep iterating
            _ => continue,
        }
    }
    // if we've seen a 'b' this is true
    first_b
}

fn main() {
    let tests = vec!["aabb", "abab", "aaa", "bbb", "aaaffeoioijlkfjoihslkjhfb"];

    for val in tests.iter() {
        let good_val = good_a_b_string(val);
        println!("{val} :: {good_val}");
    }
}
