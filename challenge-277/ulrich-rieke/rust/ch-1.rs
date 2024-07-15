use std::io ;
use std::collections::{HashMap , HashSet} ;

fn main() {
    println!("Enter some words, separated by blanks!");
    let mut first_line : String = String::new( ) ;
    io::stdin( ).read_line( &mut first_line).unwrap( ) ;
    let first_entered : &str = first_line.as_str( ).trim( ) ;
    println!("Enter more words , separated by blanks!" ) ;
    let mut sec_line : String = String::new( ) ;
    io::stdin( ).read_line( &mut sec_line ).unwrap( ) ;
    let sec_entered : &str = sec_line.as_str( ).trim( ) ;
    let first_words : Vec<&str> = first_entered.split_whitespace( ).
       collect( ) ;
    let second_words : Vec<&str> = sec_entered.split_whitespace( ).
       collect( ) ;
    let mut first_freq : HashMap<&str , usize> = HashMap::new( ) ;
    let mut second_freq : HashMap<&str , usize> = HashMap::new( ) ;
    first_words.iter( ).for_each( | s | {
	  first_freq.entry( s ).and_modify( |e| *e += 1 ).or_insert( 1 ) ;
	  } ) ;
    second_words.iter( ).for_each( | s | {
	  second_freq.entry( s ).and_modify( |e| *e += 1 ).or_insert( 1 ) ;
	  }) ;
    let mut first_set : HashSet<&str> = HashSet::new( ) ;
    let mut second_set : HashSet<&str> = HashSet::new( ) ;
    for w in &first_words {
       first_set.insert( w ) ;
    }
    for w in &second_words {
       second_set.insert( w ) ;
    }
    let mut sum : usize = 0 ;
    for e in first_set.intersection( &second_set ) {
       if *first_freq.get( e ).unwrap( ) == 1 &&
	  *second_freq.get( e ).unwrap( ) == 1 {
	     sum += 1 ;
	  }
    }
    println!("{}" , sum) ;
}
