use std::io ;
use itertools::Itertools ;
use std::collections::HashSet ;

fn my_condition( my_vector : &Vec<&i32> ) -> bool {
  let mut differences : HashSet<i32> = HashSet::new( ) ;
  let len = my_vector.len( ) ;
  for i in 0..=len - 2 {
      differences.insert( *my_vector[ i + 1 ] - *my_vector[ i ] ) ;
  }
  differences.len( ) == 1
}

fn main() {
  println!("Please enter some integers, separated by a blank!") ;
  let mut inline : String = String::new( ) ;
  io::stdin( ).read_line( &mut inline ).unwrap( ) ;
  let entered_line : &str = &*inline ;
  let numbers : Vec<i32> = entered_line.split_whitespace( ).
      map( | s | s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
  let len = numbers.len( ) ;
  if len >= 3 {
      let mut fulfilled = false ;
      for i in 3..=len {
    let mut it =  numbers.iter( ).combinations( i ) ;
    while let Some( combi ) = it.next( ) {
        if my_condition( &combi ) {
          println!("{:?}" , combi ) ;
          fulfilled = true ;
        }
    }
      }
      if ! fulfilled {
    println!("()") ;
      }
  }
  else {
      println!("()") ;
  }
}
