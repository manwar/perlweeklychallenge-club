use std::io ;
use std::collections::HashMap ;

fn to_diff_vec( word : &str ) -> Vec<i8> {
   let mut differences : Vec<i8> = Vec::new( ) ;
   let len : usize = word.chars( ).count( ) ;
   for i in 1..len {
      let first : u8 = word.chars( ).nth( i ).unwrap( ) as u8 ;
      let second : u8 = word.chars( ).nth( i - 1 ).unwrap( ) as u8 ;
      differences.push( (first as i8) - (second as i8) ) ;
   }
   differences 
}

fn main() {
    println!("Enter some words of equal length greater than 1!");
    let mut inline : String = String::new( ) ;
    io::stdin().read_line( &mut inline ).unwrap( ) ;
    let words : Vec<&str> = inline.trim( ).split_whitespace().collect( ) ;
    let word_differences : Vec<(&&str , Vec<i8>)> = words.iter( ).
       map( |s| (s , to_diff_vec( s ))).collect( ) ;
    let mut frequencies : HashMap<Vec<i8> , usize> = HashMap::new( ) ;
    for p in &word_differences {
       *frequencies.entry( p.1.clone( )).or_insert( 0 ) += 1 ;
    }
    let uniques : Vec<Vec<i8>> = frequencies.into_iter( ).filter( |p|
          p.1 == 1 ).map( |p| p.0 ).collect( ) ;
    let mut solution : Vec<&str> = Vec::new( ) ;
    for p in &uniques {
       for pair in &word_differences {
          if pair.1 == *p {
             solution.push( pair.0 ) ;
          }
       }
    }
    println!("{:?}" , solution[0] ) ;
}
