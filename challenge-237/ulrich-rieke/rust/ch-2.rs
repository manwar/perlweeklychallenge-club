use std::io ;
use itertools::Itertools ;

fn main() {
    println!("Enter some integers , separated by spaces!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( & mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s |
	  s.trim( ).parse::<i32>().unwrap( )).collect( ) ;
    let original_numbers : Vec<i32> = numbers.clone( ) ;
    let len : usize = numbers.len( ) ;
    let mut max_greatness : usize = 0 ;
    let it = numbers.into_iter( ).permutations( len ) ;
    for v in it {
       let mut current_greatness : usize = 0 ;
       for i in 0..len {
	  if v[ i ] > original_numbers[ i ] {
	     current_greatness += 1 ;
	  }
       }
       if current_greatness > max_greatness {
	  max_greatness = current_greatness ;
       }
    }
    println!("{}" , max_greatness ) ;
}
