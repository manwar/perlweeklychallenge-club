use std::io ;

fn main() {
    println!("Enter a list of integers separated by blanks!");
    let mut inline : String = String::new ( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s | 
	  s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    let luckies : Vec<&i32> = numbers.iter( ).filter( |&d| {
	  let ct : usize = numbers.iter( ).filter( | &n | *n == *d ).count( ) ;
	  ct as i32 == *d 
	  } ).collect( ) ;
    let result : i32 = match luckies.len( ) {
       number if number > 1 => **luckies.iter( ).max( ).unwrap( ) ,
       number if number == 1 => *luckies[0] ,
       _                     => -1 
    } ;
    println!("{}" , result ) ;
}
