use std::io ;

//find the indices of those elements that can be deleted , if any
fn find_indices( words : &Vec<&str> ) -> Vec<usize> {
   let enumerated : Vec<(usize, &&str)> = words.iter( ).enumerate( ).
      collect( ) ;
   let enu_slice = &enumerated[..] ;
   let mut iter = enu_slice.windows( 2 ) ;
   let mut positions : Vec<usize> = Vec::new( ) ;
   while let Some( wi ) = iter.next( ) {
      if are_anagrams( wi[0].1 , wi[1].1 ) {
	 positions.push( wi[0].0 ) ;
      }
   }
   positions 
}

fn are_anagrams( word1 : &str , word2 : &str ) -> bool {
   let mut first_letters : Vec<char> = Vec::new( ) ;
   let mut second_letters : Vec<char> = Vec::new( ) ;
   for c in word1.chars( ) {
      first_letters.push( c ) ;
   }
   for c in word2.chars( ) {
      second_letters.push( c ) ;
   }
   first_letters.sort( ) ;
   second_letters.sort( ) ;
   first_letters == second_letters 
}

fn main() {
    println!("Enter some words separated by whitespace!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let words : Vec<&str> = inline.trim( ).split_whitespace( ).
       collect( ) ;
    let positions : Vec<usize> = find_indices( &words ) ;
    println!("{}" , words.len( ) - positions.len( )) ;
}
