use std::io ;
use std::collections::HashMap ;

fn main() {
    println!("Enter a string with English letters only!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let word : &str = inline.trim( ) ;
    let vowels : Vec<char> = vec!['a' , 'e' , 'i' , 'o' , 'u' , 'A' , 
        'E' , 'I' , 'O' , 'U'] ;
    let mut vowel_map : HashMap<char , usize> = HashMap::new( ) ;
    let mut consonant_map : HashMap<char , usize> = HashMap::new( ) ;
    for c in word.chars( ) {
       if vowels.contains( &c ) {
          *vowel_map.entry( c ).or_insert(0) += 1 ;
       }
       else {
          *consonant_map.entry( c ).or_insert( 0 ) += 1 ;
       }
    }
    let vowel_max : usize = {
       if vowel_map.len( ) > 0 {
          *vowel_map.values( ).max( ).unwrap( ) 
       }
       else {
          0 
       }
    } ;
    let conso_max : usize = {
       if consonant_map.len( ) > 0 {
          *consonant_map.values( ).max( ).unwrap( ) 
       }
       else {
          0
       }
    } ;
    println!("{}" , vowel_max + conso_max ) ; 
}
