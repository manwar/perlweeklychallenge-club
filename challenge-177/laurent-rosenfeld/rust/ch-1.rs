fn is_valid(num: u32) -> bool {
    static DAMM: [[u8; 10]; 10] = [
        [0, 3, 1, 7, 5, 9, 8, 6, 4, 2],
        [7, 0, 9, 2, 1, 5, 4, 8, 6, 3],
        [4, 2, 0, 6, 8, 7, 1, 3, 5, 9],
        [1, 7, 5, 0, 9, 8, 3, 4, 2, 6],
        [6, 1, 2, 3, 0, 4, 5, 9, 7, 8],
        [3, 6, 7, 4, 2, 0, 9, 5, 8, 1],
        [5, 8, 6, 9, 7, 2, 0, 1, 3, 4],
        [8, 9, 4, 5, 3, 6, 2, 0, 1, 7],
        [9, 4, 3, 8, 6, 1, 7, 2, 0, 5],
        [2, 5, 8, 1, 4, 3, 6, 7, 9, 0],
    ];

    let mut temp = 0;
    let n_str = num.to_string();
    let digits = n_str.bytes();
    for i in digits {
        temp = DAMM[temp as usize][i as usize - 48];
    };
    return temp == 0
}

fn main() {
    println!("{}", "Valid numbers between 5700 and 5800 are:");
    for i in 5700..5800 {
        if is_valid(i) {
            print!("{} ", i);
        }
    }
    println!("{}", " ");
}
