use std::io ;
use std::collections::HashMap ;

fn main() {
    println!("Enter a string with grouped digits only!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let mut frequencies : HashMap<char , usize> = HashMap::new( ) ;
    for c in inline.trim( ).chars( ) {
       *frequencies.entry( c ).or_insert( 0 ) += 1 ;
    }
    let mut numbers : Vec<usize> = Vec::new( ) ; 
    for c in frequencies.keys( ) {
       numbers.push( convert( *c , *frequencies.get( &c ).unwrap( ) ) ) ;
    }
    println!("{}" , numbers.into_iter( ).max( ).unwrap( ) ) ;
}

fn convert( letter : char , howmany : usize ) -> usize {
   if letter == '0' {
      0
   }
   else {
      let mut numberstring : String = String::new( ) ;
      for _ in 0..howmany {
         numberstring.push( letter ) ;
      }
      numberstring.parse::<usize>( ).unwrap( ) 
   }
}
