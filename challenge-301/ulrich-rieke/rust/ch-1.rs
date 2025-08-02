use std::io ;
use itertools::Itertools ;

fn main() {
    println!("Enter some integers separated by whitespace!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<u16> = inline.trim( ).split_whitespace( ).map( 
	  |s| s.parse::<u16>( ).unwrap( ) ).collect( ) ;
    let len : usize = numbers.len( ) ;
    let mut longies : Vec<u64> = Vec::new( ) ;
    for vec in numbers.into_iter( ).permutations( len ) {
       let mut total : String = String::new( ) ;
       for n in vec {
	  let numstring : String = n.to_string( ) ;
	  total.push_str( & numstring ) ;
       }
       let a_long_number : u64 = total.parse::<u64>( ).unwrap( ) ;
       longies.push( a_long_number ) ;
    }
    println!("{}" , longies.into_iter( ).max( ).unwrap( ) ) ;
}
