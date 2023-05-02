use std::io ;

fn is_sorted( word : &str ) -> bool {
  let mut word_letters : Vec<char> = Vec::new( ) ;
  for c in word.chars( ) {
      word_letters.push( c ) ;
  }
  let mut compared_to : Vec<char> = word_letters.clone( ) ;
  compared_to.sort( ) ;
  compared_to == word_letters
}

fn main() {
    println!("Enter some words, separated by a blank!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let words : Vec<&str> = entered_line.split_whitespace( ).map( | s |
      s.trim( ) ).collect( ) ;
    println!( "{}" , words.iter( ).filter( | s | ! is_sorted( *s ) ).
      count( ) ) ;
}
