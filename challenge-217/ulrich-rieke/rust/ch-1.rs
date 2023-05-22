use std::io ;
use std::io::BufRead ;

fn main() {
    println!("Enter at least 2 lines of a matrix with at least 2 numbers each!");
    println!( "Enter end to end!" ) ;
    let mut all_numbers : Vec<String> = Vec::new( ) ;
    for line in io::stdin( ).lock( ).lines( ) {
      let inline : String = line.unwrap( ) ;
      if inline != "end" {
      all_numbers.push( inline ) ;
      }
      else {
      break ;
      }
    }
    let mut numbers : Vec<i32> = Vec::new( ) ;
    for s in all_numbers {
      let nums : Vec<i32> = s.as_str( ).split_whitespace( ).map( | s |
        s.parse::<i32>( ).unwrap( )).collect( ) ;
      for i in nums {
      numbers.push( i ) ;
      }
    }
    numbers.sort( ) ;
    println!("{}" , numbers[2] ) ;
}
