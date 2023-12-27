use std::io ;
use std::collections::HashMap ;

fn main() {
    println!("Enter an even number of integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let mut numbers : Vec<i32> = entered_line.split_whitespace( ).map ( | s | 
	  s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut frequencies : HashMap<i32, u32> = HashMap::new( ) ;
    for i in & numbers {
       frequencies.entry( *i ).and_modify( |e| *e += 1 ).or_insert( 1 ) ;
    }
    if frequencies.values( ).all( | n | n % 2 == 0 ) {
       numbers.sort( ) ;
       let mut result : Vec<(i32 , i32)> = Vec::new( ) ;
       let len = numbers.len( ) ;
       let mut pos : usize = 0 ;
       while pos <= len - 2 {
	  let pair : (&i32 , &i32) = ( &numbers[ pos ] , &numbers[ pos + 1 ] ) ;
	  result.push( (*pair.0 , *pair.1 ) ) ;
	  pos += 2 ;
       }
       println!("{:?}" , result ) ;
    }
    else {
       println!("()") ;
    }
}
