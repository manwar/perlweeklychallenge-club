use std::io ;
use std::collections::HashMap ;

fn find_string_difference( input : &str , lv : &HashMap<char, i32>) -> i32 {
  let mut letters : Vec<char> = Vec::new( ) ;
  for c in input.chars( ) {
      letters.push( c ) ;
  }
  let len = letters.len( ) ;
  let mut differences : Vec<i32> = Vec::new( ) ;
  for i in 0..len - 1 {
      differences.push( lv.get( &letters[ i + 1 ]).unwrap( ) -
        lv.get( &letters[ i ]).unwrap( )) ;
  }
  let mut results : Vec<i32> = Vec::new( ) ;
  while results.len( ) != 1 {
      let l = differences.len( ) ;
      for i in 0..l - 1 {
    results.push( differences[ i + 1 ] - differences[ i ] ) ;
      }
      if results.len( ) > 1 {
    differences.clear( ) ;
    for i in 0..results.len( ) {
        differences.push( results[ i ] ) ;
    }
    results.clear( ) ;
      }
  }
  results[0]
}

fn main() {
  let mut letter_values = HashMap::new( ) ;
  letter_values.insert( 'a' , 0 ) ;
  let mut pos : i32 = 1 ;
  for c in 'b'..='z' {
      letter_values.insert( c , pos ) ;
      pos += 1 ;
  }
  let mut input : String = String::new( ) ;
  println!("Enter some strings of same length separated by a blank!" ) ;
  io::stdin( ).read_line( &mut input ).unwrap( ) ;
  let entered_line : &str = &*input ;
  let inputstrings : Vec<&str> = entered_line.split_whitespace( )
      .map( | s | s.trim( ) ).collect( ) ;
  let mut below_zero : Vec<&str> = Vec::new( ) ;
  let mut zero : Vec<&str> = Vec::new( ) ;
  let mut above_zero : Vec<&str> = Vec::new( ) ;
  inputstrings.iter( ).filter( | s | find_string_difference( s ,
        &letter_values ) < 0 ).for_each( | s | below_zero.push( s )) ;
  inputstrings.iter( ).filter( | s | find_string_difference( s ,
        &letter_values ) == 0 ).for_each( | s |
        zero.push( s )) ;
  inputstrings.iter( ).filter( | s | find_string_difference( s ,
        &letter_values ) > 0 ).for_each( | s |
        above_zero.push( s ) ) ;
  let ordered : Vec<&Vec<&str>> = vec![&below_zero , &zero , &above_zero] ;
  if ordered.iter( ).all( | &vector | vector.len( ) != 1 ) {
      println!("No distinctive string can be found!" ) ;
  }
  else {
      let pos: usize = ordered.iter( ).position( | &v | v.len( ) == 1 )
    .unwrap( ) ;
      let selected : Vec<&str> = ordered[ pos ].to_vec( ) ;
      println!("{:?}" , selected[0] ) ;
  }
}
