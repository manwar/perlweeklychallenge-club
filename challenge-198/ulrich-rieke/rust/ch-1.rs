use std::io ;

fn main() {
    println!("Enter some integers, separated by a blank!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let mut numbers : Vec<i32> = entered_line.split_whitespace( ).
      map( | s | s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    if numbers.len( ) < 2 {
      println!("0") ;
    }
    else {
      numbers.sort( ) ;
      let mut differences : Vec<i32> = Vec::new( ) ;
      let len = numbers.len( ) ;
      for i in 0..=len - 2 {
      differences.push( numbers[ i + 1 ] - numbers[ i ] ) ;
      }
      let maxdiff = differences.iter( ).max( ).unwrap( ) ;
      println!("{}" , differences.iter( ).filter( | i | *i == maxdiff ).
        count( ) ) ;
    }
}
