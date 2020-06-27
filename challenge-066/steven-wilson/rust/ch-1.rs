fn main() {
    println!("5 / 2 = {}", divide( 5, 2 ));
    println!("-5 / 2 = {}", divide( -5, 2 ));
    println!("-5 / -2 = {}", divide( -5, -2 ));
}

fn divide ( m: i32, n: i32) -> i32 {
    let mut a = m.abs();
    let b = n.abs();
    let mut q = 0;
    while a >= b {
        q += 1;
        a -= b;
    }
    if ( m < 0  &&  n > 0 )  ||  ( n < 0  &&  m > 0 ) {
        q *= -1;
        if a != 0 {
            q -= 1;
        }
    }
    q
}
