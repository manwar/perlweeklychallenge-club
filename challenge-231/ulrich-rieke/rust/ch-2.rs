use std::io ;

fn main() {
    println!("Enter some passenger details!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let tickets : Vec<&str> = entered_line.split_whitespace( ).map( 
	  | s | s.trim( ) ).collect( ) ;
    let count : usize = tickets.iter( ).filter( | &t | {
	  let substring = &t[11..13] ;
	  let age : u8 = substring.parse::<u8>( ).unwrap( ) ;
	  age >= 60u8 
	  }).count( ) ;
    println!("{}" , count ) ;
}
