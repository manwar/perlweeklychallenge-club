use std::io ;
use itertools::Itertools ;

fn main() {
    println!("Enter at least 3 integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map ( | s |
      s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    if numbers.len( ) == 3 {
      println!("{}" , numbers.iter( ).product::<i32>( ) ) ;
    }
    else {
      let mut products : Vec<i32> = Vec::new( ) ;
      let it = numbers.into_iter( ).combinations( 3 ) ;
      for a_vec in it {
      products.push( a_vec.iter( ).product( ) ) ;
      }
      println!("{}" , products.iter( ).max( ).unwrap( ) ) ;
    }
}
