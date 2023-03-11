use std::io ;

fn main() {
  let row1 = "qwertyuiop" ;
  let row2 = "asdfghjkl" ;
  let row3 = "zxcvbnm" ;
  println!("Enter some words, separated by blanks!");
  let mut inline : String = String::new( ) ;
  io::stdin( ).read_line( &mut inline ).unwrap( ) ;
  let entered_line : &str = &*inline ;
  let entered_words : Vec<(usize, &str)> = entered_line.split_whitespace( ).
      enumerate( ).map( |(i , s)| (i , s.trim( ))).collect( ) ;
  let all_words : Vec<(&usize , String)> = entered_words.iter( ).map( | (i , s ) |
    (i , s.trim( ).to_ascii_lowercase( ) )).collect( ) ;
  let mut solution : Vec<String> = Vec::new( ) ;
  all_words.iter( ).filter( | (_i , s ) | {
    let a_word : &str = s.as_str( ) ;
      a_word.chars( ).all( | c | row1.contains( c ) ) ||
      a_word.chars( ).all( | c | row2.contains( c ) ) ||
      a_word.chars( ).all( | c | row3.contains( c ))
      }).for_each( | (i , _w )| solution.push( entered_words[**i].1.to_string( )) ) ;
  println!("{:?}" , solution ) ;
}
