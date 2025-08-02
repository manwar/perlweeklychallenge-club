use std::io ;

fn main() {
    println!("Enter an alphabetic string!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( & mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let letters : Vec<char> = entered_line.chars( ).collect( ) ;
    let letterslice = &letters[..] ;
    let mut count : u8 = 0 ;
    let mut iter = letterslice.windows( 2 ) ;
    while let Some( pair ) = iter.next( ) {
       let first_char : char = pair[0].to_ascii_lowercase( ) ;
       let second_char : char = pair[1].to_ascii_lowercase( ) ;
       if first_char != second_char {
	  count += 1 ;
       }
    }
    println!("{}" , count ) ;
}
