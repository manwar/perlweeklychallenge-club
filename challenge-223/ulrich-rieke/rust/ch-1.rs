use std::io ;

fn main() {
    println!("Enter a positive integer!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let number : u64 = entered_line.trim( ).parse::<u64>( ).unwrap( ) ;
    println!("{}" , (2..=number).into_iter( ).filter( | x | primal::is_prime( *x ) ).
      count( ) ) ;
}
