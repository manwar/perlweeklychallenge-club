use std::{io , cmp}  ;

fn main() {
    println!("Enter an number of integers( there must be a 2 exponent of them!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let mut numbers : Vec<u32> = entered_line.split_whitespace( ).map( |s| 
	  s.parse::<u32>( ).unwrap( ) ).collect( ) ;
    while numbers.len( ) > 1 {
       let mut last_was_min : bool = false ;
       let slice = &numbers[..] ;
       let mut chu = slice.chunks( 2 ) ;
       let mut intermediate : Vec<u32> = Vec::new( ) ;
       while let Some( p ) = chu.next( ) {
	  if last_was_min {
	     let maxi = cmp::max( p[0] , p[1] ) ;
	     intermediate.push( maxi ) ;
	     last_was_min = false ;
	  }
	  else {
	     let mini = cmp::min( p[0] , p[1] ) ;
	     intermediate.push( mini ) ;
	     last_was_min = true ;
	  }
       }
       numbers = intermediate ;
    }
    println!("{}" , numbers[0] ) ;
}
