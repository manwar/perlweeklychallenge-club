use std::io ;
use std::collections::HashSet ;

fn main() {
    println!("Enter some words, separated by blanks!") ;
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let mut char_sets : Vec<HashSet<char>> = Vec::new( ) ;
    entered_line.split_whitespace( ).map ( | s | s.trim( ) ).
      for_each( | s | {
        let mut word_chars : HashSet<char> = HashSet::new( ) ;
        for c in s.chars( ) {
          word_chars.insert( c.to_ascii_lowercase( ) ) ;
        }
        char_sets.push( word_chars )
        }
    ) ;
    let len = char_sets.len( ) ;
    let mut all_chars : Vec<char> = Vec::new( ) ;
    if len == 1 {
      char_sets[0].iter( ).for_each( | m | all_chars.push( *m ) ) ;
    }
    else {
      let mut old_intersection : HashSet<char> = char_sets[0].clone( ) ;
      for i in 1..len {
      let mut new_intersection : HashSet<char> = HashSet::new( ) ;
      for c in old_intersection.intersection( &char_sets[ i ] ) {
        new_intersection.insert( *c ) ;
      }
      old_intersection = new_intersection ;
      }
      for c in old_intersection.iter( ) {
      all_chars.push( *c ) ;
      }
    }
    all_chars.sort( ) ;
    println!("{:?}" , all_chars) ;
}
