use std::io ;

fn main() {
    println!("Enter some strings, separated by whitespace!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let strings : Vec<&str> = entered_line.split_whitespace( ).map( 
	  | s | s.trim( ) ).collect( ) ;
    println!("Enter a separator!") ;
    let mut sep_line : String = String::new( ) ;
    io::stdin( ).read_line( &mut sep_line ).unwrap( ) ;
    let separator : &str = &*sep_line ;
    let changed = separator.trim( ) ;
    let mut result : Vec<&str> = Vec::new( ) ;
    for s in &strings {
       let v : Vec<&str> = s.split( changed ).collect( ) ;
       for substr in &v {
	  if substr.len( ) > 0 {
	     result.push( substr ) ;
	  }
       }
    }
    println!("{:?}" , result ) ;
}
