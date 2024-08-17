use std::io ;

fn main() {
    println!("Enter a word!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let mut result : bool = false ;
    if entered_line.contains( "b" ) {
       let bpos : usize = entered_line.find( "b" ).unwrap( ) ;
       let ( _ , second ) = entered_line.split_at( bpos ) ;
       if ! second.contains( "a" ) {
	  result = true ;
       }
    }
    println!("{}" , result) ;
}
