use std::io ;
use itertools::Itertools ;

fn main() {
    println!("Enter some distinct integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s| 
	  s.parse::<i32>( ).unwrap( )).collect( ) ;
    let pairs : Vec<Vec<i32>> = numbers.into_iter( ).combinations( 2 ).
       collect( ) ;
    let min_diff : u32 = pairs.iter( ).map( |v| v[0].abs_diff(v[1] ) ).
       min( ).unwrap( ) ;
    println!("{:?}" , pairs.into_iter( ).filter( |v| v[0].abs_diff(v[1]) 
	     == min_diff ).collect::<Vec<Vec<i32>>>( ) ) ;
}
