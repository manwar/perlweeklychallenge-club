use std::io ;
use std::collections::HashMap ;

fn is_good( a_word : &&str , comparator : &&str ) -> bool {
  let mut word_map = HashMap::new( ) ;
  let mut comp_map = HashMap::new ( ) ;
  for c in a_word.chars( ) {
      let value : &mut usize = word_map.entry( c ).or_default( ) ;
      *value += 1 ;
  }
  for c in comparator.chars( ) {
      let value : &mut usize = comp_map.entry( c ).or_default( ) ;
      *value += 1 ;
  }
  for c in a_word.chars( ) {
      if ! ( comp_map.contains_key( &c ) && comp_map.get( &c).unwrap( )
        >= word_map.get( &c).unwrap( ) ) {
    return false ;
      }
  }
  true
}

fn main() {
    println!("Please enter some words , separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let words_line : &str = &*inline ;
    let words_entered : Vec<&str> = words_line.split_whitespace( ).
      map( | s | s.trim( ) ).collect( ) ;
    println!("Enter a word you want to take the characters from!" ) ;
    let mut word_line : String = String::new( ) ;
    io::stdin( ).read_line( &mut word_line).unwrap( ) ;
    let comp_line : &str = &*word_line ;
    let mut lengths : Vec<usize> = Vec::new( ) ;
    for w in words_entered {
      if is_good( &w , &comp_line ) {
      lengths.push( w.len( ) ) ;
      }
    }
    println!("{}" , lengths.iter( ).sum::<usize>( ) ) ;
}
