use std::io ;
use itertools::Itertools ;

fn main() {
    println!("Enter some integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s |
      s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    let len : usize = numbers.len( ) ;
    let mut possible_solutions : Vec<Vec<i32>> = Vec::new( ) ;
    for v in numbers.into_iter( ).permutations( len ) {
      if (0..len - 1 ).into_iter( ).all( | i | {
        let sum : i32 = &v[ i ] + &v[ i + 1 ] ;
        let rootint : i32 = (sum as f64 ).sqrt( ).floor( ) as i32 ;
        sum == rootint * rootint
        }
      ) {
    possible_solutions.push( v ) ;
      }
    }
    println!("{:?}" , possible_solutions ) ;
}
