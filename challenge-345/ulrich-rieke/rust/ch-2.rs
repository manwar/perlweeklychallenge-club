use std::io ;
use std::collections::VecDeque ;

fn main() {
    println!("Enter some integers and -1 separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace().map( |s|
	  s.parse::<i32>( ).unwrap( )).collect( ) ;
    let mut seen : VecDeque<i32> = VecDeque::new( ) ;
    let mut answer : Vec<i32> = Vec::new( ) ;
    let mut x : usize = 0 ;
    let len : usize = numbers.len( ) ;
    let mut pos : usize = 0 ;
    while pos < len {
       let n : i32 = numbers[pos] ;
       if n > 0 {
	  x = 0 ;
	  seen.push_front( n ) ;
       }
       else {
	  if x < seen.len( ) {
	     answer.push( *seen.get( x ).unwrap( ) ) ;
	     }
	  else {
	     answer.push( -1 ) ;
	  }
	  if pos < len - 1 && numbers[pos + 1] == -1 {
	     x += 1 ;
	  }
       }
       pos += 1 ;
    }
    println!("{:?}" , answer ) ;
}
