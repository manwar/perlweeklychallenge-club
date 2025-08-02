use std::io ;

fn main() {
    println!("Enter some integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s| 
	  s.parse::<i32>( ).unwrap( )).collect( ) ;
    let mut solution : Vec<i32> = Vec::new( ) ;
    let len : i32 = numbers.len( ) as i32 ;
    for i in 1i32..=len {
       if ! numbers.contains( &i ) {
	  solution.push( i ) ;
       }
    }
    println!("{:?}" , solution ) ;
}
