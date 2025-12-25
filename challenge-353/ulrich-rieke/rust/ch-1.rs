use std::io ;
use std::io::BufRead ;

fn main() -> io::Result<( )> {
    println!("Enter some strings with several words , <enter> to end!");
    let mut all_input : String = String::new( ) ;
    let mut lines = io::stdin( ).lock( ).lines( ) ;
    while let Some( line ) = lines.next( ) {
        let last_input = line.unwrap( ) ;
        if last_input.len( ) == 0 {
            break ;
        }
        else {
            all_input.push_str( &last_input ) ;
            all_input.push_str( "\n" ) ;
        }
    }
    let all_lines : Vec<&str> = all_input.trim( ).split( "\n").collect( ) ;
    let mut sizes : Vec<usize> = Vec::new( ) ;
    all_lines.iter( ).map( |s| {
            let the_words : Vec<&str> = s.split( " ").collect( ) ;
            the_words.len( ) }).for_each( |n| sizes.push( n )) ;
    println!("{}" , sizes.into_iter( ).max( ).unwrap( ) ) ;
    Ok(() )
}
