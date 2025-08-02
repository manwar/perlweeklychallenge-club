use std::io ;

fn main() {
    println!("Enter two strings, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let strings : Vec<&str> = entered_line.split_whitespace( ).map( | s |
	  s.trim( ) ).collect( ) ;
    let mut merged : String = String::new( ) ;
    let first_string : &str = strings[0] ;
    let second_string : &str = strings[1] ;
    first_string.chars( ).zip( second_string.chars( )).for_each( | p | {
	  merged.push( p.0 ) ;
	  merged.push( p.1 ) 
	  } ) ;
    let len1 : usize = first_string.len( ) ;
    let len2 : usize = second_string.len( ) ;
    if len1 != len2 {
       let smaller : usize = merged.len( ) / 2 ;
       if len1 > len2 {
	  for i in smaller .. len1 {
	     merged.push( first_string.chars( ).nth( i ).unwrap( ) ) ;
	  }
       }
       else {
	  for i in smaller .. len2 {
	     merged.push( second_string.chars( ).nth( i ).unwrap( ) ) ;
	  }
       }
    }
    println!("{:?}" , merged) ;
}
