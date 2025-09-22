use std::io ;
use regex::Regex ;

fn main() {
    println!("Enter a sentence with words consisting of lowercase English");
    println!("or of digits with no leading zeroes only!") ;
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let words : Vec<&str> = inline.trim( ).split_whitespace( ).collect( ) ;
    let num = Regex::new( r"^[1-9][0-9]*$").unwrap( ) ;
    let numbers : Vec<u32> = words.into_iter( ).filter( |w| num.is_match( w ) ).
       map( |w| w.parse::<u32>( ).unwrap( )).collect( ) ;
    let mut differences : Vec<u32> = Vec::new( ) ;
    for d in 1..numbers.len( ) {
       differences.push( numbers[d] - numbers[d - 1] ) ;
    }
    println!("{}" , differences.into_iter( ).all( |d| d > 0 ) ) ;
}
