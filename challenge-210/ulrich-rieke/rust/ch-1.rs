use std::io ;
use std::collections::HashSet ;

fn main() {
    println!("Please enter some integers, separated by a blank!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s |
      s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut different_numbers : HashSet<i32> = HashSet::new( ) ;
    for i in &numbers {
      different_numbers.insert( *i ) ;
    }
    let mut iter = different_numbers.iter( ) ;
    let mut all_sums : Vec<i32> = Vec::new( ) ;
    while let Some( num ) = iter.next( ) {
      let mut sum : i32 = 0 ;
      numbers.iter( ).filter( | i | **i == *num - 1 || **i == *num || **i ==
        *num + 1 ).for_each( | i | sum += *i ) ;
      all_sums.push( sum ) ;
    }
    println!("{}" , all_sums.iter( ).max( ).unwrap( ) ) ;
}
