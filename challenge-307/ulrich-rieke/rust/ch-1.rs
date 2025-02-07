use std::io ;

fn main() {
    println!("Enter some integers separated by whitespace!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s|
	  s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    let original_positions : Vec<(usize, &i32)> = numbers.iter( ).enumerate( ).
       collect( ) ;
    let mut sorted : Vec<i32> = numbers.clone( ) ;
    sorted.sort( ) ;
    let new_positions : Vec<(usize, i32)> = sorted.into_iter( ).enumerate( ).
       collect( ) ;
    let mut result : Vec<usize> = Vec::new( ) ;
    original_positions.into_iter().zip( new_positions.into_iter( )).filter( 
     |&(a , b)| *a.1 != b.1 ).for_each( |p| result.push( p.0.0 )) ;
    println!("{:?}" , result) ;
}
