use std::io ;
use itertools::Itertools ;

fn main() {
    println!("Enter some integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s | 
	  s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut sum : i32 = 0 ;
    let len = numbers.len( ) ;
    for i in &numbers {
       sum += i.pow( 2 ) * i ;
    }
    for l in 2..=len {
       let it = numbers.iter( ).combinations( l ) ;
       for vec in it {
	  let my_max = vec.iter( ).max( ).unwrap( ) ;
	  let my_min = vec.iter( ).min( ).unwrap( ) ;
	  sum += my_max.pow( 2 ) * **my_min ;
       }
    }
    println!("{}" , sum ) ;
}
