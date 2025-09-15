use std::io ;

fn main() {
    println!("Please enter some integers as a sequence height differences!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let differences : Vec<i32>= inline.trim( ).split_whitespace( ).map( |s|
	  s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut heights : Vec<i32> = vec![0] ;
    let mut currentheight : i32 = 0 ;
    for d in &differences {
       currentheight += *d ;
       heights.push( currentheight ) ;
    }
    println!("{}" , heights.into_iter( ).max( ).unwrap( ) ) ;
}
