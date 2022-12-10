use std::io ;
use std::collections::HashMap ;

fn main() {
    println!("Please enter a string consisting of lowercase letters!") ;
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( & mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let mut frequencies = HashMap::new( ) ;
    for c in entered_line.trim( ).chars( ) {
      let counter = frequencies.entry( c ).or_insert( 0 ) ;
      *counter += 1 ;
    }
    let maximum = frequencies.values( ).max( ).unwrap( ) ;
    let minimum = frequencies.values( ).min( ).unwrap( ) ;
    let letter_count = frequencies.iter( ).count( ) ;
    let howmany = frequencies.iter( ).filter( |( _ , a )| **a == *minimum)
      .count( ) ;
    if *maximum == *minimum + 1 && howmany == letter_count - 1 {
      println!("1") ;
    }
    else {
      println!("0") ;
    }
}
