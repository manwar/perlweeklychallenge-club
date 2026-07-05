use std::io ;


fn main() {
    println!("Enter a string!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let word : &str = inline.trim( ) ;
    let mut value : u32 = 0 ;
    let mut pos : u32 = 1 ;
    for c in word.chars( ) {
       value += pos * ( 123u32 - c as u32 ) ;
       pos += 1 ;
    }
    println!("{}" , value ) ;
}
