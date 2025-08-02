use std::{io , cmp} ;

fn main() {
    println!("Enter some integers, separated by whitespace!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s | 
	  s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    let positives : usize = numbers.iter().filter( | &d | *d > 0 ).count( ) ;
    let negatives : usize = numbers.iter( ).filter( |&d | *d < 0 ).count( ) ;
    println!("{}" , cmp::max( positives, negatives )) ;
}
