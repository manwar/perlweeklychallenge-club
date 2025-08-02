use std::io ;

fn main() {
    println!("Enter some integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s|
	  s.parse::<i32>( ).unwrap( )).collect( ) ;
    let mut my_numbers : Vec<i32> = numbers.clone( ) ;
    my_numbers.sort( ) ;
    my_numbers.dedup( ) ;
    let pairs : Vec<(usize, i32)> = my_numbers.into_iter( ).enumerate( ).
       map( |p| (p.0 + 1 , p.1) ).collect( ) ;
    let mut solution : Vec<usize> = Vec::new( ) ;
    for n in numbers {
       pairs.iter( ).filter( |&p| p.1 == n ).for_each( |p|
	     solution.push( p.0 )) ;
    }
    println!("{:?}" , solution ) ;
}
