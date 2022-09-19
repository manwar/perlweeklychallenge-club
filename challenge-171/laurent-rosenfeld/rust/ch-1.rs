fn is_abundant(n: usize) -> bool {
    let mut sum = 0;
    for i in 2..n/2 {
        if n % i == 0 {
            sum += i;
            if sum > n {
                return true;
            }
        }
    }
    return false
}

fn main() {
    let mut n = 1;
    let mut count = 0;
    while count < 20 {
        if is_abundant(n) {
            print!("{} ", n);
            count += 1;
        }
        n += 2;
    }
}
