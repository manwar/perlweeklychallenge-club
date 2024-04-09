use std::io ;

fn main() {
    println!("Enter some integers, separated by whitespace!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s |
	  s.trim( ).parse::<i32>().unwrap( ) ).collect( ) ;
    println!("Enter some indices into the number array!") ;
    let mut secline : String = String::new( ) ;
    io::stdin( ).read_line( &mut secline ).unwrap( ) ;
    let index_line : &str = &*secline ;
    let indices : Vec<usize> = index_line.split_whitespace( ).map( | s |
	  s.trim( ).parse::<usize>( ).unwrap( )).collect( ) ;
    let mut target : Vec<i32> = Vec::new( ) ;
    let pairs : Vec<(&i32, &usize)> = numbers.iter( ).zip( indices.iter( ) ).
       collect( ) ;
    for p in pairs {
       if target.len( ) == 0 {
	  target.push( numbers[ 0 ] ) ;
       }
       else {
	  target.insert( *p.1 , *p.0 ) ;
       }
    }
    println!("{:?}" , target) ;
}
