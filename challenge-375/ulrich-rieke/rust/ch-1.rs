use std::io ;
use std::collections::HashMap ;

fn main() {
    println!("Enter some strings separated by blanks!");
    let mut firstline : String = String::new( ) ;
    io::stdin( ).read_line( &mut firstline ).unwrap( ) ;
    println!("Enter some more strings separated by blanks!" ) ;
    let mut secondline : String = String::new( ) ;
    io::stdin( ).read_line( &mut secondline).unwrap( ) ;
    let mut first_frequencies : HashMap<&str , usize> = HashMap::new( ) ;
    let mut second_frequencies : HashMap<&str , usize> = HashMap::new( ) ;
    let first_words : Vec<&str> = firstline.trim( ).split_whitespace( ).
       collect( ) ;
    let second_words : Vec<&str> = secondline.trim( ).split_whitespace( ).
       collect( ) ;
    first_words.into_iter().for_each( |w| *first_frequencies.entry( w ).
          or_insert( 0 ) += 1 ) ;
    second_words.into_iter( ).for_each( |w| *second_frequencies.entry( w ).
          or_insert( 0 ) += 1 ) ;
    let mut howmany : usize = 0 ;
    for w in first_frequencies.keys( ) {
       if first_frequencies.get( w ).is_some( ) && *first_frequencies.get
          ( w ).unwrap( ) == 1 && second_frequencies.get( w ).is_some( ) &&
             *second_frequencies.get( w ).unwrap( ) == 1 {
             howmany += 1 ;
       }
    }
    println!("{}" , howmany ) ;
}
