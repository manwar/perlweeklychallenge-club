use std::io ;

fn main() {
    let mut input : String = String::new( ) ;
    println!("Enter a list of integers, separated by blanks!" ) ;
    io::stdin( ).read_line( &mut input).unwrap( ) ;
    let entered_line: &str = &*input ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).
      map( | s | s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut maximum : i32 = 0 ;
    if let Some( n ) = numbers.iter( ).max( ) {
      maximum = *n ;
    }
    if numbers.iter( ).any( | n | *n != maximum && maximum < 2 * *n ) {
      println!("-1") ;
    }
    else {
      println!("1") ;
    }
}
