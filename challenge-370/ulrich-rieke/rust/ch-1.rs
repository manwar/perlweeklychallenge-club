use std::io ;
use std::collections::HashMap ;

fn convert( word : &String ) -> String {
   let mut converted : String = String::new( ) ;
   let w = word.as_str( ) ;
   for c in w.chars( ) {
      if c.is_ascii_uppercase( ) {
         converted.push(c.to_ascii_lowercase( ) ) ;
      }
      if c.is_ascii_lowercase( ) {
         converted.push( c ) ;
      }
   }
   converted
}

fn main() {
    println!("Enter a paragraph!");
    let mut parastring : String = String::new( ) ;
    io::stdin( ).read_line( &mut parastring ).unwrap( ) ;
    println!("Enter some banned words , separated by blanks!") ;
    let mut bannedstring : String = String::new( ) ;
    io::stdin( ).read_line( &mut bannedstring ).unwrap( ) ;
    let mut para_vec : Vec<String> = parastring.trim( ).split_whitespace( ).
       map( |s| {
             let st : String = s.to_string( ) ;
             st } ).collect( ) ;
    if para_vec.len( ) == 1 {
       let first_word : String = para_vec[0].clone( ) ;
       let fw = &first_word[..] ;
       para_vec = fw.split( |c: char| c.is_ascii_punctuation( ) ).map( |s| {
             let st = s.to_string( ) ;
             st }).collect( ) ;
    }
    let ban_vec : Vec<String> = bannedstring.trim( ).split_whitespace( ).
       map( |s| {
             let st : String = s.to_string( ) ;
             st } ).collect( ) ;
    let mut frequencies : HashMap<String , u16> = HashMap::new( ) ;
    para_vec.iter_mut().map( |st| convert( &st ) ).filter( |st| ! ban_vec.contains( &st)).
       for_each( |st| *frequencies.entry( st ).or_insert( 1 ) += 1 ) ;
    let most_freq : u16 = *frequencies.values( ).max( ).unwrap( ) ; 
    let mut it = frequencies.iter( ) ;
    let mut solution : String = String::new( ) ;
    while let Some( pos ) = it.next( ) {
       if *pos.1 == most_freq {
          solution = pos.0.clone( ) ;
       }
    }
    println!("{:?}" , solution ) ;
}
