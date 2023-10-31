use std::io ;
use itertools::Itertools ;

fn main() {
    println!("Enter at least 3 integers in increasing order!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    println!("Enter a positive integer!" ) ;
    let mut secondline : String = String::new( ) ;
    io::stdin( ).read_line( &mut secondline ).unwrap( ) ;
    let another_line : &str = &*secondline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( 
	  | s | s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    let numline = another_line.trim( ) ;
    let diff : i32 = numline.parse::<i32>( ).unwrap( ) ;
    let it = (0..numbers.len( )).combinations( 3 ) ;
    let mut result : u32 = 0 ;
    for a_combi in it {
       let mut selected : Vec<i32> = Vec::new( ) ;
       for i in a_combi {
	  selected.push( numbers[ i ] ) ;
       }
       if selected[ 1 ] - selected[ 0 ] == diff &&
	  selected[ 2 ] - selected[ 1 ] == diff {
	     result += 1 ;
	}
    }
    println!("{}" , result ) ;
}
