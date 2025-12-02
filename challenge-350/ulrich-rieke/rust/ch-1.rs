use std::io ;
use std::collections::HashSet ;

fn main() {
    println!("Enter a string!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let trimmed = inline.trim( ) ;
    let mut entered_chars : Vec<char> = Vec::new( ) ;
    for c in trimmed.chars( ) {
        entered_chars.push( c ) ;
    }
    let inslice = &entered_chars[..] ;
    let mut count : usize = 0 ;
    for subslice in inslice.windows( 3 ) {
        let mut uniques : HashSet<char> = HashSet::new( ) ; 
        for i in 0..3 {
            uniques.insert( subslice[i] ) ;
        }
        if uniques.len( ) == 3 {
            count += 1 ;
        }
    }
    println!("{}" , count ) ;
}
