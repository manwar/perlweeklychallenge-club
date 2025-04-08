use std::io ;

fn main() {
    println!("Enter two strings , one shorter and one longer!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_words : Vec<&str> = inline.trim( ).split_whitespace( ).
       collect( ) ;
    let first_word : &str = entered_words[0] ;
    let second_word : &str = entered_words[1] ;
    let mut second_line : String = second_word.into( ) ;
   //assume result to be true
    let mut result : bool = true ;
    for c in first_word.chars( ) {
       //for every letter in the first word , look for it in the second
       //word and throw everything up to that point away
       //if you don't find anything, result is false!
       if let Some( pos ) = second_line.find( c ) {
	  second_line.drain(..pos) ;
       }
       else {
	  result = false ;
	  break ;
       }
    }
    println!("{}" , result ) ;
}
