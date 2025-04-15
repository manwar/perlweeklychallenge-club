use std::io ;

fn main() {
    println!("Enter two strings separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let words : Vec<&str> = inline.trim( ).split_whitespace( ).collect( ) ;
    let first_word : &str = words[0] ;
    let second_word : &str = words[1] ;
    //the idea is: zip the two words. Then check whether there are only
    //2 non-identical letter pairs and whether these two pairs are in
    //reversed order to each other
    let zipped_letters : Vec<(char , char)> = first_word.chars( ).zip( 
	  second_word.chars( )).collect( ) ;
    let different_letters : Vec<(char, char)> = zipped_letters.into_iter( ).
       filter( |p| p.0 != p.1 ).collect( ) ;
    println!("{}" , different_letters.len( ) == 2 && {
	  let firstpair = different_letters[0] ;
	  let secondpair = different_letters[1] ;
	  firstpair.0 == secondpair.1 &&
	  firstpair.1 == secondpair.0
	  } ) ;
}
