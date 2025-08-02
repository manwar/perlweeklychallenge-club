use std::io ;
use itertools::Itertools ;

fn main() {
    println!("Enter some integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<u32> = inline.trim( ).split_whitespace( ).map( |s| 
	  s.parse::<u32>( ).unwrap( )).collect( ) ;
    let all_subsets : Vec<Vec<u32>> = numbers.into_iter( ).powerset( ).
       collect( ) ;
    let totals : Vec<u32> = all_subsets.into_iter( ).map( |v| v.iter( ).
	  fold(0 , |acc , n| acc ^ n ) ).collect( ) ;
    println!("{}" , totals.into_iter( ).sum::<u32>( ) ) ;
}
