use std::io ;

fn main() {
    println!("Enter some integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s| 
	  s.parse::<i32>( ).unwrap( )).collect( ) ;
    println!( "Enter a pair of indices valid into the above numbers!") ;
    let mut indexline : String = String::new( ) ;
    io::stdin( ).read_line( &mut indexline ).unwrap( ) ;
    let indices : Vec<usize> = indexline.trim( ).split_whitespace( ).map( |s|
	  s.parse::<usize>( ).unwrap( )).collect( ) ;
    println!("{}" , numbers.into_iter( ).skip( indices[0] ).take( indices[1]
	     - indices[0] + 1 ).sum::<i32>( ) ) ;
}
