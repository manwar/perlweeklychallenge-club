use std::io ;
use itertools::Itertools ;

fn main() {
    println!("Print a number of integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map(
      | s | s.trim( ).parse::<i32>().unwrap( )).collect( ) ;
    let mut the_max : i32 = 0 ;
    let mut iter = numbers.into_iter( ).combinations( 2 ) ;
    while let Some( v ) = iter.next( ) {
      if v[0] != v[1] {
      let val : i32 = v[0] ^ v[1] ;
      if val > the_max {
        the_max = val ;
      }
      }
    }
    println!("{}" , the_max) ;
}
