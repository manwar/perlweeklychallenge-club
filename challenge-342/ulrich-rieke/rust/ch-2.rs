use std::io ;

fn main() {
    println!("Enter a string consisting of 1 and 0 only!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let input : &str = inline.trim( ) ;
    let len : usize = input.chars( ).count( ) ;
    let mut splitscores : Vec<usize> = Vec::new( ) ;
    for pos in 1..len {
       let zeroes : usize = input.chars( ).take( pos ).filter( |c| 
	     *c == '0' ).count( ) ;
       let ones : usize = input.chars( ).skip( pos ).filter( |c| 
	     *c == '1').count( ) ;
       splitscores.push( zeroes + ones ) ;
    }
    println!("{}" , splitscores.into_iter( ).max( ).unwrap( ) ) ;
}
