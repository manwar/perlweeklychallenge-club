use std::io ;

fn convert( term : &&str ) -> usize {
   if term.chars( ).all( | d | d.is_digit( 10 )) {
      term.parse::<usize>( ).unwrap( ) 
   }
   else {
      term.chars( ).count( ) 
   }
}

fn main() {
    println!("Please enter some strings , separated by words!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let terms : Vec<&str> = entered_line.split_whitespace( ).map( | s |
	  s.trim( ) ).collect( ) ;
    let mut converted : Vec<usize> = Vec::new( ) ;
    terms.iter( ).map( | w | convert( &w ) ).for_each( | d | 
	  converted.push( d ) ) ;
    println!("{}" , converted.iter( ).max( ).unwrap( ) ) ;
}
