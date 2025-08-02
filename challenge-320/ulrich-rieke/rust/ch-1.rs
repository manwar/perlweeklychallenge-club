use std::{io, cmp} ;

fn main() {
    println!("Enter some integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s| 
	  s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    let positives : usize = numbers.iter( ).filter( |&d| *d > 0 ).count( ) ;
    let negatives : usize = numbers.iter( ).filter( |&d| *d < 0 ).count( ) ;
    if positives != 0 || negatives != 0 {
       println!("{}" , cmp::max( positives , negatives) ) ;
    }
    else {
       println!("0") ;
    }
}
