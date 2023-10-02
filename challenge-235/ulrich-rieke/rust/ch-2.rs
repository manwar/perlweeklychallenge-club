use std::io ;

fn main() {
    println!("Enter some integers, separated by spaces!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s | 
	  s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    let len = numbers.len( ) ;
    let mut result : Vec<i32> = Vec::new( ) ;
    for i in &numbers {
       if *i != 0 {
	  result.push( *i ) ;
       }
       else {
	  for _ in 0..2 {
	     result.push( 0 ) ;
	  }
       }
    }
    let result_slice = &result[0..len] ;
    let result = result_slice.to_vec( ) ;
    println!("{:?}" , result ) ;
}
