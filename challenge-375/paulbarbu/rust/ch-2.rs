
fn find_k_beauty(mut n: i32, k: u32) -> i32 {
    if n < 0 {
        n *= -1;
    }

    let initial = n;
    let mut c = 0;
    if k == 0
    {
        return 0;
    }
    let pexp = 10_i32.pow(k-1);
    while n /pexp >= 1
    {
        let mut x = n % 10;
        n /= 10;
        for i in 1..k
        {
            x = (n%10) * 10_i32.pow(i) + x;
        }

        if initial % x == 0
        {
            c += 1;
        }
    }
    c
}

// If you use `main()`, declare it as `pub` to see it in the output:
// pub fn main() { ... }
pub fn main()
{
    println!("E1");
    println!("{}", find_k_beauty(240, 2));

    println!("E2");
    println!("{}", find_k_beauty(1020, 2));

    println!("E3");
    println!("{}", find_k_beauty(444, 2));

    println!("E4");
    println!("{}", find_k_beauty(17, 2));

    println!("E5");
    println!("{}", find_k_beauty(123, 1));

    println!("Extra6");
    println!("{}", find_k_beauty(1, 2));

    println!("Extra7");
    println!("{}", find_k_beauty(1, 1));

    println!("Extra8");
    println!("{}", find_k_beauty(1, 0));
    
    println!("Extra9");
    println!("{}", find_k_beauty(-240, 2));

    println!("Extra10");
    println!("{}", find_k_beauty(-1020, 2));

    println!("Extra11");
    println!("{}", find_k_beauty(-444, 2));

    println!("Extra12");
    println!("{}", find_k_beauty(-17, 2));

    println!("Extra13");
    println!("{}", find_k_beauty(-123, 1));

    println!("Extra14");
    println!("{}", find_k_beauty(-1, 2));

    println!("Extra15");
    println!("{}", find_k_beauty(-1, 1));

    println!("Extra16");
    println!("{}", find_k_beauty(-1, 0));

    println!("Extra17");
    println!("{}", find_k_beauty(0, 0));
}

