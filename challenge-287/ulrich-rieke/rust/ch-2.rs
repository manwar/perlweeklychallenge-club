use std::io ;
use regex::Regex ;

fn main() {
    println!("Enter a string!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let integer = Regex::new( r"^[+-]?\d+([eE]?[+-]?\d+)*$" ).unwrap( ) ;
    let decimal = Regex::new( r"^[-+]?\d+\.([eE]?[+-]?\d+)*$|^[-+]*\d+\.
	  \d+([eE]?[+-]?\d+)*$|^[-+]?\.\d+([eE]?[+-]?\d+)*$").unwrap( ) ;
    if integer.is_match( entered_line ) || decimal.is_match( entered_line ) {
       println!("true") ;
    }
    else {
       println!("false") ;
    }
}
