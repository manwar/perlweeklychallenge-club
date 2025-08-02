use std::io ;

fn main() {
    println!("Enter a valid IPv4 address!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let result : String = entered_line.replace("." , "[.]" ) ;
    println!("{}" , result ) ;
}
