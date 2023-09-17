use std::io ;
use std::collections::HashMap ;

fn main() {
    println!("Enter some words, separated by spaces!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let words : Vec<&str> = entered_line.split_whitespace( ).map( | s | 
	  s.trim( ) ).collect( ) ;
    let mut frequencies : HashMap<char , usize> = HashMap::new( ) ;
    for c in words[0].chars( ) {
       let value = frequencies.entry( c ).or_default( ) ;
       *value += 1 ;
    }
    for (k , v) in frequencies.iter_mut( ) {
       for i in 1..words.len( ) {
	  let count : usize = words[ i ].chars( ).filter( | &w | w == 
		*k ).count( ) ;
	  if count < *v {
	     *v = count ;
	  }
       }
    }
    let mut solution : Vec<char> = Vec::new( ) ;
    for ( k , v ) in &frequencies {
       if v > &0 {
	  for _ in 0..*v {
	     solution.push( *k ) ;
	  }
       }
    }
    println!("{:?}" , solution ) ;
}
