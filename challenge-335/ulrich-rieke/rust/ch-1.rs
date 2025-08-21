use std::io ;
use std::collections::{HashMap , HashSet} ;

fn count_characters( word : &str ) -> HashMap<char , usize> {
   let mut frequencies : HashMap<char , usize> = HashMap::new( ) ;
   for c in word.chars( ) {
      *frequencies.entry( c ).or_insert( 0 ) += 1 ;
   }
   frequencies 
}

fn main() {
    println!("Enter some words separated by whitespace!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let frequencylist : Vec<HashMap<char, usize>> = inline.trim( ).split_whitespace( ).map( 
	  |s| count_characters( s ) ).collect( ) ;
    let sets : Vec<HashSet<char>> = frequencylist.iter( ).map( |f| {
	  let keys = f.keys( ) ;
	  let mut keyset : HashSet<char> = HashSet::new( ) ;
	  for c in keys {
	    keyset.insert( *c ) ;
	   }
	   keyset 
	   }).collect( ) ;
    let common : HashSet<char> = sets.clone().into_iter( ).fold( sets[0].clone( ) , |mut acc , s| {
	  acc.retain( |item| s.contains( item ) ) ;
	  acc 
	  } ) ;
    let mut common_frequencies : Vec<(char , usize)> = Vec::new( ) ;
    for c in common {
       let mut numbers : Vec<usize> = Vec::new( ) ;
       for f in &frequencylist {
	  let num = f.get( &c ).unwrap( ) ;
	  numbers.push( *num ) ;
       }
       let mini = numbers.into_iter( ).min( ).unwrap( ) ;
       common_frequencies.push( (c , mini) ) ;
    }
    let mut solution : Vec<char> = Vec::new( ) ;
    for pair in common_frequencies {
       for _ in 0..pair.1 {
	  solution.push( pair.0 ) ;
       }
    }
    println!("{:?}" , solution ) ;
}
