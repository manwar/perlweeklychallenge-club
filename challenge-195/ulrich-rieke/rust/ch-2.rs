use std::io ;
use std::collections::HashMap ;

fn main() {
  let mut input : String = String::new( ) ;
  println!("Please enter some integers, separated by a space!");
  io::stdin( ).read_line( &mut input ).unwrap( ) ;
  let entered_line : &str = &*input ;
  let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s |
    s.trim( ).parse::<i32>( ).unwrap( )).collect( ) ;
  let mut evens : Vec<i32> = Vec::new( ) ;
  numbers.iter( ).filter( | &d | *d % 2 == 0).for_each( | i |
    evens.push( *i )) ;
  if evens.len( ) != 0 {
      let mut evens_freq = HashMap::new( ) ;
      for d in &evens {
    let counter = evens_freq.entry( d ).or_insert( 0 ) ;
    *counter += 1 ;
      }
      let mut freq_count : Vec<(&i32, i32)> = evens_freq.into_iter( ).collect( ) ;
      freq_count.sort_by( | a , b | b.1.cmp( &a.1 ) ) ;
      if freq_count[0].1 != freq_count[1].1 {
    println!("{}" , freq_count[0].0 ) ;
      }
      else {
    evens.sort( ) ;
    println!("{}" , evens[0] ) ;
      }
  }
  else {
      println!("-1") ;
  }
}
