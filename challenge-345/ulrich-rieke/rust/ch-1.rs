use std::io ;

fn main() {
    println!("Enter at least 3 integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s| 
	  s.parse::<i32>( ).unwrap( )).collect( ) ;
    let mut indices : Vec<usize> = Vec::new( ) ;
    for i in 1..numbers.len( ) -1 {
       if numbers[i] > numbers[i - 1] && numbers[i] > numbers[i + 1] {
	  indices.push( i ) ;
       }
    }
    println!("{:?}" , indices ) ;
}
