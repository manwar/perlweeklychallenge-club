use std::io ;

fn main() {
    println!("Enter some integers separated by whitespace!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s|
	  s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut partial_sums : Vec<i32> = Vec::new( ) ;
    let len : usize = numbers.len( ) ;
    let mut current : i32 = numbers[0] + numbers[1] ;
    partial_sums.push( current ) ;
    if len > 2 {
       for i in 2..len {
	  current += numbers[i] ;
	  partial_sums.push( current ) ;
       }
    }
    let mini : i32 = partial_sums.into_iter( ).min( ).unwrap( ) ;
    let primary_result : i32 = 1 - mini ;
    let result : i32 = {
       if primary_result <= 0 {
	  1
       }
       else {
	  primary_result 
       }
    } ;
    println!("{}" , result ) ;
}
