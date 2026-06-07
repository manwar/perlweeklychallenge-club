fn same_color(c1: &str, c2: &str) -> bool
{
    let l1 = c1.as_bytes()[0] as u8 - 'a' as u8;
    let n1 = c1.as_bytes()[1] as u8 - '1' as u8;
    
    let l2 = c2.as_bytes()[0] as u8 - 'a' as u8;
    let n2 = c2.as_bytes()[1] as u8 - '1' as u8;
    return (l1 + n1) %2 == (l2+n2) % 2;
}

pub fn main() { 
    println!("{:?}",  same_color("a7", "f4"));
    println!("{:?}",  same_color("c1", "e8"));
    println!("{:?}",  same_color("b5", "h2"));
    println!("{:?}",  same_color("f3", "h1"));
    println!("{:?}",  same_color("a1", "g8"));
}

