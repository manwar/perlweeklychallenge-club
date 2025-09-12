use std::io ;

fn main() {
    println!("Enter some integers separated by whitespace!");
    let mut firstline : String = String::new( ) ;
    io::stdin( ).read_line( &mut firstline ).unwrap( ) ;
    let firstnumbers : Vec<i32>= firstline.trim( ).split_whitespace( ).
       map( |s| s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    println!("Enter some more integers separated by whitespace!") ;
    let mut secondline : String = String::new( ) ;
    io::stdin( ).read_line( &mut secondline ).unwrap( ) ;
    let secondnumbers : Vec<i32> = secondline.trim( ).split_whitespace( ).
       map( |s| s.parse::<i32>( ).unwrap( )).collect( ) ;
    let mut differences : Vec<u32> = Vec::new( ) ;
    for m in &firstnumbers {
       for n in &secondnumbers {
	  differences.push( m.abs_diff(*n) ) ;
       }
    }
    println!("{}" , differences.into_iter( ).max( ).unwrap( ) ) ;
}
