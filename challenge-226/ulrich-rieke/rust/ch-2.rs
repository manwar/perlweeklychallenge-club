use std::io ;

fn main() {
    println!("Please enter some positive integers, separated by blanks");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let mut numbers : Vec<i32> = entered_line.split_whitespace( ).map( 
	  | s | s.trim( ).parse::<i32>( ).unwrap( )).collect( ) ;
    let mut rounds : u32 = 0 ;
    while ! numbers.iter( ).all( | n | *n == 0 ) {
       let smallest_pos : i32 = *numbers.iter( ).filter( | n | **n > 0 ).
	  min( ).unwrap( ) ;
       for n in numbers.iter_mut( ) {
	  *n -= smallest_pos ;
	  if *n < 0 {
	     *n = 0 ;
	  }
       }
       rounds += 1 ;
    }
    println!("{}" , rounds) ;
}
