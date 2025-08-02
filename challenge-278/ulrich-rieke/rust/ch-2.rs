use std::io ;

fn main() {
    println!("Enter a string and a single character , separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let words : Vec<&str> = entered_line.split_whitespace( ).collect( ) ;
    let haystack : &str = words[0] ;
    let needle : &str = words[1] ;
    if haystack.contains( &needle ) {
       let mut result : String = String::new( ) ;
       let pos : usize = haystack.find( &needle ).unwrap( ) ;
       let mut characters : Vec<char> = Vec::new( ) ;
       for c in haystack[0..=pos].chars( ) {
	  characters.push( c ) ;
       }
       characters.sort( ) ;
       for c in characters {
	  result.push( c ) ;
       }
       if ( pos + 1 ) < haystack.len( ) {
	  result.push_str( &haystack[pos + 1 ..] ) ;
       }
       println!("{:?}" , result ) ;
    }
    else {
       println!("{:?}" , haystack ) ;
    }
}
