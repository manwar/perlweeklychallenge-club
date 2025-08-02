use std::io ;

fn main() {
    println!("Enter a word!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let mut capitals : Vec<char> = entered_line.trim( ).chars( ).
       filter( | &c | {
	     let d = c.to_ascii_lowercase( ) ;
	     c.is_uppercase( ) && entered_line.contains( d ) 
	     }).collect( ) ;
    let len = capitals.len( ) ;
    if len > 0 {
       capitals.sort( ) ;
       println!("{}" , capitals[len - 1] ) ;
    }
    else {
       println!("''") ;
    }
}
