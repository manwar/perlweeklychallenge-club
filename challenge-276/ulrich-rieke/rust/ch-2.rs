use std::io ;
use std::collections::HashMap ;

fn main() {
    println!("Enter some positive integers!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let numbers : Vec<u32> = entered_line.split_whitespace( ).map( | s | 
	  s.parse::<u32>( ).unwrap( ) ).collect( ) ;
    let mut frequencies : HashMap<u32 , usize> = HashMap::new( ) ;
    for i in numbers {
       frequencies.entry( i ).and_modify( |n| {*n += 1} ).or_insert( 1 ) ;
    }
    let max_freq : usize = *frequencies.values( ).max( ).unwrap( ) ;
    let mut number : usize = 0 ; //how many numbers have maximum frequency ?
    for (_  , v) in &frequencies {
       if *v == max_freq {
	  number += 1 ;
       }
    }
    println!("{}" , number * max_freq) ;
}
