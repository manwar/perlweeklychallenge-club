use std::io ;

fn main() {
    println!("Enter some words separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    println!("Enter another word!") ;
    let mut secondline : String = String::new( ) ;
    io::stdin( ).read_line( &mut secondline ).unwrap( ) ;
    let words : Vec<&str> = inline.trim( ).split_whitespace( ).collect( ) ;
    let compared_to : String = secondline.trim( ).into( ) ;
    let mut first_letters : String = String::new( ) ;
    for w in &words {
       let firstletter : char = w.chars( ).nth( 0 ).unwrap( ) ;
       first_letters.push( firstletter ) ;
    }
    println!("{}" , first_letters == compared_to ) ;
}
