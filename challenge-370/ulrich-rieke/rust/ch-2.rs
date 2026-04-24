use std::io ;

//to be scrambled , the two strings must have at least one split site
//where the splits in both words are anagrams of each other

fn is_anagram( first_word : &str , second_word : &str ) -> bool {
   use std::collections::HashMap ;
   let mut first_letters : HashMap<char , u16> = HashMap::new( ) ;
   let mut second_letters : HashMap<char , u16> = HashMap::new( ) ;
   for c in first_word.chars( ) {
      *first_letters.entry( c ).or_insert( 1 ) += 1 ;
   }
   for c in second_word.chars( ) {
      *second_letters.entry( c ).or_insert( 1 ) += 1 ;
   }
   first_letters == second_letters 
}

fn is_scrambled( first_word : &str , second_word : &str ) -> bool {
   let len : usize = first_word.chars( ).count( ) ;
   let first_str : String = first_word.to_string( ) ;
   let second_str : String = second_word.to_string( ) ;
   for i in 1 .. len - 1 {
      if (is_anagram( &first_str[0..i] , &second_str[0..i] ) && 
         is_anagram( &first_str[i..]  , &second_str[i..] )) || 
         ( is_anagram( &first_str[0..i] , &second_str[i..] ) && 
           is_anagram( &first_str[i..] , &second_str[0..i] ) ) {
            return true ;
      }
   }
   false 
}

fn main() {
    println!("Enter two strings of equal length!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let strings : Vec<&str> = inline.trim( ).split_whitespace( ).collect( ) ;
    println!("{}" , is_scrambled( strings[0] , strings[1] ) ) ;
}
