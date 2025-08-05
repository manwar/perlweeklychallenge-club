use std::io ;

fn main() {
    println!("Enter some integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s|
	  s.parse::<i32>( ).unwrap( )).collect( ) ;
    let mut after_doubling : Vec<i32> = Vec::new( ) ;
    let len : usize = numbers.len( ) ;
    for n in numbers {
       if n == 0 {
	  after_doubling.push( 0 ) ;
	  after_doubling.push( 0 ) ;
       }
       else {
	  after_doubling.push( n ) ;
       }
    }
    println!("{:?}" , after_doubling.into_iter( ).take( len ).
	  collect::<Vec<i32>>( ) ) ;
}
