use std::io ;

fn main() {
    println!("Please enter a string!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let word = entered_line.trim( ) ;
    let vowels : &str = "aeiouAEIOU" ;
    let mut vowels_contained : String = String::new( ) ;
    for c in word.chars( ) {
       if vowels.contains( c ) {
	  vowels_contained.push( c ) ;
       }
    }
    let mut changed : String = String::new( ) ;
    for c in word.chars( ) {
       if vowels.contains( c ) {
	  let next_vowel : char = vowels_contained.pop( ).unwrap( ) ;
	  if changed.len( ) == 0 {
	     changed.push_str( &next_vowel.to_uppercase( ).to_string( )) ;
	  }
	  else {
	     changed.push_str( &next_vowel.to_lowercase( ).to_string( ) ) ;
	  }
       }
       else {
	  changed.push( c ) ;
       }
    }
    println!("{:?}" , changed) ;
}
