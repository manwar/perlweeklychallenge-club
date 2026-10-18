use itertools::Itertools ;
use std::io ;

fn condition( words : &Vec<&str> ) -> bool {
   let mut final_strings : Vec<String> = Vec::new( ) ;
   for i in 0..words.len( ) {
      let mut current_string : String = String::new( ) ;
      for w in words {
         let current_letter : char = w.chars( ).nth( i ).unwrap( ) ;
         current_string.push( current_letter ) ;
      }
      final_strings.push( current_string.clone( )) ;
      current_string.clear( ) ;
   }
   final_strings == *words
}

fn main() {
    println!("Enter some words with equal lengths!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let words : Vec<&str> = inline.trim( ).split_whitespace( ).collect( ) ;
    let l : usize = words[0].chars( ).count( ) ;
    let all_combis : Vec<Vec<&str>> = words.into_iter( ).permutations( l ).
       collect( );
    println!("{:?}" , all_combis.iter( ).filter( |&v| condition( &v )).
             collect::<Vec<&Vec<&str>>>()) ;
}
