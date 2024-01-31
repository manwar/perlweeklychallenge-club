use std::io ;

fn main() {
    println!("Enter a positive integer!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let changed = entered_line.trim( ) ;
    let number = changed.parse::<i32>( ).unwrap( ) ;
    let cuberoot : f32 = (number as f32).cbrt( ) ;
    println!("{}" , cuberoot == cuberoot.floor( ) ) ;
}
