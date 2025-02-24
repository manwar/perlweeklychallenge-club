use std::io ;

fn main() {
    println!("Enter some integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( & mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s|
	  s.parse::<i32>( ).unwrap( )).collect( ) ;
    let mut evens : Vec<i32> = Vec::new( ) ;
    let mut odds : Vec<i32> = Vec::new( ) ;
    numbers.iter( ).enumerate().filter( |(i , _)| i % 2 == 0 ).for_each( 
	  |(_ , n)| evens.push( *n ) ) ;
    numbers.iter( ).enumerate( ).filter( |(i , _)| i % 2 == 1 ).for_each( 
       |(_ , n)| odds.push( *n ) ) ;
    evens.sort( ) ;
    odds.sort_by( |a , b| b.cmp( &a ) ) ;
    let mut merged : Vec<i32> = Vec::new( ) ;
    for i in 0..numbers.len( ) {
       let next_num : i32 ;
       if i % 2 == 0 {
	  next_num = evens.remove( 0 ) ;
       }
       else {
	  next_num = odds.remove( 0 ) ;
       }
       merged.push( next_num ) ;
    }
    println!("{:?}" , merged ) ;
}
