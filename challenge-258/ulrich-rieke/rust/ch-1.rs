use std::io ;

fn main() {
    println!("Enter some positive integers, separated by spaces!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<&str> = entered_line.split_whitespace( ).map( | s | 
	  s.trim( )).collect( ) ;
    let result = numbers.iter( ).filter( | &x | x.len( ) % 2 == 0 ).
       count( ) ;
    println!("{}" , result) ;
}
