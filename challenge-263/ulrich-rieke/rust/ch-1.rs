use std::io ;

fn main() {
    println!("Enter some integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let mut numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s |
	  s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    println!("Enter a target integer!" ) ;
    let mut secline : String = String::new( ) ;
    io::stdin( ).read_line( &mut secline ).unwrap( ) ;
    let kline : &str = &*secline ;
    let k : i32 = kline.trim( ).parse::<i32>().unwrap( ) ;
    numbers.sort( ) ;
    println!("{:?}" , numbers.iter( ).enumerate().filter( |( _ , b)| 
	     **b == k ).map( |( a, _) | a ).collect::<Vec<usize>>( ) ) ;
}
