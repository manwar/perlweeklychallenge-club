use std::io;
use itertools::Itertools ;

fn main() {
    println!("Enter some integers separated by whitespace!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s| 
	  s.parse::<i32>( ).unwrap( )).collect( ) ;
    let all_combis : Vec<Vec<i32>> = numbers.into_iter( ).combinations( 2 )
       .collect( ) ;
    println!("{}" , all_combis.into_iter( ).map( |v| v[0].abs_diff( v[1] )).
	     min( ).unwrap( ) ) ;
}
