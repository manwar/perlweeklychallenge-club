use std::io ;

fn main() {
    println!("Enter a word!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entryword : &str = inline.trim( ) ;
    let mut forward_chars : Vec<char> = Vec::new( ) ;
    for c in entryword.chars( ) {
       forward_chars.push( c ) ;
    }
    let mut backward_chars : Vec<char> = Vec::new( ) ;
    for c in entryword.chars( ).rev( ) {
       backward_chars.push( c ) ;
    }
    let forward_pairs : Vec<&[char]> = forward_chars[..].windows( 2 ).collect( );
    let backward_pairs : Vec<&[char]> = backward_chars[..].windows( 2 ).
       collect( ) ;
    println!("{}" , forward_pairs.iter( ).any( |p| backward_pairs.contains( &p ))
          ) ;
}
