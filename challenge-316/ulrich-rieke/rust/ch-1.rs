use std::io ;

fn main() {
    println!("Enter some words separated by whitespace!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let words : Vec<&str> = inline.trim( ).split_whitespace( ).collect( ) ;
    let mut pairs : Vec<(char , char)> = Vec::new( ) ;
    let len = words.len( ) ;
    for i in 0..len - 1 {
       let last_char : char = words[i].chars( ).last( ).unwrap( ) ;
       let first_char : char = words[i + 1].chars( ).nth( 0 ).unwrap( ) ;
       pairs.push( (last_char , first_char) ) ;
    }
    println!("{}" , pairs.into_iter( ).all( |p| p.0 == p.1) ) ;
}
