use itertools::Itertools ;
use std::collections::HashSet ;
use std::io ;

fn replace_all( original : &str , positions : &Vec<usize> ,
      replacement : &str) -> String { 
   let mut replaced : String = original.into( ) ;
   let mut n : usize = 0 ;
   for c in replacement.chars( ) {
      let pos : usize = positions[n] ;
      replaced.remove( pos ) ;
      replaced.insert( pos , c ) ;
      n += 1 ;
   }
   replaced 
}

fn main() {
    println!("Enter a word consisting of 0 , 1 and ? only!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let word : &str = inline.trim( ) ;
    let question_marks : Vec<usize> = word.char_indices( ).filter( |&p| 
          p.1 == '?' ).map( |p| p.0 ).collect( ) ;
    if question_marks.len( ) == 0 {
       println!( "(\"{}\")" , word ) ;
    }
    else {
       let mut replacements : Vec<char> = Vec::new( ) ;
       let len : usize = question_marks.len( ) ;
       for _ in 0..len {
          replacements.push( '0' ) ;
          replacements.push( '1' ) ;
       }
       let mut combis : HashSet<String> = HashSet::new( ) ;
       for v in replacements.into_iter( ).combinations( len ) {
          let mut repl : String = String::new( ) ;
          for c in v {
             repl.push( c ) ;
          }
          let w : &str = &repl[..] ;
          let replaced : String = replace_all( word , &question_marks , w ) ;
          combis.insert( replaced.clone( ) ) ;
       }
       let mut solution : Vec<String> = combis.into_iter( ).collect( ) ;
       solution.sort( ) ;
       println!("{:?}" , solution ) ;
    }
}
