use std::io ;

fn main() {
    println!("Enter some strings, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let first_line : &str = &*inline ;
    let strings : Vec<&str> = first_line.split_whitespace( ).map( | s | 
	  s.trim( ) ).collect( ) ;
    println!("Enter a check string!" ) ;
    let mut ckstr : String = String::new( ) ;
    io::stdin( ).read_line( &mut ckstr ).unwrap( ) ;
    let second : &str = ckstr.as_str( ).trim( ) ;
    let comp : String = second.to_string( ) ;
    let mut acronym : String = String::new( ) ;
    let mut pos : usize = 0 ;
    for s in  &strings {
       if let Some( c ) = s.chars( ).next( ) {
	  let lower : char = c.to_ascii_lowercase( ) ;
	  acronym.insert( pos , lower ) ;
       }
       pos += 1 ;
    }
    println!("{}" , acronym == comp ) ;
}
