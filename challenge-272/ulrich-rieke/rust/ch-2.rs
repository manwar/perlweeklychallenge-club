use std::io ;

fn main() {
    println!("Enter a word!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let mut letters : Vec<char> = Vec::new( ) ;
    for c in entered_line.chars( ) {
       letters.push( c ) ;
    }
    let char_slice = &letters[..] ;
    let mut iter = char_slice.windows( 2 ) ;
    let mut result : u8 = 0 ;
    while let Some( pair ) = iter.next( ) {
       let first_value : u8 = pair[0] as u8 ;
       let second_value : u8 = pair[1] as u8 ;
       result += (first_value as i16 - second_value as i16).abs( ) as u8 ;
    }
    println!("{}" , result) ;
}
