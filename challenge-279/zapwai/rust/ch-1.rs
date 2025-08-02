fn main() {
    let letters = vec!['R', 'E', 'P', 'L'];
    let weights = vec![3, 2, 1, 4];
    proc(letters, weights);
    let letters2 = vec!['A', 'U', 'R', 'K'];
    let weights2 = vec![2, 4, 1, 3];
    proc(letters2, weights2);
    let letters3 = vec!['O', 'H', 'Y', 'N', 'P', 'T'];
    let weights3 = vec![5, 4, 2, 6, 1, 3];
    proc(letters3, weights3);
}

fn proc(l : Vec<char>, w : Vec<i32>) {
    println!("Input: letters = {:?}, weights = {:?}", l, w);
    let mut ans : Vec<char> = Vec::new();
    for _i in 0 .. l.len() {
	ans.push(' ');
    }
    for i in 0 .. l.len() {
	ans[(w[i] - 1) as usize] = l[i];
    }
    println!("Output: {:?}", ans);
}
