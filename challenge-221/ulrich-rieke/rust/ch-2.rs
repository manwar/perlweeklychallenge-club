use std::io ;
use itertools::Itertools ;

fn is_arithmetic( a_vec : &Vec<i32> ) -> bool {
  let len = a_vec.len( ) ;
  let start = a_vec[1] - a_vec[0] ;
  for i in 1..len - 1 {
      if a_vec[i + 1] - a_vec[ i ] != start {
    return false ;
      }
  }
  true
}

//the idea is : find the powerset of the numbers entered, that is
//the set of all sets. Extract those sets that are arithmetic , and
//find their maximum length
fn main() {
    println!("Enter some integers, separated by blanks!") ;
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s |
      s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    if is_arithmetic( &numbers ) {
      println!("{}" , numbers.len( ) ) ;
    }
    else {
      let all_subsets : Vec<Vec<i32>> = numbers.into_iter( ).
      powerset( ).collect( ) ;
      let mut max_len : usize = 0 ;
      for v in all_subsets {
      let v_len = v.len( ) ;
      if v_len > 1 && is_arithmetic( &v ) {
        if v_len > max_len {
        max_len = v_len ;
        }
      }
      }
      println!("{}" , max_len ) ;
    }
}
