fn main() {
    let a = vec![2, 1, 4, 5, 3, 7];
    let o = doit(&a);
    assert_eq!(o, 12);

    let a = vec![3, 2, 3, 5, 7, 5];
    let o = doit(&a);
    assert_eq!(o, 15);
}

fn doit(a: &[u32]) -> u64 {
    println!("Input: {:?}", a);
    print_histogram(a);
    let o = do_max_rect(a);
    println!("Output: {:?}", o);
    o
}

fn do_max_rect(a: &[u32]) -> u64 {
    a.iter().enumerate().fold((0, u32::MAX), |(max_rect_so_far, max_height), (idx, this_height)| {
        let new_max_height = max_height.min(*this_height);
        let width = idx as u64 + 1;
        let mut new_max_rect_so_far = max_rect_so_far.max(width * new_max_height as u64);
        if *this_height > new_max_height {
            // value increased, potential new rect starting, spawn parallel scan
            new_max_rect_so_far = new_max_rect_so_far.max(do_max_rect(&a[idx..]));
        }
        (new_max_rect_so_far, new_max_height)
    }).0 // 0 == max_rect_so_far
}

fn print_histogram(a: &[u32]) {
    let max_height = *a.iter().max().unwrap_or(&0);
    let len = format!("{}", max_height).len();
    for height in (1..=max_height).rev() {
        print!("{0:1$}", height, len);
        a.iter().for_each(|i| print!("{0:1$}{2}", "", len, if *i >= height { '#' } else { ' ' }));
        println!();
    }
    print!("{:>1$}", "_", len);
    a.iter().for_each(|_| print!("{0:1$}_", "", len));
    println!();

    print!("{:1$}", "", len);
    a.iter().for_each(|i| print!(" {0:1$}", i, len));
    println!();
}
