use std::io ;

fn main() {
    println!("Enter some positive integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let numbers : Vec<u32> = entered_line.split_whitespace( ).map( | s |
	  s.parse::<u32>( ).unwrap( ) ).collect( ) ;
    let result : bool = (0..numbers.len( )).all( | i | {
	  let number : u32 = numbers[ i ] ;
	  numbers.iter( ).filter( | &d | *d == (i as u32) ).count( ) == 
	  number as usize 
	  }) ;
    println!("{}" , result ) ;
}
