use std::{io , cmp} ;
use itertools::Itertools ;
use std::collections::HashSet ;

fn main() {
    println!("Enter some integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s |
	  s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut valid_pairs : HashSet<Vec<i32>> = HashSet::new( ) ;
    numbers.into_iter( ).combinations( 2 ).filter( 
	  |vec| {
	  let abs_diff = (vec[0] - vec[1]).abs( ) ;
	  let mini = cmp::min( vec[0] , vec[1] ) ;
	  0 < abs_diff && abs_diff < mini 
	  } ).for_each( | vec|  { 
	     valid_pairs.insert(vec) ;
	     }) ;
    println!("{}" , valid_pairs.len( ) ) ;
}
