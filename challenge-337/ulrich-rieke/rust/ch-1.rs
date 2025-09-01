use std::io ;

fn main() {
    println!("Enter some integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s|
	  s.parse::<i32>( ).unwrap( )).collect( ) ;
    let mut solution : Vec<usize> = Vec::new( ) ;
    for p in 0..numbers.len( ) {
       let c : usize = numbers.iter( ).filter( |&n| *n <= numbers[p] ).count( ) ;
       //if c is greater than 0 we have to subtract 1 to exclude the number itself!
       if c > 0 {
	  solution.push( c - 1) ;
       }
       else {
	  solution.push( 0 ) ;
       }
    }
    println!("{:?}" , solution ) ;
}
