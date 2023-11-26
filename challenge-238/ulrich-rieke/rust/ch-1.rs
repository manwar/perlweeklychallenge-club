use std::io ;

fn main() {
    println!("Enter some integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s |
	  s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut result : Vec<i32> = Vec::new( ) ;
    let mut current_sum : i32 = 0 ;
    let len = numbers.len( ) ;
    for i in 0..len {
       current_sum += numbers[ i ] ;
       result.push( current_sum ) ;
    }
    println!("{:?}" , result ) ;
}
