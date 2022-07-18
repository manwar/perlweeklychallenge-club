fn is_esthetic(num: i32) -> bool {
    let n = num.to_string();
    for i in 1..n.len() {
        if n.as_bytes()[i] != n.as_bytes()[i-1] + 1 &&
           n.as_bytes()[i-1] != n.as_bytes()[i] + 1 {
            return false
        }
    }
    return true
}

fn main() {
    for test in [5456, 120, 121, 23456, 2346, 7654567, 765467] {
        println!("{} -> {}", test, if is_esthetic (test) { " is esthetic"} else { " is not esthetic"});
    }
}
