use std::io ;
use std::collections::VecDeque ;

fn concatenate_nums( numbers : &VecDeque<&str> ) -> i32 {
   let mut concatenated : String = String::new( ) ;
   concatenated.push_str( numbers[ 0 ] ) ;
   let len = numbers.len( ) ;
   concatenated.push_str( numbers[ len - 1 ] ) ;
   let transformed = concatenated.as_str( ) ;
   transformed.parse::<i32>( ).unwrap( ) 
}

fn main() {
    println!("Enter some integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let mut numberstrings : VecDeque<&str> = entered_line
       .split_whitespace( ).map( 
	  | s | s.trim( ) ).collect( ) ;
    let mut sum : i32 = 0 ;
    while numberstrings.len( ) > 0 {
       if numberstrings.len( ) > 1 {
	  sum += concatenate_nums( &numberstrings ) ;
	  numberstrings.pop_front( ).unwrap( ) ;
	  numberstrings.pop_back( ).unwrap( ) ;
       }
       else {
	  let first : i32 = match numberstrings.pop_front( ) {
	     Some(string) => string.parse::<i32>( ).unwrap( ) ,
	     None        => 0 
	  } ;
	  sum += first ;
       }
    }
    println!("{}" , sum ) ;
}
