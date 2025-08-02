use std::io ;
use itertools::Itertools ;

fn main() {
    println!("Enter some positive integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let numbers : Vec<u32> = entered_line.split_whitespace( ).map( | s |
	  s.parse::<u32>( ).unwrap( ) ).collect( ) ;
    let solution = numbers.into_iter( ).combinations( 2 ).filter( | vec | {
	  (vec[0] + vec[1]) % 24 == 0 
	  } ).count( ) ;
    println!("{}" , solution ) ;
}
