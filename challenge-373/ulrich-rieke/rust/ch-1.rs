use std::io ;

fn main() {
    println!("Enter some strings separated by blanks!");
    let mut firstline : String = String::new( ) ;
    io::stdin( ).read_line( &mut firstline ).unwrap( ) ;
    println!("Enter some more strings separated by blanks!") ;
    let mut secondline : String = String::new( ) ;
    io::stdin( ).read_line( &mut secondline).unwrap( ) ;
    let first_words : Vec<&str> = firstline.trim( ).split_whitespace( ).collect( ) ;
    let second_words : Vec<&str> = secondline.trim( ).split_whitespace( ).collect( ) ;
    let mut first_sentence : String = String::new( ) ;
    let mut second_sentence : String = String::new( ) ;
    first_words.iter( ).for_each( |w| first_sentence.push_str( w ) ) ;
    second_words.iter( ).for_each( |w| second_sentence.push_str( w ) ) ;
    println!("{}" , first_sentence == second_sentence ) ;
}
