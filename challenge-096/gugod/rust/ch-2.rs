
fn main() {
    let examples: [[&str; 2]; 2] = [
        ["kitten", "sitting"],
        ["sunday", "monday"],
    ];
    for x in examples.iter() {
        println!("Input: S1={}, S2={}", x[0], x[1]);
        println!("Output: {}", edit_distance(x[0], x[1]));
    }
}

fn edit_distance(a: &str, b: &str) -> u32 {
    let chars_a = a.chars().collect();
    let chars_b = b.chars().collect();
    return lev( &chars_a, 0, &chars_b, 0);
}

fn lev (a: &Vec<char>, offset_a: usize, b: &Vec<char>, offset_b: usize) -> u32 {
    if offset_a == a.len() {
        return (b.len() - offset_b) as u32;
    }
    if offset_b == b.len() {
        return (a.len() - offset_a) as u32;
    }

    let n3 = lev( a, offset_a+1, b, offset_b+1 );
    if a[offset_a] == b[offset_b] {
        return n3;
    } else {
        let n1 = lev( a, offset_a+1, b, offset_b );
        let n2 = lev( a, offset_a,   b, offset_b+1 );
        return [n1, n2, n3].iter().min().unwrap() + 1_u32;
    }
}
