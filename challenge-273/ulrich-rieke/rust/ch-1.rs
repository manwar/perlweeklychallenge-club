use std::io ;

fn main() {
    println!("Enter a word!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let word_line : &str = inline.as_str( ).trim( ) ;
    println!("Enter a character!" ) ;
    let mut cline : String = String::new( ) ;
    io::stdin( ).read_line( &mut cline ).unwrap( ) ;
    let charline : &str = cline.as_str( ).trim( ) ;
    let needle : char = charline.chars( ).nth( 0 ).unwrap( ) ;
    let frequency = word_line.chars( ).filter( | c | *c == needle ).
       count( ) ;
    let result : u8 = ((frequency as f32 / word_line.chars( ).count( ) as f32) 
       * 100.0).round( ) as u8 ;
    println!("{}" , result ) ;
}
