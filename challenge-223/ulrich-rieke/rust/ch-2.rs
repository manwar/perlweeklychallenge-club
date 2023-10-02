use std::io ;
use std::cmp ;

fn find_elimination_pos( array : &Vec<i32>) -> usize {
  let len : usize = array.len( ) ;
  let position : usize = match len {
      0 => 0 ,
      1 => 0 ,
      2 => {
    let minimum = cmp::min( array[0] , array[1] ) ;
    let pos = array.iter( ).position( | x | *x == minimum ).unwrap( ) ;
    pos } ,
      3 => 1 ,
      _ => {
    let minimum = array.iter( ).min( ).unwrap( ) ;
    let howmany = array.iter( ).filter( | x | *x == minimum ).count( ) ;
    if howmany > 1 {
        let mut maxpos : usize = 0 ;
        let mut max_product : i32 = 0 ;
        for i in 1..len - 1 {
          if array[ i ] == *minimum {
          let product : i32 = array[ i - 1 ] * array[ i ] *
            array[ i + 1 ] ;
          if product > max_product {
            max_product = product ;
            maxpos = i ;
          }
          }
        }
        maxpos
    }
    else {
        let pos = array.iter( ).position( | &x | x == *minimum ).
          unwrap( );
        pos
    }
      } ,
  } ;
  position
}

fn main() {
  //the strategy for solution : If the array has one element, we have
  //no choice. If the array has 2 elements we eliminate the smaller of the
  //2. If it has more than 2 , we have no choice if it has 3 elements.
  //If it has more than 3 elements , we eliminate the smallest of the
  //possible central elements ; if these minima occur more than once
  //we eliminate those with the greatest product with their neighbours
    println!("Please enter some integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let mut numbers : Vec<i32> = entered_line.split_whitespace( ).map(
      | s | s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut len : usize = numbers.len ( ) ;
    if len == 1 {
      println!("{}" , numbers[ 0 ] ) ;
    }
    else {
      let mut the_sum : i32 = 0 ;
      while len > 1 {
      let pos : usize = find_elimination_pos( &numbers ) ;
      match pos {
        0 => the_sum +=  1 * numbers[ 0 ]
        * numbers[ pos + 1 ]  ,
        a_pos if a_pos >= 1 && a_pos < len - 1 =>
        the_sum +=  numbers[ a_pos - 1 ] * numbers[ a_pos ] *
              numbers[ a_pos + 1 ]  ,
        a_pos if a_pos == len - 1 => the_sum +=  numbers[ a_pos - 1 ]
        * numbers[ a_pos ]  ,
          _ => { } ,
      } ;
      numbers.remove( pos ) ;
      len = numbers.len( ) ;
    }
    the_sum += numbers[0] ;
    println!("{}" , the_sum ) ;
    }
}
